import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../members/domain/entities/member.dart';
import '../../../members/presentation/providers/members_providers.dart';
import '../models/risk_controls_ui_state.dart';
import '../providers/risk_controls_domain_providers.dart';

class RiskControlsController
    extends AutoDisposeAsyncNotifier<RiskControlsUiState?> {
  String? _shomitiId;
  List<Member> _members = const [];

  @override
  Future<RiskControlsUiState?> build() => _load();

  Future<RiskControlsUiState?> _load() async {
    final context = await ref.watch(membersContextProvider.future);
    if (context == null) return null;

    await ref.watch(seedMembersProvider)(
      shomitiId: context.shomitiId,
      memberCount: context.rules.memberCount,
    );

    _shomitiId = context.shomitiId;
    _members = await ref
        .watch(membersRepositoryProvider)
        .listMembers(shomitiId: context.shomitiId);

    final repo = ref.watch(riskControlsRepositoryProvider);
    final guarantors = await repo.listGuarantors(shomitiId: context.shomitiId);
    final deposits = await repo.listSecurityDeposits(
      shomitiId: context.shomitiId,
    );

    final guarantorByMemberId = {for (final g in guarantors) g.memberId: g};
    final depositByMemberId = {for (final d in deposits) d.memberId: d};

    final rows = [
      for (final m in _members)
        RiskControlRow(
          memberId: m.id,
          position: m.position,
          displayName: m.fullName,
          status: _statusFor(
            hasGuarantor: guarantorByMemberId.containsKey(m.id),
            depositReturnedAt: depositByMemberId[m.id]?.returnedAt,
            hasDeposit: depositByMemberId.containsKey(m.id),
          ),
        ),
    ];

    return RiskControlsUiState(rows: List.unmodifiable(rows));
  }

  RiskControlStatus _statusFor({
    required bool hasGuarantor,
    required bool hasDeposit,
    required DateTime? depositReturnedAt,
  }) {
    if (hasGuarantor) return RiskControlStatus.guarantorRecorded;
    if (hasDeposit && depositReturnedAt == null) {
      return RiskControlStatus.depositRecorded;
    }
    if (hasDeposit && depositReturnedAt != null) {
      return RiskControlStatus.depositReturned;
    }
    return RiskControlStatus.missing;
  }

  Future<void> recordGuarantor({
    required String memberId,
    required String name,
    required String phone,
    String? relationship,
    String? proofRef,
  }) async {
    final shomitiId =
        _shomitiId ??
        (await ref.watch(membersContextProvider.future))?.shomitiId;
    if (shomitiId == null) return;

    await ref.watch(recordGuarantorProvider)(
      shomitiId: shomitiId,
      memberId: memberId,
      name: name,
      phone: phone,
      relationship: relationship,
      proofRef: proofRef,
    );

    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }

  Future<void> recordSecurityDeposit({
    required String memberId,
    required int amountBdt,
    required String heldBy,
    String? proofRef,
  }) async {
    final shomitiId =
        _shomitiId ??
        (await ref.watch(membersContextProvider.future))?.shomitiId;
    if (shomitiId == null) return;

    await ref.watch(recordSecurityDepositProvider)(
      shomitiId: shomitiId,
      memberId: memberId,
      amountBdt: amountBdt,
      heldBy: heldBy,
      proofRef: proofRef,
    );

    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }

  Future<void> markDepositReturned({
    required String memberId,
    String? proofRef,
  }) async {
    final shomitiId =
        _shomitiId ??
        (await ref.watch(membersContextProvider.future))?.shomitiId;
    if (shomitiId == null) return;

    await ref.watch(markSecurityDepositReturnedProvider)(
      shomitiId: shomitiId,
      memberId: memberId,
      proofRef: proofRef,
    );

    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }
}

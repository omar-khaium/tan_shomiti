import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../members/domain/entities/member.dart';
import '../../domain/usecases/shares_exceptions.dart';
import '../models/shares_ui_state.dart';
import '../providers/shares_context_providers.dart';
import '../providers/shares_domain_providers.dart';

class SharesController extends AutoDisposeAsyncNotifier<SharesUiState?> {
  Map<String, int>? _sharesByMemberId;
  SharesContext? _context;
  List<Member> _members = const [];

  @override
  Future<SharesUiState?> build() async {
    final context = await ref.watch(sharesContextProvider.future);
    if (context == null) return null;
    _context = context;

    final members = await ref
        .watch(sharesMembersRepositoryProvider)
        .listMembers(shomitiId: context.shomitiId);
    _members = members;

    final memberIds = members.map((m) => m.id).toList(growable: false);
    _sharesByMemberId = await ref.watch(seedShareAllocationsProvider)(
      shomitiId: context.shomitiId,
      memberIds: memberIds,
      totalShares: context.rules.cycleLengthMonths,
      maxSharesPerPerson: context.rules.maxSharesPerPerson,
      now: DateTime.now(),
    );

    return _buildState();
  }

  void increment(String memberId) {
    final current = state.valueOrNull;
    if (current == null || _sharesByMemberId == null) return;

    final context = _context;
    if (context == null) return;

    ref
        .read(adjustMemberSharesProvider)(
          shomitiId: context.shomitiId,
          memberId: memberId,
          delta: 1,
          totalShares: context.rules.cycleLengthMonths,
          maxSharesPerPerson: context.rules.maxSharesPerPerson,
          now: DateTime.now(),
        )
        .then((map) {
          _sharesByMemberId = map;
          state = AsyncValue.data(_buildState());
        })
        .catchError((Object error) {
          if (error is SharesAllocationException) return;
          state = AsyncValue.error(error, StackTrace.current);
        });
  }

  void decrement(String memberId) {
    final current = state.valueOrNull;
    if (current == null || _sharesByMemberId == null) return;
    final context = _context;
    if (context == null) return;

    ref
        .read(adjustMemberSharesProvider)(
          shomitiId: context.shomitiId,
          memberId: memberId,
          delta: -1,
          totalShares: context.rules.cycleLengthMonths,
          maxSharesPerPerson: context.rules.maxSharesPerPerson,
          now: DateTime.now(),
        )
        .then((map) {
          _sharesByMemberId = map;
          state = AsyncValue.data(_buildState());
        })
        .catchError((Object error) {
          if (error is SharesAllocationException) return;
          state = AsyncValue.error(error, StackTrace.current);
        });
  }

  SharesUiState? _buildState() {
    final context = _context;
    final map = _sharesByMemberId;
    if (context == null || map == null) return null;

    return SharesUiState.from(
      shomitiId: context.shomitiId,
      ruleSetVersionId: context.ruleSetVersionId,
      rules: context.rules,
      members: _members,
      sharesByMemberId: map,
    );
  }
}

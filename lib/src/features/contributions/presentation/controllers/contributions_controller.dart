import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../members/presentation/providers/members_providers.dart';
import '../../../shares/presentation/providers/shares_domain_providers.dart';
import '../models/contributions_ui_state.dart';

class ContributionsController
    extends AutoDisposeAsyncNotifier<ContributionsUiState?> {
  DateTime? _month;

  @override
  Future<ContributionsUiState?> build() async {
    _month ??= _normalizeMonth(DateTime.now());
    return _load();
  }

  Future<ContributionsUiState?> _load() async {
    final context = await ref.watch(membersContextProvider.future);
    if (context == null) return null;

    await ref.watch(seedMembersProvider)(
      shomitiId: context.shomitiId,
      memberCount: context.rules.memberCount,
    );

    final members = await ref
        .watch(membersRepositoryProvider)
        .listMembers(shomitiId: context.shomitiId);

    final memberIds = members.map((m) => m.id).toList(growable: false);
    final sharesByMemberId = await ref.watch(seedShareAllocationsProvider)(
      shomitiId: context.shomitiId,
      memberIds: memberIds,
      totalShares: context.rules.cycleLengthMonths,
      maxSharesPerPerson: context.rules.maxSharesPerPerson,
      now: DateTime.now(),
    );

    final shareValue = context.rules.shareValueBdt;
    final rows = <MonthlyDueRow>[
      for (final m in members)
        MonthlyDueRow(
          memberId: m.id,
          position: m.position,
          displayName: m.fullName,
          shares: sharesByMemberId[m.id] ?? 0,
          dueAmountBdt: (sharesByMemberId[m.id] ?? 0) * shareValue,
        ),
    ];

    final total = rows.fold<int>(0, (sum, r) => sum + r.dueAmountBdt);

    return ContributionsUiState(
      month: _month!,
      totalDueBdt: total,
      rows: List.unmodifiable(rows),
    );
  }

  Future<void> previousMonth() async {
    _month = DateTime(_month!.year, _month!.month - 1);
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }

  Future<void> nextMonth() async {
    _month = DateTime(_month!.year, _month!.month + 1);
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }

  DateTime _normalizeMonth(DateTime date) => DateTime(date.year, date.month);
}


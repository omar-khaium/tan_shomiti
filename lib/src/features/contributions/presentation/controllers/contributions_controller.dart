import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../members/presentation/providers/members_providers.dart';
import '../../../shares/presentation/providers/shares_domain_providers.dart';
import '../../domain/value_objects/billing_month.dart';
import '../models/contributions_ui_state.dart';
import '../providers/contributions_context_providers.dart';
import '../providers/contributions_domain_providers.dart';

class ContributionsController
    extends AutoDisposeAsyncNotifier<ContributionsUiState?> {
  BillingMonth? _month;

  @override
  Future<ContributionsUiState?> build() async {
    _month ??= BillingMonth.fromDate(DateTime.now());
    return _load();
  }

  Future<ContributionsUiState?> _load() async {
    final context = await ref.watch(contributionsContextProvider.future);
    if (context == null) return null;

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

    final month = _month!;
    final repo = ref.watch(monthlyDuesRepositoryProvider);
    final existing = await repo.getDueMonth(
      shomitiId: context.shomitiId,
      month: month,
    );
    if (existing == null) {
      await ref.watch(generateMonthlyDuesProvider)(
        shomitiId: context.shomitiId,
        ruleSetVersionId: context.ruleSetVersionId,
        month: month,
        shareValueBdt: context.rules.shareValueBdt,
        sharesByMemberId: sharesByMemberId,
      );
    }

    final dues = await repo.listMonthlyDues(
      shomitiId: context.shomitiId,
      month: month,
    );
    final dueByMemberId = {for (final d in dues) d.memberId: d};

    final rows = <MonthlyDueRow>[
      for (final m in members)
        MonthlyDueRow(
          memberId: m.id,
          position: m.position,
          displayName: m.fullName,
          shares: dueByMemberId[m.id]?.shares ?? 0,
          dueAmountBdt: dueByMemberId[m.id]?.dueAmountBdt ?? 0,
        ),
    ];

    final total = rows.fold<int>(0, (sum, r) => sum + r.dueAmountBdt);

    return ContributionsUiState(
      month: month,
      totalDueBdt: total,
      rows: List.unmodifiable(rows),
    );
  }

  Future<void> previousMonth() async {
    _month = _month!.previous();
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }

  Future<void> nextMonth() async {
    _month = _month!.next();
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }
}

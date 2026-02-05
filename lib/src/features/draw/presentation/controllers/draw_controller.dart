import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';
import '../models/draw_ui_state.dart';
import '../providers/draw_context_providers.dart';
import '../providers/draw_domain_providers.dart';

class DrawController extends AutoDisposeAsyncNotifier<DrawUiState> {
  BillingMonth? _month;

  @override
  Future<DrawUiState> build() async {
    _month ??= BillingMonth.fromDate(DateTime.now());
    return _load();
  }

  Future<DrawUiState> _load() async {
    final context = await ref.watch(drawContextProvider.future);
    if (context == null) {
      return DrawUiState(
        shomitiId: 'unknown',
        ruleSetVersionId: 'unknown',
        month: _month!,
        hasDuesForMonth: false,
        summary: const DrawEligibilitySummary(
          eligibleEntries: 0,
          ineligibleEntries: 0,
          ineligibleReasons: {},
        ),
        rows: const [],
        eligibleShares: const [],
        recordedDrawId: null,
      );
    }

    final month = _month!;
    final recorded = await ref.watch(drawRecordsRepositoryProvider).getEffectiveForMonth(
      shomitiId: context.shomitiId,
      month: month,
    );
    final result = await ref.watch(computeDrawEligibilityProvider)(
      shomitiId: context.shomitiId,
      month: month,
      rules: context.rules,
    );

    if (!result.hasDuesForMonth) {
      return DrawUiState(
        shomitiId: context.shomitiId,
        ruleSetVersionId: context.ruleSetVersionId,
        month: month,
        hasDuesForMonth: false,
        summary: const DrawEligibilitySummary(
          eligibleEntries: 0,
          ineligibleEntries: 0,
          ineligibleReasons: {},
        ),
        rows: const [],
        eligibleShares: const [],
        recordedDrawId: recorded?.id,
      );
    }

    final items = result.items;
    final memberNameById = <String, String>{};
    for (final item in items) {
      memberNameById.putIfAbsent(item.memberId, () => item.memberName);
    }

    final eligibleShares = [
      for (final item in items)
        if (item.isEligible)
          DrawEligibleShareUiModel(
            memberId: item.memberId,
            memberName: item.memberName,
            shareIndex: item.shareIndex,
          ),
    ];

    final ineligibleReasons = <String, int>{};
    var ineligibleEntries = 0;
    for (final item in items) {
      if (item.isEligible) continue;
      ineligibleEntries++;
      final reason = item.reason ?? 'Ineligible';
      ineligibleReasons[reason] = (ineligibleReasons[reason] ?? 0) + 1;
    }

    final eligibleByMemberId = <String, int>{};
    final shareCountByMemberId = <String, int>{};
    final ineligibleReasonsByMemberId = <String, Map<String, int>>{};

    for (final item in items) {
      shareCountByMemberId[item.memberId] =
          (shareCountByMemberId[item.memberId] ?? 0) + 1;
      if (item.isEligible) {
        eligibleByMemberId[item.memberId] =
            (eligibleByMemberId[item.memberId] ?? 0) + 1;
      } else {
        final reason = item.reason ?? 'Ineligible';
        final map = ineligibleReasonsByMemberId.putIfAbsent(
          item.memberId,
          () => <String, int>{},
        );
        map[reason] = (map[reason] ?? 0) + 1;
      }
    }

    final memberIds = shareCountByMemberId.keys.toList(growable: false);

    memberIds.sort((a, b) {
      final nameA = memberNameById[a] ?? a;
      final nameB = memberNameById[b] ?? b;
      final byName = nameA.compareTo(nameB);
      return byName != 0 ? byName : a.compareTo(b);
    });

    final rows = <DrawEligibilityRowUiModel>[];
    for (var i = 0; i < memberIds.length; i++) {
      final memberId = memberIds[i];
      final totalShares = shareCountByMemberId[memberId] ?? 0;
      final eligibleCount = eligibleByMemberId[memberId] ?? 0;
      final isEligible = eligibleCount > 0;
      final reasons = ineligibleReasonsByMemberId[memberId] ?? const {};

      String? reason;
      if (!isEligible && reasons.isNotEmpty) {
        // Pick the most important reason (by priority).
        const priority = [
          'Payment not confirmed',
          'Late (outside grace)',
          'Already won',
        ];
        reason = priority.firstWhere(
          reasons.containsKey,
          orElse: () => reasons.keys.first,
        );
      }

      rows.add(
        DrawEligibilityRowUiModel(
          position: i,
          memberId: memberId,
          memberName: memberNameById[memberId] ?? 'Member',
          shares: totalShares,
          isEligible: isEligible,
          reason: reason,
        ),
      );
    }

    return DrawUiState(
      shomitiId: context.shomitiId,
      ruleSetVersionId: context.ruleSetVersionId,
      month: month,
      hasDuesForMonth: true,
      summary: DrawEligibilitySummary(
        eligibleEntries: eligibleShares.length,
        ineligibleEntries: ineligibleEntries,
        ineligibleReasons: Map.unmodifiable(ineligibleReasons),
      ),
      rows: List.unmodifiable(rows),
      eligibleShares: List.unmodifiable(eligibleShares),
      recordedDrawId: recorded?.id,
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

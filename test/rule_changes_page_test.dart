import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_snapshot.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_version.dart';
import 'package:tan_shomiti/src/features/rules/presentation/providers/rule_changes_providers.dart';
import 'package:tan_shomiti/src/features/rules/presentation/providers/rules_viewer_providers.dart';
import 'package:tan_shomiti/src/features/rules/presentation/rule_changes_page.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const RuleChangesPage(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('Rule changes page shows loading state', (tester) async {
    final completer = Completer<RuleSetVersion?>();
    await pumpPage(
      tester,
      overrides: [
        rulesViewerProvider.overrideWith((ref) => completer.future),
        pendingRuleAmendmentProvider.overrideWith((ref) => Stream.value(null)),
        ruleAmendmentsProvider.overrideWith((ref) => Stream.value(const [])),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
  });

  testWidgets('Rule changes page shows empty state when no snapshot', (
    tester,
  ) async {
    await pumpPage(
      tester,
      overrides: [
        rulesViewerProvider.overrideWith((ref) async => null),
        pendingRuleAmendmentProvider.overrideWith((ref) => Stream.value(null)),
        ruleAmendmentsProvider.overrideWith((ref) => Stream.value(const [])),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('No rules snapshot found'), findsOneWidget);
  });

  testWidgets('Rule changes page shows error state when provider throws', (
    tester,
  ) async {
    await pumpPage(
      tester,
      overrides: [
        rulesViewerProvider.overrideWith((ref) => throw Exception('boom')),
        pendingRuleAmendmentProvider.overrideWith((ref) => Stream.value(null)),
        ruleAmendmentsProvider.overrideWith((ref) => Stream.value(const [])),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load rules.'), findsOneWidget);
  });

  testWidgets('Rule changes page shows active version id when data present', (
    tester,
  ) async {
    await pumpPage(
      tester,
      overrides: [
        rulesViewerProvider.overrideWith(
          (ref) async => RuleSetVersion(
            id: 'rsv_test',
            createdAt: DateTime(2026, 1, 1),
            snapshot: RuleSetSnapshot(
              schemaVersion: 1,
              shomitiName: 'My Shomiti',
              startDate: DateTime(2026, 1, 1),
              groupType: GroupTypePolicy.closed,
              memberCount: 2,
              shareValueBdt: 1000,
              maxSharesPerPerson: 1,
              allowShareTransfers: false,
              cycleLengthMonths: 2,
              meetingSchedule: 'Monthly',
              paymentDeadline: '5th',
              payoutMethod: PayoutMethod.cash,
              groupChannel: null,
              missedPaymentPolicy: MissedPaymentPolicy.postponePayout,
              gracePeriodDays: null,
              lateFeeBdtPerDay: null,
              defaultConsecutiveMissedThreshold: 2,
              defaultTotalMissedThreshold: 3,
              feesEnabled: false,
              feeAmountBdt: null,
              feePayerModel: FeePayerModel.everyoneEqually,
              ruleChangeAfterStartRequiresUnanimous: true,
            ),
          ),
        ),
        pendingRuleAmendmentProvider.overrideWith((ref) => Stream.value(null)),
        ruleAmendmentsProvider.overrideWith((ref) => Stream.value(const [])),
      ],
    );

    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('rule_changes_active_version_id')),
      findsOneWidget,
    );
    expect(find.text('rsv_test'), findsOneWidget);
    expect(find.byKey(const Key('rule_changes_history_empty')), findsOneWidget);
  });
}

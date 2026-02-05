import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_snapshot.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_version.dart';
import 'package:tan_shomiti/src/features/rules/presentation/providers/rules_viewer_providers.dart';
import 'package:tan_shomiti/src/features/rules/presentation/rules_page.dart';

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
          home: const RulesPage(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('Rules page shows loading state', (tester) async {
    final completer = Completer<RuleSetVersion?>();
    await pumpPage(
      tester,
      overrides: [
        rulesViewerProvider.overrideWith((ref) => completer.future),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
  });

  testWidgets('Rules page shows empty state when no snapshot', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        rulesViewerProvider.overrideWith((ref) async => null),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('No rules snapshot found'), findsOneWidget);
  });

  testWidgets('Rules page shows error state when provider throws', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        rulesViewerProvider.overrideWith((ref) => throw Exception('boom')),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load rules.'), findsOneWidget);
  });

  testWidgets('Rules page shows version id when data is present', (tester) async {
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
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('rules_version_id')), findsOneWidget);
    expect(find.text('rsv_test'), findsOneWidget);
  });
}

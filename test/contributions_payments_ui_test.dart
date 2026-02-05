import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/contributions/presentation/contributions_page.dart';
import 'package:tan_shomiti/src/features/contributions/presentation/models/contributions_ui_state.dart';
import 'package:tan_shomiti/src/features/contributions/presentation/providers/contributions_providers.dart';

void main() {
  testWidgets('Contributions page can record a demo payment and show receipt', (
    tester,
  ) async {
    const month = BillingMonth(year: 2026, month: 2);
    final ui = ContributionsUiState(
      month: month,
      totalDueBdt: 2000,
      rows: const [
        MonthlyDueRow(
          memberId: 'm1',
          position: 1,
          displayName: 'Member 1',
          shares: 2,
          dueAmountBdt: 2000,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          contributionsUiStateProvider.overrideWithValue(
            AsyncValue.data(ui),
          ),
        ],
        child: const MaterialApp(home: Scaffold(body: ContributionsPage())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Unpaid'), findsOneWidget);
    await tester.tap(find.byKey(const Key('dues_record_payment_1')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('payment_reference')), 'trx-1');
    await tester.tap(find.byKey(const Key('payment_confirm')));
    await tester.pumpAndSettle();

    expect(find.text('Paid'), findsOneWidget);
    expect(find.byKey(const Key('dues_view_receipt_1')), findsOneWidget);

    await tester.tap(find.byKey(const Key('dues_view_receipt_1')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('receipt_dialog')), findsOneWidget);
    expect(find.byKey(const Key('receipt_number')), findsOneWidget);
  });
}

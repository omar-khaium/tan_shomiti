import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/components/app_button.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/draw/presentation/draw_record_details_page.dart';
import 'package:tan_shomiti/src/features/draw/presentation/redo_draw_page.dart';
import 'package:tan_shomiti/src/features/draw/presentation/witness_signoff_page.dart';

void main() {
  testWidgets('Draw record details page renders required keys', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: DrawRecordDetailsPage(
          month: const BillingMonth(year: 2026, month: 2),
          methodLabel: 'Numbered tokens',
          proofReference: 'vid-123',
          winnerLabel: 'Member 1 (share 1)',
          statusLabel: 'Pending witness sign-off',
        ),
      ),
    );

    expect(find.byKey(const Key('draw_record_month_label')), findsOneWidget);
    expect(find.byKey(const Key('draw_record_method')), findsOneWidget);
    expect(find.byKey(const Key('draw_record_proof_ref')), findsOneWidget);
    expect(find.byKey(const Key('draw_record_winner')), findsOneWidget);
    expect(find.byKey(const Key('draw_record_status')), findsOneWidget);
    expect(find.byKey(const Key('draw_collect_witnesses')), findsOneWidget);
    expect(find.byKey(const Key('draw_redo')), findsOneWidget);
  });

  testWidgets('Witness sign-off enables finalize after two approvals', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const WitnessSignoffPage()),
    );

    final finalizeFinder = find.byKey(const Key('witness_finalize'));
    expect(finalizeFinder, findsOneWidget);
    final button0 = tester.widget<AppButton>(finalizeFinder);
    expect(button0.onPressed, isNull);

    // Add witness 1.
    await tester.tap(find.byKey(const Key('witness_member_picker')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Member 1').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('witness_confirm')));
    await tester.pumpAndSettle();

    // Add witness 2.
    await tester.tap(find.byKey(const Key('witness_member_picker')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Member 2').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('witness_confirm')));
    await tester.pumpAndSettle();

    final button2 = tester.widget<AppButton>(finalizeFinder);
    expect(button2.onPressed, isNotNull);
  });

  testWidgets('Redo draw requires reason to enable confirm', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const RedoDrawPage()),
    );

    final confirmFinder = find.byKey(const Key('redo_confirm'));
    final button0 = tester.widget<AppButton>(confirmFinder);
    expect(button0.onPressed, isNull);

    await tester.enterText(find.byKey(const Key('redo_reason')), 'Slip fell out');
    await tester.pumpAndSettle();

    final button1 = tester.widget<AppButton>(confirmFinder);
    expect(button1.onPressed, isNotNull);
  });
}

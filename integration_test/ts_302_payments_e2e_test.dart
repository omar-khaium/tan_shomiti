import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-302 (e2e): record payment → receipt → audit log', ($) async {
    await $.pumpWidgetAndSettle(
      ProviderScope(key: UniqueKey(), child: const TanShomitiApp()),
    );

    // Reset if needed for deterministic E2E.
    if (find.byKey(const Key('setup_name_field')).evaluate().isEmpty) {
      await $(#nav_more).tap();
      await $.pumpAndSettle();

      await $(#more_reset_app_data).scrollTo();
      await $(#more_reset_app_data).tap();
      await $.pumpAndSettle();

      await $(#reset_app_data_confirm).tap();
      await $.pumpAndSettle();
    }

    await $(#setup_continue_demo).tap();
    await $.pumpAndSettle();

    await $(#nav_dues).tap();
    await $.pumpAndSettle();

    final row1Finder = find.byKey(const Key('dues_row_1'));
    for (var i = 0; i < 30; i++) {
      if (row1Finder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(row1Finder, findsOneWidget);

    await $(#dues_record_payment_1).tap();
    await $.pumpAndSettle();
    await $(#payment_reference).enterText('trx-e2e-1');
    await $(#payment_confirm).tap();
    await $.pumpAndSettle();

    expect(find.byKey(const Key('dues_view_receipt_1')), findsOneWidget);

    // Persist check: navigate away and back.
    await $(#nav_dashboard).tap();
    await $.pumpAndSettle();
    await $(#nav_dues).tap();
    await $.pumpAndSettle();
    expect(find.byKey(const Key('dues_view_receipt_1')), findsOneWidget);

    // Verify audit transparency.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_audit).scrollTo();
    await $(#more_audit).tap();
    await $.pumpAndSettle();

    expect(find.text('payment_recorded'), findsWidgets);
    expect(find.text('receipt_issued'), findsWidgets);
  });
}


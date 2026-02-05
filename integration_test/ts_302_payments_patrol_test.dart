import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-302: record payments and view receipts on dues page', ($) async {
    await $.pumpWidgetAndSettle(
      ProviderScope(key: UniqueKey(), child: const TanShomitiApp()),
    );

    // Reset for deterministic test.
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

    // Record payment for member #1.
    await $(#dues_record_payment_1).tap();
    await $.pumpAndSettle();
    await $(#payment_reference).enterText('trx-1');
    await $(#payment_confirm).tap();
    await $.pumpAndSettle();

    final receipt1Finder = find.byKey(const Key('dues_view_receipt_1'));
    for (var i = 0; i < 30; i++) {
      if (receipt1Finder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(receipt1Finder, findsOneWidget);

    await $(#dues_view_receipt_1).tap();
    await $.pumpAndSettle();
    expect(find.byKey(const Key('receipt_dialog')), findsOneWidget);
    await $('Close').tap();
    await $.pumpAndSettle();

    // Record payment for member #2.
    await $(#dues_record_payment_2).scrollTo();
    await $(#dues_record_payment_2).tap();
    await $.pumpAndSettle();
    await $(#payment_reference).enterText('trx-2');
    await $(#payment_confirm).tap();
    await $.pumpAndSettle();

    expect(find.byKey(const Key('dues_view_receipt_2')), findsOneWidget);
  });
}

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-303: late fee and eligibility update by month', ($) async {
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

    // Move to previous month so payment confirmed "now" becomes late.
    await $(#dues_prev_month).tap();
    await $.pumpAndSettle();

    // Record payment for member #1.
    await $(#dues_record_payment_1).tap();
    await $.pumpAndSettle();
    await $(#payment_reference).enterText('late-1');
    await $(#payment_confirm).tap();
    await $.pumpAndSettle();

    expect(find.byKey(const Key('dues_view_receipt_1')), findsOneWidget);
    expect(find.text('Not eligible'), findsWidgets);
    expect(find.text('Late fee: 0 BDT'), findsNothing);

    // Back to current month and record a payment that should be eligible.
    await $(#dues_next_month).tap();
    await $.pumpAndSettle();

    await $(#dues_record_payment_2).scrollTo();
    await $(#dues_record_payment_2).tap();
    await $.pumpAndSettle();
    await $(#payment_reference).enterText('on-time-2');
    await $(#payment_confirm).tap();
    await $.pumpAndSettle();

    expect(find.byKey(const Key('dues_view_receipt_2')), findsOneWidget);
    expect(find.text('Eligible'), findsWidgets);
  });
}


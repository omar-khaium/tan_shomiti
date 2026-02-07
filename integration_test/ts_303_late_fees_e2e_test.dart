import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-303 (e2e): late payment becomes ineligible for draw', ($) async {
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

    // Previous month: paying "now" should be late -> not eligible.
    await $(#dues_prev_month).tap();
    await $.pumpAndSettle();
    await $(#dues_record_payment_1).tap();
    await $.pumpAndSettle();
    await $(#payment_reference).enterText('late-e2e-1');
    await $(#payment_confirm).tap();
    await $.pumpAndSettle();
    expect(find.text('Not eligible'), findsWidgets);

    // Next month: payment should be eligible (confirmedAt is before deadline).
    await $(#dues_next_month).tap(); // back to current
    await $.pumpAndSettle();
    await $(#dues_next_month).tap(); // move to next month
    await $.pumpAndSettle();
    await $(#dues_record_payment_2).scrollTo();
    await $(#dues_record_payment_2).tap();
    await $.pumpAndSettle();
    await $(#payment_reference).enterText('on-time-e2e-2');
    await $(#payment_confirm).tap();
    await $.pumpAndSettle();
    expect(find.text('Eligible'), findsWidgets);
  });
}

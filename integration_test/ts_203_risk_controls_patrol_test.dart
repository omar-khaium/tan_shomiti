import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-203: record guarantor + deposit + return', ($) async {
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

    await $(#nav_more).tap();
    await $.pumpAndSettle();

    await $(#more_risk_controls).scrollTo();
    await $(#more_risk_controls).tap();
    await $.pumpAndSettle();

    // Wait for the list to load (controller reads from DB).
    final firstRowFinder = find.byKey(const Key('risk_actions_1'));
    for (var i = 0; i < 30; i++) {
      if (firstRowFinder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(firstRowFinder, findsOneWidget);

    // Record guarantor for member #3.
    await $(#risk_row_3).scrollTo();
    await $(#risk_actions_3).tap();
    await $.pumpAndSettle();
    await $('Record guarantor').tap();
    await $.pumpAndSettle();

    await $(#guarantor_name).enterText('Guarantor A');
    await $(#guarantor_phone).enterText('01700000000');
    await $(#guarantor_relationship).enterText('Brother');
    await $(#guarantor_proof).enterText('IMG_203_G_1');
    await $(#guarantor_save).tap();
    await $.pumpAndSettle();

    expect(find.text('Guarantor recorded'), findsWidgets);

    // Record deposit for member #4.
    await $(#risk_row_4).scrollTo();
    await $(#risk_actions_4).tap();
    await $.pumpAndSettle();
    await $('Record deposit').tap();
    await $.pumpAndSettle();

    await $(#deposit_amount).enterText('5000');
    await $(#deposit_held_by).enterText('Treasurer');
    await $(#deposit_proof).enterText('IMG_203_D_1');
    await $(#deposit_save).tap();
    await $.pumpAndSettle();

    expect(find.text('Deposit recorded (held)'), findsWidgets);

    // Mark deposit returned and verify status becomes incomplete.
    await $(#risk_actions_4).tap();
    await $.pumpAndSettle();
    await $('Mark deposit returned').tap();
    await $.pumpAndSettle();
    await $('Mark returned').tap();
    await $.pumpAndSettle();

    expect(
      find.textContaining('Deposit returned (needs guarantor or deposit)'),
      findsWidgets,
    );
  });
}

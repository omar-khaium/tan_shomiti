import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-203 (e2e): record risk controls and verify readiness count', (
    $,
  ) async {
    await $.pumpWidgetAndSettle(
      ProviderScope(key: UniqueKey(), child: const TanShomitiApp()),
    );

    // Reset for deterministic E2E.
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

    // Demo has 10 members; initially everyone is missing.
    expect(find.text('10 missing'), findsOneWidget);

    // Record guarantor for member #1.
    await $(#risk_actions_1).tap();
    await $.pumpAndSettle();
    await $('Record guarantor').tap();
    await $.pumpAndSettle();

    await $(#guarantor_name).enterText('Guarantor 1');
    await $(#guarantor_phone).enterText('01700000000');
    await $(#guarantor_save).tap();
    await $.pumpAndSettle();

    // Record deposit for member #2.
    await $(#risk_actions_2).tap();
    await $.pumpAndSettle();
    await $('Record deposit').tap();
    await $.pumpAndSettle();

    await $(#deposit_amount).enterText('2000');
    await $(#deposit_held_by).enterText('Treasurer');
    await $(#deposit_save).tap();
    await $.pumpAndSettle();

    // Now 8 members are missing.
    expect(find.text('8 missing'), findsOneWidget);

    // Return the deposit; missing count increases.
    await $(#risk_actions_2).tap();
    await $.pumpAndSettle();
    await $('Mark deposit returned').tap();
    await $.pumpAndSettle();
    await $('Mark returned').tap();
    await $.pumpAndSettle();

    expect(find.text('9 missing'), findsOneWidget);
  });
}

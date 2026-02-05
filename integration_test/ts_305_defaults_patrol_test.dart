import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-305: defaults dashboard can record enforcement steps', ($) async {
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

    // Basic setup with default thresholds (2 consecutive / 3 total).
    await $(#setup_name_field).enterText('TS305 Shomiti');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_member_count_field).enterText('3');
    await $(#setup_share_value_field).enterText('1000');
    await $(#setup_max_shares_field).enterText('1');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_cycle_length_field).enterText('3');
    await $(#setup_meeting_schedule_field).enterText('Every month');
    await $(#setup_payment_deadline_field).enterText('5th day of the month');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_default_consecutive_threshold_field).enterText('2');
    await $(#setup_default_total_threshold_field).enterText('3');
    await $(#setup_next).tap(); // policies -> fees
    await $.pumpAndSettle();

    await $(#setup_next).tap(); // fees -> review
    await $.pumpAndSettle();
    await $(#setup_next).tap(); // finish
    await $.pumpAndSettle();

    // Wait for shell.
    final navDuesFinder = find.byKey(const Key('nav_dues'));
    for (var i = 0; i < 50; i++) {
      if (navDuesFinder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(navDuesFinder, findsWidgets);

    // Generate dues for two months (to trigger consecutive missed >= 2).
    await $(#nav_dues).tap();
    await $.pumpAndSettle();
    await $(#dues_next_month).tap();
    await $.pumpAndSettle();

    // Record a guarantor for Member 1 so "Apply guarantor / deposit" can succeed.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_risk_controls).scrollTo();
    await $(#more_risk_controls).tap();
    await $.pumpAndSettle();

    await $(#risk_actions_1).tap();
    await $.pumpAndSettle();
    await $('Record guarantor').tap();
    await $.pumpAndSettle();

    await $(#guarantor_name).enterText('Guarantor 1');
    await $(#guarantor_phone).enterText('01700000000');
    await $(#guarantor_save).tap();
    await $.pumpAndSettle();

    // Defaults dashboard: record reminder -> notice -> apply cover.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_defaults).scrollTo();
    await $(#more_defaults).tap();
    await $.pumpAndSettle();

    await $(#defaults_record_reminder_0).tap();
    await $.pumpAndSettle();

    await $(#defaults_record_notice_0).tap();
    await $.pumpAndSettle();

    await $(#defaults_apply_guarantor_0).tap();
    await $.pumpAndSettle();

    // Audit log should show the applied step.
    await $(#nav_dues).tap();
    await $.pumpAndSettle();
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_audit).scrollTo();
    await $(#more_audit).tap();
    await $.pumpAndSettle();

    expect(find.text('default_reminder_recorded'), findsWidgets);
    expect(find.text('default_notice_recorded'), findsWidgets);
    expect(find.text('default_guarantor_or_deposit_applied'), findsWidgets);
  });
}

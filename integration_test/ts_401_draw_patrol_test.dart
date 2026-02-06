import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-401: eligible shares → run draw → record audit', ($) async {
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

    // Setup: memberCount=3, cycleLength=6 => multiple shares distributed.
    await $(#setup_name_field).enterText('TS401 Shomiti');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_member_count_field).enterText('3');
    await $(#setup_share_value_field).enterText('1000');
    await $(#setup_max_shares_field).enterText('2');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_cycle_length_field).enterText('6');
    await $(#setup_meeting_schedule_field).enterText('Every month');
    await $(#setup_payment_deadline_field).enterText('28th day of the month');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_grace_period_days_field).enterText('3');
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

    // Generate dues + record payment for Member 1.
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
    await $(#payment_reference).enterText('trx-ts401-1');
    await $(#payment_confirm).tap();
    await $.pumpAndSettle();

    // Draw: run + record.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_draw).scrollTo();
    await $(#more_draw).tap();
    await $.pumpAndSettle();

    await $(#eligibility_run_draw).tap();
    await $.pumpAndSettle();

    await $(#draw_method_tokens).tap();
    await $.pumpAndSettle();

    await $(find.text('Select winning share')).tap();
    await $.pumpAndSettle();
    final winnerOption = find.textContaining('Member 1 (share');
    await $(winnerOption).tap();
    await $.pumpAndSettle();

    await $(#draw_proof_ref).enterText('vid-ts401-1');
    await $.pumpAndSettle();

    await $(#draw_save).scrollTo();
    await $.pumpAndSettle();
    await $(#draw_save).tap();
    await $.pumpAndSettle();

    // Audit log shows draw recorded.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_audit).scrollTo();
    await $(#more_audit).tap();
    await $.pumpAndSettle();

    expect(find.text('draw_recorded'), findsWidgets);
  });
}

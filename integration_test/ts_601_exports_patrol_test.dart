import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-601: export statement CSV (privacy defaults)', ($) async {
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

    // Setup: memberCount=3, cycleLength=3 => 1 share each.
    await $(#setup_name_field).enterText('TS601 Shomiti');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_member_count_field).enterText('3');
    await $(#setup_share_value_field).enterText('1000');
    await $(#setup_max_shares_field).enterText('1');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_cycle_length_field).enterText('3');
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
    await $.pump(const Duration(seconds: 1));

    // Wait for shell.
    final navDuesFinder = find.byKey(const Key('nav_dues'));
    for (var i = 0; i < 600; i++) {
      if (navDuesFinder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(navDuesFinder, findsWidgets);

    // Record payments for all members (complete pot).
    await $(#nav_dues).tap();
    await $.pumpAndSettle();

    final row1Finder = find.byKey(const Key('dues_row_1'));
    for (var i = 0; i < 30; i++) {
      if (row1Finder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(row1Finder, findsOneWidget);

    for (final position in [1, 2, 3]) {
      final recordFinder = find.byKey(Key('dues_record_payment_$position'));
      await $(recordFinder).scrollTo();
      await $.pumpAndSettle();
      await $(recordFinder).tap();
      await $.pumpAndSettle();
      await $(#payment_reference).enterText('trx-ts601-$position');
      await $(#payment_confirm).tap();
      await $.pumpAndSettle();
    }

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
    await $(find.textContaining('Member 1 (share')).tap();
    await $.pumpAndSettle();

    await $(#draw_proof_ref).enterText('vid-ts601-1');
    await $.pumpAndSettle();
    await $(#draw_save).scrollTo();
    await $(#draw_save).tap();
    await $.pumpAndSettle();

    // Witness sign-offs + finalize.
    await $(#draw_view_record).tap();
    await $.pumpAndSettle();
    await $(#draw_collect_witnesses).tap();
    await $.pumpAndSettle();

    await $(#witness_member_picker).tap();
    await $.pumpAndSettle();
    await $(find.text('Member 2')).tap();
    await $.pumpAndSettle();
    await $(#witness_confirm).tap();
    await $.pumpAndSettle();

    await $(#witness_member_picker).tap();
    await $.pumpAndSettle();
    await $(find.text('Member 3')).tap();
    await $.pumpAndSettle();
    await $(#witness_confirm).tap();
    await $.pumpAndSettle();

    await $(#witness_finalize).scrollTo();
    await $(#witness_finalize).tap();
    await $.pumpAndSettle();

    // Payout: complete flow quickly.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_payout).scrollTo();
    await $(#more_payout).tap();
    await $.pumpAndSettle();

    await $(#payout_continue).tap();
    await $.pumpAndSettle();

    await $(#payout_collection_verifier_picker).tap();
    await $.pumpAndSettle();
    await $(find.text('Member 1')).tap();
    await $.pumpAndSettle();
    await $(#payout_collection_verify).tap();
    await $.pumpAndSettle();

    await $(#payout_treasurer_picker).tap();
    await $.pumpAndSettle();
    await $(find.text('Member 1')).tap();
    await $.pumpAndSettle();
    await $(#payout_treasurer_approve).tap();
    await $.pumpAndSettle();

    await $(#payout_auditor_picker).tap();
    await $.pumpAndSettle();
    await $(find.text('Member 2')).tap();
    await $.pumpAndSettle();
    await $(#payout_auditor_approve).tap();
    await $.pumpAndSettle();

    await $(#payout_approvals_continue).scrollTo();
    await $.pumpAndSettle();
    await $(#payout_approvals_continue).tap();
    await $.pumpAndSettle();

    await $(#payout_proof_ref).enterText('trx-ts601-proof');
    await $.pumpAndSettle();
    await $(#payout_mark_paid).tap();
    await $.pumpAndSettle();

    // Statements: generate.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_statements).scrollTo();
    await $(#more_statements).tap();
    await $.pumpAndSettle();

    await $(#statement_generate).tap(); // Generate statement
    await $.pumpAndSettle();

    // Exports: generate CSV for statement (privacy defaults).
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_exports).scrollTo();
    await $(#more_exports).tap();
    await $.pumpAndSettle();

    await $(find.text('Statements')).tap();
    await $.pumpAndSettle();

    await $(#export_statement_generate).scrollTo();
    await $(#export_statement_generate).tap();
    await $.pumpAndSettle();

    expect(find.byKey(const Key('export_statement_path')), findsOneWidget);
  });
}


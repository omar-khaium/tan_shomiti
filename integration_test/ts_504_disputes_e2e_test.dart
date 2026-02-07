import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-504 e2e: disputes persist and can be reopened', ($) async {
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

    // Setup shomiti with 3 members.
    await $(#setup_name_field).enterText('TS504E2E Shomiti');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_member_count_field).enterText('3');
    await $(#setup_share_value_field).enterText('1000');
    await $(#setup_max_shares_field).enterText('1');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_cycle_length_field).enterText('3');
    await $(#setup_meeting_schedule_field).enterText('Monthly');
    await $(#setup_payment_deadline_field).enterText('5th day of the month');
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

    // Disputes: create.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_disputes).scrollTo();
    await $(#more_disputes).tap();
    await $.pumpAndSettle();

    await $(#disputes_create).tap();
    await $.pumpAndSettle();

    await $(#create_dispute_title).enterText('Ledger dispute');
    await $(#create_dispute_description).enterText(
      'Factual description of the dispute.',
    );
    await $(#create_dispute_submit).scrollTo();
    await $(#create_dispute_submit).tap();
    await $.pumpAndSettle();
    await $.pump(const Duration(seconds: 1));

    // Complete steps 1–3.
    Future<void> completeStep({
      required String stepName,
      required String noteKey,
      required String confirmKey,
      required String note,
    }) async {
      await $(Key('dispute_step_complete_$stepName')).scrollTo();
      await $(Key('dispute_step_complete_$stepName')).tap();
      await $.pumpAndSettle();
      await $(Key(noteKey)).enterText(note);
      await $(Key(confirmKey)).tap();
      await $.pumpAndSettle();
    }

    await completeStep(
      stepName: 'privateDiscussion',
      noteKey: 'complete_step_note_privateDiscussion',
      confirmKey: 'complete_step_confirm_privateDiscussion',
      note: 'Private discussion held.',
    );
    await completeStep(
      stepName: 'meetingDiscussion',
      noteKey: 'complete_step_note_meetingDiscussion',
      confirmKey: 'complete_step_confirm_meetingDiscussion',
      note: 'Meeting held with witnesses and ledger review.',
    );
    await completeStep(
      stepName: 'mediation',
      noteKey: 'complete_step_note_mediation',
      confirmKey: 'complete_step_confirm_mediation',
      note: 'Mediation attempted with neutral member.',
    );

    // Resolve.
    await $(const Key('dispute_resolve')).scrollTo();
    await $(const Key('dispute_resolve')).tap();
    await $.pumpAndSettle();
    await $(const Key('resolve_outcome_note')).enterText('Resolved outcome.');
    await $(const Key('resolve_confirm')).tap();
    await $.pumpAndSettle();

    // Navigate away and back to verify persistence.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_rules).scrollTo();
    await $(#more_rules).tap();
    await $.pumpAndSettle();

    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_disputes).scrollTo();
    await $(#more_disputes).tap();
    await $.pumpAndSettle();

    await $(const Key('disputes_tab_resolved')).tap();
    await $.pumpAndSettle();
    expect(find.text('Ledger dispute'), findsOneWidget);
  });
}

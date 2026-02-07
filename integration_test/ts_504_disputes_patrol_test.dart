import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';
import 'package:tan_shomiti/src/core/ui/components/app_button.dart';

void main() {
  patrolTest('TS-504: create dispute + complete step 1 enables step 2', (
    $,
  ) async {
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
    await $(#setup_name_field).enterText('TS504 Shomiti');
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

    // Disputes.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_disputes).scrollTo();
    await $(#more_disputes).tap();
    await $.pumpAndSettle();

    await $(#disputes_create).tap();
    await $.pumpAndSettle();

    await $(#create_dispute_title).enterText('Missed payment dispute');
    await $(
      #create_dispute_description,
    ).enterText('Neutral description of the dispute.');
    await $(#create_dispute_evidence).enterText('chat-msg-001');
    await $(#create_dispute_submit).scrollTo();
    await $(#create_dispute_submit).tap();
    await $.pumpAndSettle();
    await $.pump(const Duration(seconds: 1));

    final step2Finder = find.byKey(
      const Key('dispute_step_complete_meetingDiscussion'),
    );
    await $(const Key('dispute_step_complete_meetingDiscussion')).scrollTo();
    final before = $.tester.widget<AppButton>(step2Finder);
    expect(before.onPressed, isNull);

    await $(const Key('dispute_step_complete_privateDiscussion')).scrollTo();
    await $(const Key('dispute_step_complete_privateDiscussion')).tap();
    await $.pumpAndSettle();
    await $(
      const Key('complete_step_note_privateDiscussion'),
    ).enterText('Discussed privately with coordinator and treasurer.');
    await $(const Key('complete_step_confirm_privateDiscussion')).tap();
    await $.pumpAndSettle();

    final after = $.tester.widget<AppButton>(step2Finder);
    expect(after.onPressed, isNotNull);
  });
}

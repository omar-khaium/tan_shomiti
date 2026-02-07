import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-503 e2e: applied rules persist', ($) async {
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
    await $(#setup_name_field).enterText('TS503E2E Shomiti');
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

    // Ensure placeholder members are seeded (Governance context does this).
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_governance).scrollTo();
    await $(#more_governance).tap();
    await $.pumpAndSettle();

    final backFinder = find.byTooltip('Back');
    if (backFinder.evaluate().isNotEmpty) {
      await $(backFinder).tap();
      await $.pumpAndSettle();
    }

    // Rule changes: propose.
    await $(#more_rule_changes).scrollTo();
    await $(#more_rule_changes).tap();
    await $.pumpAndSettle();

    await $(#rule_changes_propose).tap();
    await $.pumpAndSettle();

    await $(#rule_change_share_value).enterText('1200');
    await $(#rule_change_meeting_schedule).enterText('Every month');
    await $(#rule_change_payment_deadline).enterText('6th day of the month');
    await $(
      #rule_change_note,
    ).enterText('Increase share value for next months');
    await $(#rule_change_shared_ref).enterText('chat-msg-ts503-e2e-1');
    await $(#rule_change_propose).scrollTo();
    await $(#rule_change_propose).tap();
    await $.pumpAndSettle();

    // Collect unanimous consent.
    for (final i in [0, 1, 2]) {
      await $(Key('rule_change_member_$i')).scrollTo();
      await $(Key('rule_change_member_$i')).tap();
      await $.pumpAndSettle();
      await $(#rule_change_proof_reference).enterText('sig-ts503-e2e-$i');
      await $(Key('rule_change_consent_confirm_$i')).tap();
      await $.pumpAndSettle();
    }

    // Apply.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_rule_changes).scrollTo();
    await $(#more_rule_changes).tap();
    await $.pumpAndSettle();

    await $(#rule_changes_apply).scrollTo();
    await $(#rule_changes_apply).tap();
    await $.pumpAndSettle();

    // Verify active rules reflect applied change.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_rules).scrollTo();
    await $(#more_rules).tap();
    await $.pumpAndSettle();

    expect(find.text('BDT 1200'), findsWidgets);
  });
}

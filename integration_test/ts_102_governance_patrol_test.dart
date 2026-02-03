import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'TS-102: assign roles + collect sign-off (happy path)',
    ($) async {
      await $.pumpWidgetAndSettle(
        ProviderScope(
          key: UniqueKey(),
          child: const TanShomitiApp(),
        ),
      );

      // If already configured, reset to ensure deterministic flow.
      if (find.byKey(const Key('setup_name_field')).evaluate().isEmpty) {
        await $(#nav_more).tap();
        await $.pumpAndSettle();

        await $(#more_reset_app_data).scrollTo();
        await $(#more_reset_app_data).tap();
        await $.pumpAndSettle();

        await $(#reset_app_data_confirm).tap();
        await $.pumpAndSettle();
      }

      // Setup a small member count to keep the test fast.
      await $(#setup_name_field).enterText('My Shomiti');
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      await $(#setup_member_count_field).enterText('2');
      await $(#setup_share_value_field).enterText('1000');
      await $(#setup_max_shares_field).enterText('1');
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      await $(#setup_cycle_length_field).enterText('2');
      await $(#setup_meeting_schedule_field).enterText('Every month, Friday 8pm');
      await $(#setup_payment_deadline_field).enterText('5th day of the month');
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      // Policies -> Fees -> Review.
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      await $(#setup_next).tap();
      await $.pumpAndSettle();

      await $(#setup_next).tap();
      await $.pumpAndSettle();

      await $(#nav_more).tap();
      await $.pumpAndSettle();

      await $(#more_governance).scrollTo();
      await $(#more_governance).tap();
      await $.pumpAndSettle();

      expect(find.text('Not ready'), findsOneWidget);

      await $(#governance_roles_tile).tap();
      await $.pumpAndSettle();

      await $(#role_treasurer_dropdown).tap();
      await $.pumpAndSettle();
      await $(find.text('Member 1')).tap();
      await $.pumpAndSettle();

      await $(#role_auditor_dropdown).tap();
      await $.pumpAndSettle();
      await $(find.text('Member 2')).tap();
      await $.pumpAndSettle();

      await $(#roles_done).tap();
      await $.pumpAndSettle();

      await $(#governance_signoff_tile).tap();
      await $.pumpAndSettle();

      await $(#signoff_member_0).tap();
      await $.pumpAndSettle();
      await $(#signoff_proof_reference).enterText('chat://m1');
      await $(#signoff_confirm_0).tap();
      await $.pumpAndSettle();

      await $(#signoff_member_1).tap();
      await $.pumpAndSettle();
      await $(#signoff_proof_reference).enterText('chat://m2');
      await $(#signoff_confirm_1).tap();
      await $.pumpAndSettle();

      await $(#nav_more).tap();
      await $.pumpAndSettle();
      await $(#more_governance).scrollTo();
      await $(#more_governance).tap();
      await $.pumpAndSettle();

      expect(find.text('Governance ready'), findsOneWidget);
    },
  );
}


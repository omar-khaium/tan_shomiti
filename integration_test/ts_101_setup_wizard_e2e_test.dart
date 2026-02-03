import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'ts101 e2e: setup wizard writes audit event',
    ($) async {
      await $.pumpWidgetAndSettle(
        ProviderScope(
          key: UniqueKey(),
          child: const TanShomitiApp(),
        ),
      );

      // If the app is already configured (e.g. a previous test ran), reset it
      // to ensure we cover the full wizard flow.
      if (find.byKey(const Key('setup_name_field')).evaluate().isEmpty) {
        await $(#nav_more).tap();
        await $.pumpAndSettle();

        await $(#more_reset_app_data).scrollTo();
        await $(#more_reset_app_data).tap();
        await $.pumpAndSettle();

        await $(#reset_app_data_confirm).tap();
        await $.pumpAndSettle();
      }

      expect(find.byKey(const Key('setup_name_field')), findsOneWidget);

      await $(#setup_name_field).enterText('My Shomiti');
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      await $(#setup_member_count_field).enterText('10');
      await $(#setup_share_value_field).enterText('1000');
      await $(#setup_max_shares_field).enterText('1');
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      await $(#setup_cycle_length_field).enterText('10');
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

      await $(#more_audit).scrollTo();
      await $(#more_audit).tap();
      await $.pump(const Duration(milliseconds: 500));

      expect(find.text('created_shomiti'), findsOneWidget);
    },
  );
}

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'TS-101: complete setup wizard (happy path)',
    ($) async {
      await $.pumpWidgetAndSettle(
        const ProviderScope(
          child: TanShomitiApp(),
        ),
      );

      // Step 1: basics (validate required name).
      await $(#setup_next).tap();
      await $.pumpAndSettle();
      expect(find.byKey(const Key('setup_name_field')), findsOneWidget);
      expect(find.text('Required'), findsOneWidget);

      await $(#setup_name_field).enterText('My Shomiti');
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      // Step 2: members & shares.
      await $(#setup_member_count_field).enterText('10');
      await $(#setup_share_value_field).enterText('1000');
      await $(#setup_max_shares_field).enterText('1');
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      // Step 3: schedule.
      await $(#setup_cycle_length_field).enterText('10');
      await $(#setup_meeting_schedule_field).enterText('Every month, Friday 8pm');
      await $(#setup_payment_deadline_field).enterText('5th day of the month');
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      // Step 4: policies.
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      // Step 5: fees.
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      // Step 6: review -> finish.
      await $(#setup_next).tap();
      await $.pumpAndSettle();

      expect(find.text('Dashboard'), findsWidgets);
      expect(find.byKey(const Key('nav_dashboard')), findsOneWidget);
    },
  );
}

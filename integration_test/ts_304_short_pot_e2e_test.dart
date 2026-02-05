import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-304 (e2e): reserve cover resolves shortfall and logs audit', (
    $,
  ) async {
    await $.pumpWidgetAndSettle(
      ProviderScope(key: UniqueKey(), child: const TanShomitiApp()),
    );

    // Reset if needed for deterministic E2E.
    if (find.byKey(const Key('setup_name_field')).evaluate().isEmpty) {
      await $(#nav_more).tap();
      await $.pumpAndSettle();

      await $(#more_reset_app_data).scrollTo();
      await $(#more_reset_app_data).tap();
      await $.pumpAndSettle();

      await $(#reset_app_data_confirm).tap();
      await $.pumpAndSettle();
    }

    // Custom setup with Policy B.
    await $(#setup_name_field).enterText('TS304E2E Shomiti');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_member_count_field).enterText('10');
    await $(#setup_share_value_field).enterText('1000');
    await $(#setup_max_shares_field).enterText('2');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_cycle_length_field).enterText('12');
    await $(#setup_meeting_schedule_field).enterText('Every month');
    await $(#setup_payment_deadline_field).enterText('5th day of the month');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_missed_policy_coverFromReserve).tap();
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

    await $(#nav_dues).tap();
    await $.pumpAndSettle();

    // Cover and ensure status becomes complete.
    await $(#collection_cover_reserve).tap();
    await $.pumpAndSettle();
    expect(find.text('Complete'), findsWidgets);

    // Audit log should include the cover action.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_audit).scrollTo();
    await $(#more_audit).tap();
    await $.pumpAndSettle();

    expect(find.text('reserve_cover_recorded'), findsWidgets);
  });
}


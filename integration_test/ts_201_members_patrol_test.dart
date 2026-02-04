import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-201: add/edit/deactivate member', ($) async {
    await $.pumpWidgetAndSettle(
      ProviderScope(key: UniqueKey(), child: const TanShomitiApp()),
    );

    // Ensure a deterministic starting point.
    if (find.byKey(const Key('setup_name_field')).evaluate().isEmpty) {
      await $(#nav_more).tap();
      await $.pumpAndSettle();

      await $(#more_reset_app_data).scrollTo();
      await $(#more_reset_app_data).tap();
      await $.pumpAndSettle();

      await $(#reset_app_data_confirm).tap();
      await $.pumpAndSettle();
    }

    await $(#setup_continue_demo).tap();
    await $.pumpAndSettle();

    await $(#nav_members).tap();
    await $.pumpAndSettle();

    // Add member.
    await $(#members_add).tap();
    await $.pumpAndSettle();

    await $(#member_full_name).enterText('TS201 Alice');
    await $(#member_phone).enterText('01700000001');
    await $(#member_address).enterText('Dhaka');
    await $(#member_nid).enterText('NID123456');
    await $(#member_emergency_name).enterText('Bob');
    await $(#member_emergency_phone).enterText('01800000001');
    await $(#member_notes).enterText('Test note');
    await $(#member_save).tap();
    await $.pumpAndSettle();

    expect(find.text('TS201 Alice'), findsOneWidget);

    // Open detail.
    await $(find.text('TS201 Alice')).tap();
    await $.pumpAndSettle();

    // Edit.
    await $(#member_edit).tap();
    await $.pumpAndSettle();

    await $(#member_full_name).enterText('TS201 Alice Updated');
    await $(#member_save).tap();
    await $.pumpAndSettle();

    expect(find.text('TS201 Alice Updated'), findsOneWidget);

    // Deactivate (confirm + return to list).
    await $(#member_deactivate).tap();
    await $.pumpAndSettle();

    await $(#member_deactivate_confirm).tap();
    await $.pumpAndSettle();

    expect(find.text('TS201 Alice Updated'), findsOneWidget);
    expect(find.text('Inactive'), findsWidgets);
  });
}

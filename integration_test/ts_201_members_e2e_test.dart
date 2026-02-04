import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('ts201 e2e: add members + privacy defaults', ($) async {
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

    Future<void> addMember({
      required String name,
      required String phone,
      required String nid,
    }) async {
      await $(#members_add).tap();
      await $.pumpAndSettle();

      await $(#member_full_name).enterText(name);
      await $(#member_phone).enterText(phone);
      await $(#member_address).enterText('Dhaka');
      await $(#member_nid).enterText(nid);
      await $(#member_emergency_name).enterText('Emergency');
      await $(#member_emergency_phone).enterText('01900000099');
      await $(#member_save).tap();
      await $.pumpAndSettle();
    }

    await addMember(
      name: 'TS201 Member 1',
      phone: '01700000000',
      nid: 'NID123456',
    );
    await addMember(name: 'TS201 Member 2', phone: '01700000001', nid: '');
    await addMember(name: 'TS201 Member 3', phone: '01700000002', nid: '');

    expect(find.text('TS201 Member 1'), findsOneWidget);
    expect(find.text('TS201 Member 2'), findsOneWidget);
    expect(find.text('TS201 Member 3'), findsOneWidget);

    // Privacy defaults: masked phone + ID by default on detail.
    await $(find.text('TS201 Member 1')).tap();
    await $.pumpAndSettle();

    expect(find.text('01700000000'), findsNothing);
    expect(find.text('01******000'), findsOneWidget);

    expect(find.text('NID123456'), findsNothing);
    expect(find.text('NI********56'), findsOneWidget);

    // Emergency phone is lower on the page; scroll so it's built and visible.
    await $(find.text('Emergency phone')).scrollTo();
    await $.pumpAndSettle();
    expect(find.text('01900000099'), findsNothing);
    expect(find.text('01******099'), findsOneWidget);

    // Reveal sensitive values and re-check.
    await $(#member_show_sensitive_toggle).scrollTo();
    await $(#member_show_sensitive_toggle).tap();
    await $.pumpAndSettle();

    expect(find.text('01700000000'), findsOneWidget);
    expect(find.text('01******000'), findsNothing);

    expect(find.text('NID123456'), findsOneWidget);
    expect(find.text('NI********56'), findsNothing);

    await $(find.text('Emergency phone')).scrollTo();
    await $.pumpAndSettle();
    expect(find.text('01900000099'), findsOneWidget);
    expect(find.text('01******099'), findsNothing);
  });
}

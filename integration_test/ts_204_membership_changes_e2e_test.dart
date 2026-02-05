import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-204 (e2e): replace a member with unanimous approval', (
    $,
  ) async {
    await $.pumpWidgetAndSettle(
      ProviderScope(key: UniqueKey(), child: const TanShomitiApp()),
    );

    // Reset for deterministic E2E.
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

    await $(#nav_more).tap();
    await $.pumpAndSettle();

    await $(#more_membership_changes).scrollTo();
    await $(#more_membership_changes).tap();
    await $.pumpAndSettle();

    // Wait for the list to load (controller reads from DB).
    final firstRowFinder = find.byKey(const Key('membership_row_1'));
    for (var i = 0; i < 30; i++) {
      if (firstRowFinder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(firstRowFinder, findsOneWidget);

    await $(#membership_request_exit_1).tap();
    await $.pumpAndSettle();
    await $(#membership_exit_confirm).tap();
    await $.pumpAndSettle();

    await $(#membership_propose_replacement_1).tap();
    await $.pumpAndSettle();
    await $(#membership_replacement_name).enterText('Replacement E2E');
    await $(#membership_replacement_phone).enterText('01800000000');
    await $(#membership_replacement_confirm).tap();
    await $.pumpAndSettle();

    // Approve unanimously (all other active members in demo).
    for (var i = 0; i < 9; i++) {
      await $(#membership_approve_1).tap();
      await $.pumpAndSettle();
      await $(#membership_approval_confirm).tap();
      await $.pumpAndSettle();
    }

    // Verify the name is updated and no longer has a pending approvals banner.
    expect(find.text('Replacement E2E'), findsWidgets);
    expect(find.byKey(const Key('membership_approvals_1')), findsNothing);
  });
}


import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-204: exit + replacement approvals + removal proposal', (
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

    // Request exit for member #1.
    await $(#membership_request_exit_1).tap();
    await $.pumpAndSettle();
    await $(#membership_exit_confirm).tap();
    await $.pumpAndSettle();

    expect(find.text('Exit requested'), findsWidgets);

    // Propose replacement for member #1.
    await $(#membership_propose_replacement_1).tap();
    await $.pumpAndSettle();
    await $(#membership_replacement_name).enterText('Replacement 1');
    await $(#membership_replacement_phone).enterText('01800000000');
    await $.pump(const Duration(milliseconds: 300));
    await $(#membership_replacement_confirm).tap();
    await $.pumpAndSettle();

    // Dialog should close after successful validation.
    expect(find.byKey(const Key('membership_replacement_confirm')), findsNothing);

    // Wait for page to re-render after controller refresh.
    final row1Finder = find.byKey(const Key('membership_row_1'));
    for (var i = 0; i < 100; i++) {
      if (row1Finder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(row1Finder, findsOneWidget);

    // Replacement proposal should be visible on the row.
    final proposedFinder = find.byKey(const Key('membership_replacement_1'));
    for (var i = 0; i < 100; i++) {
      if (proposedFinder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(proposedFinder, findsOneWidget);

    // Wait for approve button to appear after controller refresh.
    final approveFinder = find.byKey(const Key('membership_approve_1'));
    for (var i = 0; i < 100; i++) {
      if (approveFinder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(approveFinder, findsOneWidget);

    // Approve unanimously (all other active members).
    for (var i = 0; i < 9; i++) {
      await $(#membership_approve_1).tap();
      await $.pumpAndSettle();
      await $(#membership_approval_confirm).tap();
      await $.pumpAndSettle();
    }

    // After final approval, the slot should be active again with the new name.
    expect(find.text('Replacement 1'), findsWidgets);
    expect(find.byKey(const Key('membership_approvals_1')), findsNothing);

    // Propose a removal for member #2 and ensure it becomes pending.
    await $(#membership_remove_2).tap();
    await $.pumpAndSettle();
    await $(#membership_removal_confirm).tap();
    await $.pumpAndSettle();

    expect(find.text('Removal proposed'), findsWidgets);
    expect(find.byKey(const Key('membership_approve_2')), findsOneWidget);
  });
}

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-202: assign shares and review totals', ($) async {
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

    await $(#nav_more).tap();
    await $.pumpAndSettle();

    await $(#more_shares).scrollTo();
    await $(#more_shares).tap();
    await $.pumpAndSettle();

    // Demo snapshot is configured for multi-share: cycleLengthMonths=12, memberCount=10,
    // so two members start with 2 shares each.
    expect(find.byKey(const Key('shares_row_1')), findsOneWidget);
    expect(find.byKey(const Key('shares_row_2')), findsOneWidget);

    // Make allocations incomplete.
    await $(#shares_decrement_1).tap();
    await $.pumpAndSettle();
    expect(find.textContaining('Allocate 1 more shares'), findsOneWidget);

    // Re-balance to reach the fixed total.
    await $(#shares_row_3).scrollTo();
    await $(#shares_increment_3).tap();
    await $.pumpAndSettle();
    expect(find.textContaining('Allocate 1 more shares'), findsNothing);

    // Review dialog.
    await $(#shares_review).scrollTo();
    await $(#shares_review).tap();
    await $.pumpAndSettle();
    expect(find.byKey(const Key('shares_review_dialog')), findsOneWidget);

    await $(#shares_review_close).tap();
    await $.pumpAndSettle();
  });
}

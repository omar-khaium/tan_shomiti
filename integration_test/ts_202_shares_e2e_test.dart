import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-202 (e2e): setup demo → assign shares → verify pot', (
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

    await $(#setup_continue_demo).tap();
    await $.pumpAndSettle();

    await $(#nav_more).tap();
    await $.pumpAndSettle();

    await $(#more_shares).scrollTo();
    await $(#more_shares).tap();
    await $.pumpAndSettle();

    // Demo snapshot: S=1000, totalShares=12 => pot=12000 BDT.
    expect(find.text('12000 BDT'), findsWidgets);
    expect(find.text('Not allowed'), findsOneWidget);
    expect(find.text('2'), findsWidgets); // maxSharesPerPerson visible.

    // Make allocations incomplete by reducing member #1 from 2 to 1.
    await $(#shares_decrement_1).tap();
    await $.pumpAndSettle();
    expect(find.textContaining('Allocate 1 more shares'), findsOneWidget);

    // Add that share to member #3 (1 -> 2).
    await $(#shares_row_3).scrollTo();
    await $(#shares_increment_3).tap();
    await $.pumpAndSettle();
    expect(find.textContaining('Allocate 1 more shares'), findsNothing);

    // Persist check: navigate away and back, counts should remain.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_shares).scrollTo();
    await $(#more_shares).tap();
    await $.pumpAndSettle();

    expect(find.byKey(const Key('shares_count_1')), findsOneWidget);
    expect(find.text('1'), findsWidgets);
    await $(#shares_row_3).scrollTo();
    expect(find.byKey(const Key('shares_count_3')), findsOneWidget);
    expect(find.text('2'), findsWidgets);

    await $(#shares_review).scrollTo();
    await $(#shares_review).tap();
    await $.pumpAndSettle();
    expect(find.byKey(const Key('shares_review_dialog')), findsOneWidget);
  });
}

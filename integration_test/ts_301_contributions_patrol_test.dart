import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-301: dues page renders and can switch months', ($) async {
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

    await $(#nav_dues).tap();
    await $.pumpAndSettle();

    final totalFinder = find.byKey(const Key('dues_total_due'));
    for (var i = 0; i < 30; i++) {
      if (totalFinder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(totalFinder, findsOneWidget);

    // Demo snapshot: S=1000, totalShares=12 => total due=12000 BDT.
    expect(find.text('12000 BDT'), findsWidgets);
    expect(find.byKey(const Key('dues_row_1')), findsOneWidget);

    await $(#dues_next_month).tap();
    await $.pumpAndSettle();

    // Next month should also render and generate missing dues if needed.
    final monthLabelFinder = find.byKey(const Key('dues_month_label'));
    for (var i = 0; i < 30; i++) {
      if (monthLabelFinder.evaluate().isNotEmpty) break;
      await $.pump(const Duration(milliseconds: 200));
    }
    expect(monthLabelFinder, findsOneWidget);
    expect(find.text('12000 BDT'), findsWidgets);
    expect(find.byKey(const Key('dues_row_1')), findsOneWidget);
  });
}


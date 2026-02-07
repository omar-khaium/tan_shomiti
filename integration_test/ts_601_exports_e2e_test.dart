import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest('TS-601 e2e: ledger export appends audit event', ($) async {
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

    // Setup shomiti.
    await $(#setup_name_field).enterText('TS601E2E Shomiti');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_member_count_field).enterText('3');
    await $(#setup_share_value_field).enterText('1000');
    await $(#setup_max_shares_field).enterText('1');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_cycle_length_field).enterText('3');
    await $(#setup_meeting_schedule_field).enterText('Monthly');
    await $(#setup_payment_deadline_field).enterText('5th day of the month');
    await $(#setup_next).tap();
    await $.pumpAndSettle();

    await $(#setup_grace_period_days_field).enterText('3');
    await $(#setup_default_consecutive_threshold_field).enterText('2');
    await $(#setup_default_total_threshold_field).enterText('3');
    await $(#setup_next).tap(); // policies -> fees
    await $.pumpAndSettle();

    await $(#setup_next).tap(); // fees -> review
    await $.pumpAndSettle();
    await $(#setup_next).tap(); // finish
    await $.pumpAndSettle();
    await $.pump(const Duration(seconds: 1));

    // Exports: generate ledger CSV.
    await $(#nav_more).tap();
    await $.pumpAndSettle();
    await $(#more_exports).scrollTo();
    await $(#more_exports).tap();
    await $.pumpAndSettle();

    await $(find.text('Ledger')).tap();
    await $.pumpAndSettle();

    await $(#export_ledger_generate).scrollTo();
    await $(#export_ledger_generate).tap();
    await $.pumpAndSettle();

    expect(find.byKey(const Key('export_ledger_path')), findsOneWidget);

    // Back to Exports hub.
    final backFinder = find.byTooltip('Back');
    if (backFinder.evaluate().isNotEmpty) {
      await $(backFinder).tap();
      await $.pumpAndSettle();
    }

    await $(const Key('exports_open_audit')).tap();
    await $.pumpAndSettle();

    expect(find.text('export_generated'), findsWidgets);
  });
}

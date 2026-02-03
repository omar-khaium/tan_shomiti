import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'ts003: open ledger and audit (empty state)',
    ($) async {
      await $.pumpWidgetAndSettle(
        const ProviderScope(
          child: TanShomitiApp(),
        ),
      );

      await $(#setup_continue_demo).tap();
      await $.pumpAndSettle();

      await $(#nav_more).tap();
      await $.pumpAndSettle();

      await $(#more_ledger).scrollTo();
      await $(#more_ledger).tap();
      await $.pump(const Duration(milliseconds: 700));

      expect(find.text('No ledger entries yet'), findsOneWidget);

      await $(#nav_more).tap();
      await $.pumpAndSettle();

      await $(#more_audit).scrollTo();
      await $(#more_audit).tap();
      await $.pump(const Duration(milliseconds: 700));

      expect(find.text('No audit events yet'), findsOneWidget);
    },
  );
}


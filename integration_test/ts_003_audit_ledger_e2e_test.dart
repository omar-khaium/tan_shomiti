import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'ts003 e2e: add demo audit event',
    ($) async {
      await $.pumpWidgetAndSettle(
        ProviderScope(
          key: UniqueKey(),
          child: const TanShomitiApp(),
        ),
      );

      final demoSetupButton = find.byKey(const Key('setup_continue_demo'));
      if (demoSetupButton.evaluate().isNotEmpty) {
        await $(#setup_continue_demo).tap();
        await $.pumpAndSettle();
      }

      await $(#nav_more).tap();
      await $.pumpAndSettle();

      await $(#more_audit).scrollTo();
      await $(#more_audit).tap();
      await $.pump(const Duration(milliseconds: 500));

      await $(#audit_add_demo_event).tap();
      await $.pump(const Duration(milliseconds: 500));

      expect(find.text('demo_event'), findsOneWidget);
    },
  );
}

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'TS-103: open rules viewer (active snapshot)',
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

      await $(#more_rules).scrollTo();
      await $(#more_rules).tap();
      await $.pump(const Duration(milliseconds: 700));

      expect(find.text('Active rules snapshot'), findsOneWidget);
      expect(find.byKey(const Key('rules_version_id')), findsOneWidget);
    },
  );
}


import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'smoke: shell navigation works',
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

        final navMembersFinder = find.byKey(const Key('nav_members'));
        for (var i = 0; i < 150; i++) {
          if (navMembersFinder.evaluate().isNotEmpty) break;
          await $.pump(const Duration(milliseconds: 200));
        }
      }

      await $(#nav_members).tap();
      await $.pumpAndSettle();

      await $(#nav_dues).tap();
      await $.pumpAndSettle();

      await $(#nav_more).tap();
      await $.pumpAndSettle();

      await $(#nav_dashboard).tap();
      await $.pumpAndSettle();
    },
  );
}

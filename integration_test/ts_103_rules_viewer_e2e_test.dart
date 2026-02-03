import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'ts103 e2e: rules viewer shows active version id',
    ($) async {
      await $.pumpWidgetAndSettle(
        ProviderScope(
          key: UniqueKey(),
          child: const TanShomitiApp(),
        ),
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

      await $(#more_rules).scrollTo();
      await $(#more_rules).tap();
      await $.pump(const Duration(milliseconds: 700));

      expect(find.text('Demo Shomiti'), findsOneWidget);
      expect(find.textContaining('rsv_'), findsOneWidget);
      expect(find.byKey(const Key('rules_version_id')), findsOneWidget);
    },
  );
}


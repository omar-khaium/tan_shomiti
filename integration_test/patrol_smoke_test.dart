import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'smoke: shell navigation works',
    ($) async {
      await $.pumpWidgetAndSettle(
        const ProviderScope(
          child: TanShomitiApp(),
        ),
      );

      // Not configured → setup placeholder.
      await $(#setup_continue_demo).tap();
      await $.pumpAndSettle();

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


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'ts002 e2e: open components → back to dashboard',
    ($) async {
      await $.pumpWidgetAndSettle(
        const ProviderScope(
          child: TanShomitiApp(),
        ),
      );

      await $(#setup_continue_demo).tap();
      await $.pumpAndSettle();

      expect(find.text('Dashboard'), findsWidgets);

      await $(#nav_more).tap();
      await $.pumpAndSettle();

      await $(#more_components).scrollTo();
      await $(#more_components).tap();

      // Components page includes loading indicators; avoid `pumpAndSettle`.
      await $.pump(const Duration(milliseconds: 500));

      expect(find.text('Components'), findsWidgets);

      await $(#nav_dashboard).tap();
      await $.pumpAndSettle();

      expect(find.text('Dashboard'), findsWidgets);
    },
  );
}

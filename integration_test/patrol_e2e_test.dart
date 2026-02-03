import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:tan_shomiti/src/app/tan_shomiti_app.dart';

void main() {
  patrolTest(
    'e2e: launch → demo → app states',
    ($) async {
      await $.pumpWidgetAndSettle(
        const ProviderScope(
          child: TanShomitiApp(),
        ),
      );

      // Not configured → setup placeholder.
      await $(#setup_continue_demo).tap();
      await $.pumpAndSettle();

      await $(#nav_more).tap();
      await $.pumpAndSettle();

      await $(#more_app_states).scrollTo();
      await $(#more_app_states).tap();
      // AppStatesPage includes a running progress indicator, so `pumpAndSettle`
      // would never settle.
      await $.pump(const Duration(milliseconds: 500));

      expect(find.text('App states'), findsOneWidget);
      expect(find.text('Loading…'), findsOneWidget);
      expect(find.textContaining('Nothing to show yet.'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/app/router/app_router.dart';
import 'package:tan_shomiti/src/app/shell/app_shell.dart';

import 'helpers/test_app.dart';

void main() {
  testWidgets('App states page shows loading/empty/error', (tester) async {
    await tester.pumpWidget(
      createTestApp(
        overrides: [
          shomitiConfiguredProvider.overrideWith((ref) => true),
        ],
      ),
    );

    expect(find.byType(AppShell), findsOneWidget);

    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.byKey(const Key('more_app_states')),
      300,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('more_app_states')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('App states'), findsOneWidget);
    expect(find.text('Loading'), findsOneWidget);
    expect(find.text('Loading…'), findsOneWidget);
    expect(find.text('Empty'), findsOneWidget);
    expect(find.textContaining('Nothing to show yet'), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/app/router/app_router.dart';
import 'package:tan_shomiti/src/features/defaults/presentation/models/defaults_row_ui_model.dart';
import 'package:tan_shomiti/src/features/defaults/presentation/providers/defaults_providers.dart';

import 'helpers/test_app.dart';

void main() {
  testWidgets('Defaults page opens from More', (tester) async {
    await tester.pumpWidget(
      createTestApp(
        overrides: [
          shomitiConfiguredProvider.overrideWith((ref) => true),
        ],
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(NavigationDestination).at(3));
    await tester.pumpAndSettle();

    final defaultsTile = find.byKey(const Key('more_defaults'));
    await tester.scrollUntilVisible(defaultsTile, 250);
    await tester.tap(defaultsTile);
    await tester.pumpAndSettle();

    expect(find.text(defaultsTitle), findsWidgets);
    expect(find.byKey(const Key('defaults_row_0')), findsOneWidget);
    expect(find.byKey(const Key('defaults_status_0')), findsOneWidget);
    expect(find.byKey(const Key('defaults_record_reminder_0')), findsOneWidget);
    expect(find.byKey(const Key('defaults_record_notice_0')), findsOneWidget);
    expect(find.byKey(const Key('defaults_apply_guarantor_0')), findsOneWidget);
  });

  testWidgets('Defaults page supports empty state', (tester) async {
    await tester.pumpWidget(
      createTestApp(
        overrides: [
          shomitiConfiguredProvider.overrideWith((ref) => true),
          defaultsDashboardRowsProvider.overrideWith(
            (ref) async => const <DefaultsRowUiModel>[],
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(NavigationDestination).at(3));
    await tester.pumpAndSettle();

    final defaultsTile = find.byKey(const Key('more_defaults'));
    await tester.scrollUntilVisible(defaultsTile, 250);
    await tester.tap(defaultsTile);
    await tester.pumpAndSettle();

    expect(find.text('No defaults detected.'), findsOneWidget);
  });
}

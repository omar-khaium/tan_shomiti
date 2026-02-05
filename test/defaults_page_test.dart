import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/app/router/app_router.dart';
import 'package:tan_shomiti/src/features/defaults/presentation/controllers/defaults_controller.dart';
import 'package:tan_shomiti/src/features/defaults/presentation/models/defaults_row_ui_model.dart';
import 'package:tan_shomiti/src/features/defaults/presentation/providers/defaults_controller_providers.dart';

import 'helpers/test_app.dart';

class _FakeDefaultsController extends DefaultsController {
  _FakeDefaultsController(this._rows);

  final List<DefaultsRowUiModel> _rows;

  @override
  Future<List<DefaultsRowUiModel>> build() async => _rows;
}

void main() {
  testWidgets('Defaults page opens from More', (tester) async {
    await tester.pumpWidget(
      createTestApp(
        overrides: [
          shomitiConfiguredProvider.overrideWith((ref) => true),
          defaultsControllerProvider.overrideWith(
            () => _FakeDefaultsController(const [
              DefaultsRowUiModel(
                memberId: 'm1',
                memberName: 'Member 1',
                status: DefaultsStatusUi.atRisk,
                missedCount: 1,
                episodeKey: '2026-01',
                nextStep: DefaultsNextStepUi.reminder,
              ),
            ]),
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
          defaultsControllerProvider.overrideWith(
            () => _FakeDefaultsController(const <DefaultsRowUiModel>[]),
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

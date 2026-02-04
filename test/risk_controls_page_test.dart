import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/risk_controls/presentation/models/risk_controls_ui_state.dart';
import 'package:tan_shomiti/src/features/risk_controls/presentation/providers/risk_controls_providers.dart';
import 'package:tan_shomiti/src/features/risk_controls/presentation/risk_controls_page.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const RiskControlsPage(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('Risk controls page shows loading state', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        riskControlsUiStateProvider.overrideWithValue(
          const AsyncValue.loading(),
        ),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
  });

  testWidgets('Risk controls page shows error state', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        riskControlsUiStateProvider.overrideWithValue(
          AsyncValue.error(Exception('boom'), StackTrace.empty),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load risk controls.'), findsOneWidget);
  });

  testWidgets('Risk controls page shows empty state when no members', (
    tester,
  ) async {
    await pumpPage(
      tester,
      overrides: [
        riskControlsUiStateProvider.overrideWithValue(
          const AsyncValue.data(null),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('No members yet'), findsOneWidget);
  });

  testWidgets('Risk controls page shows rows when data is available', (
    tester,
  ) async {
    final state = RiskControlsUiState(
      rows: const [
        RiskControlRow(
          memberId: 'm1',
          position: 1,
          displayName: 'Alice',
          status: RiskControlStatus.missing,
        ),
        RiskControlRow(
          memberId: 'm2',
          position: 2,
          displayName: 'Bob',
          status: RiskControlStatus.guarantorRecorded,
        ),
      ],
    );

    await pumpPage(
      tester,
      overrides: [
        riskControlsUiStateProvider.overrideWithValue(AsyncValue.data(state)),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('risk_row_1')), findsOneWidget);
    expect(find.byKey(const Key('risk_actions_1')), findsOneWidget);
    expect(find.text('Alice'), findsOneWidget);
    expect(find.textContaining('Missing'), findsOneWidget);
  });
}

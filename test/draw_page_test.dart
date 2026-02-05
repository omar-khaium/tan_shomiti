import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/core/ui/components/app_button.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/draw/presentation/draw_page.dart';
import 'package:tan_shomiti/src/features/draw/presentation/models/draw_ui_state.dart';
import 'package:tan_shomiti/src/features/draw/presentation/providers/draw_providers.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(theme: AppTheme.light(), home: const DrawPage()),
      ),
    );
    await tester.pump();
  }

  testWidgets('Draw page shows loading state', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        drawUiStateProvider.overrideWith((ref) => const AsyncLoading()),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
  });

  testWidgets('Draw page shows error state', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        drawUiStateProvider.overrideWith(
          (ref) => AsyncValue<DrawUiState>.error(
            Exception('boom'),
            StackTrace.empty,
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load eligibility.'), findsOneWidget);
  });

  testWidgets('Draw page shows empty state when no dues exist', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        drawUiStateProvider.overrideWith(
          (ref) => AsyncData(
            DrawUiState(
              shomitiId: 'active',
              ruleSetVersionId: 'rsv_1',
              month: const BillingMonth(year: 2026, month: 1),
              hasDuesForMonth: false,
              summary: const DrawEligibilitySummary(
                eligibleEntries: 0,
                ineligibleEntries: 0,
                ineligibleReasons: {},
              ),
              rows: const [],
              eligibleShares: const [],
              recordedDrawId: null,
            ),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('No dues generated for this month yet'), findsOneWidget);

    final button = tester.widget<AppButton>(
      find.byKey(const Key('eligibility_run_draw')),
    );
    expect(button.onPressed, isNull);
    expect(find.byKey(const Key('eligibility_month_label')), findsOneWidget);
  });
}

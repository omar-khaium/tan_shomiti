import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/components/app_button.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/statements/presentation/models/statements_ui_state.dart';
import 'package:tan_shomiti/src/features/statements/presentation/statement_detail_page.dart';
import 'package:tan_shomiti/src/features/statements/presentation/statements_overview_page.dart';
import 'package:tan_shomiti/src/features/statements/presentation/providers/statements_providers.dart';

void main() {
  Future<void> pumpOverview(
    WidgetTester tester, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const StatementsOverviewPage(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('Statements overview shows loading state', (tester) async {
    await pumpOverview(
      tester,
      overrides: [
        statementsUiStateProvider.overrideWith((ref) => const AsyncLoading()),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
  });

  testWidgets('Statements overview shows required keys', (tester) async {
    await pumpOverview(
      tester,
      overrides: [
        statementsUiStateProvider.overrideWith(
          (ref) => const AsyncData(
            StatementsUiState(
              month: BillingMonth(year: 2026, month: 2),
              isReadyToGenerate: false,
            ),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('statement_month_label')), findsOneWidget);
    expect(find.byKey(const Key('statement_ready_badge')), findsOneWidget);
    expect(find.byKey(const Key('statement_generate')), findsOneWidget);

    final button =
        tester.widget<AppButton>(find.byKey(const Key('statement_generate')));
    expect(button.onPressed, isNull);
  });

  testWidgets('Statements overview enables generate when ready', (tester) async {
    await pumpOverview(
      tester,
      overrides: [
        statementsUiStateProvider.overrideWith(
          (ref) => const AsyncData(
            StatementsUiState(
              month: BillingMonth(year: 2026, month: 2),
              isReadyToGenerate: true,
            ),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    final button =
        tester.widget<AppButton>(find.byKey(const Key('statement_generate')));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Statement detail shows required keys', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const StatementDetailPage()),
    );

    expect(find.byKey(const Key('statement_total_due')), findsOneWidget);
    expect(find.byKey(const Key('statement_total_collected')), findsOneWidget);
    expect(find.byKey(const Key('statement_shortfall')), findsOneWidget);
    expect(find.byKey(const Key('statement_winner_label')), findsOneWidget);
    expect(find.byKey(const Key('statement_draw_proof')), findsOneWidget);
    expect(find.byKey(const Key('statement_payout_proof')), findsOneWidget);
  });
}


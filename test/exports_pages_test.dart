import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/exports/presentation/exports_page.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/domain/entities/shomiti.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import 'package:tan_shomiti/src/features/statements/domain/entities/monthly_statement.dart';
import 'package:tan_shomiti/src/features/statements/presentation/providers/statements_domain_providers.dart';
import 'package:tan_shomiti/src/features/exports/presentation/export_statement_page.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester,
    Widget page, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(theme: AppTheme.light(), home: page),
      ),
    );
    await tester.pump();
  }

  testWidgets('Exports page shows privacy notice and tiles', (tester) async {
    await pumpPage(tester, const ExportsPage());

    expect(find.byKey(const Key('exports_privacy_notice')), findsOneWidget);
    expect(find.text('Statements'), findsOneWidget);
    expect(find.text('Ledger'), findsOneWidget);
  });

  testWidgets('Export statement page shows loading while shomiti loads', (
    tester,
  ) async {
    final controller = StreamController<Shomiti?>();
    await pumpPage(
      tester,
      const ExportStatementPage(),
      overrides: [
        activeShomitiProvider.overrideWith((ref) => controller.stream),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
    await controller.close();
  });

  testWidgets('Export statement page shows empty when no statement exists', (
    tester,
  ) async {
    final now = DateTime.utc(2026, 2, 7, 12);
    await pumpPage(
      tester,
      const ExportStatementPage(),
      overrides: [
        activeShomitiProvider.overrideWith(
          (ref) => Stream.value(
            Shomiti(
              id: activeShomitiId,
              name: 'Demo',
              startDate: now,
              createdAt: now,
              activeRuleSetVersionId: 'rsv_1',
            ),
          ),
        ),
        statementByMonthProvider.overrideWith((ref, args) => Stream.value(null)),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('export_statement_empty')), findsOneWidget);
  });

  testWidgets('Export statement page shows ready when statement exists', (
    tester,
  ) async {
    final now = DateTime.utc(2026, 2, 7, 12);
    await pumpPage(
      tester,
      const ExportStatementPage(),
      overrides: [
        activeShomitiProvider.overrideWith(
          (ref) => Stream.value(
            Shomiti(
              id: activeShomitiId,
              name: 'Demo',
              startDate: now,
              createdAt: now,
              activeRuleSetVersionId: 'rsv_1',
            ),
          ),
        ),
        statementByMonthProvider.overrideWith(
          (ref, args) => Stream.value(
            MonthlyStatement(
              shomitiId: activeShomitiId,
              month: args.month,
              ruleSetVersionId: 'rsv_1',
              generatedAt: now,
              totalDueBdt: 100,
              totalCollectedBdt: 100,
              coveredBdt: 0,
              shortfallBdt: 0,
              winnerLabel: 'Winner',
              drawProofReference: 'draw-1',
              payoutProofReference: 'payout-1',
            ),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('export_statement_ready')), findsOneWidget);
  });
}

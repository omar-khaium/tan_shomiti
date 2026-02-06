import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/components/app_button.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/domain/entities/shomiti.dart';
import 'package:tan_shomiti/src/features/statements/presentation/models/statements_ui_state.dart';
import 'package:tan_shomiti/src/features/statements/presentation/statement_detail_page.dart';
import 'package:tan_shomiti/src/features/statements/presentation/statements_overview_page.dart';
import 'package:tan_shomiti/src/features/statements/domain/entities/monthly_statement.dart';
import 'package:tan_shomiti/src/features/statements/domain/repositories/statements_repository.dart';
import 'package:tan_shomiti/src/features/statements/presentation/providers/statements_domain_providers.dart';
import 'package:tan_shomiti/src/features/statements/presentation/providers/statements_providers.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/audit/presentation/providers/audit_providers.dart';

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
              hasGeneratedStatement: false,
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
              hasGeneratedStatement: false,
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
    final shomiti = Shomiti(
      id: 'active',
      name: 'Demo',
      startDate: DateTime.utc(2026, 1, 1),
      createdAt: DateTime.utc(2026, 1, 1),
      activeRuleSetVersionId: 'rsv_1',
    );
    const month = BillingMonth(year: 2026, month: 2);
    final statement = MonthlyStatement(
      shomitiId: shomiti.id,
      month: month,
      ruleSetVersionId: 'rsv_1',
      generatedAt: DateTime.utc(2026, 2, 5),
      totalDueBdt: 3000,
      totalCollectedBdt: 3000,
      coveredBdt: 0,
      shortfallBdt: 0,
      winnerLabel: 'Member 1 (share 0)',
      drawProofReference: 'vid-1',
      payoutProofReference: 'trx-1',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeShomitiProvider.overrideWith(
            (ref) => Stream<Shomiti?>.value(shomiti),
          ),
          statementsUiStateProvider.overrideWith(
            (ref) => const AsyncData(
              StatementsUiState(
                month: month,
                isReadyToGenerate: true,
                hasGeneratedStatement: true,
              ),
            ),
          ),
          statementsRepositoryProvider.overrideWithValue(
            _FakeStatementsRepository(statement),
          ),
          appendAuditEventProvider.overrideWith(
            (ref) => AppendAuditEvent(_FakeAuditRepository()),
          ),
        ],
        child: MaterialApp(theme: AppTheme.light(), home: const StatementDetailPage()),
      ),
    );
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      if (find.byKey(const Key('statement_total_due')).evaluate().isNotEmpty) {
        break;
      }
    }

    expect(find.byKey(const Key('statement_total_due')), findsOneWidget);
    expect(find.byKey(const Key('statement_total_collected')), findsOneWidget);
    expect(find.byKey(const Key('statement_shortfall')), findsOneWidget);
    expect(find.byKey(const Key('statement_winner_label')), findsOneWidget);
    expect(find.byKey(const Key('statement_draw_proof')), findsOneWidget);
    expect(find.byKey(const Key('statement_payout_proof')), findsOneWidget);
  });
}

class _FakeStatementsRepository implements StatementsRepository {
  _FakeStatementsRepository(this._statement);

  final MonthlyStatement _statement;

  @override
  Future<MonthlyStatement?> getStatement({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    return (shomitiId == _statement.shomitiId && month == _statement.month)
        ? _statement
        : null;
  }

  @override
  Stream<MonthlyStatement?> watchStatement({
    required String shomitiId,
    required BillingMonth month,
  }) {
    return Stream.value(
      (shomitiId == _statement.shomitiId && month == _statement.month)
          ? _statement
          : null,
    );
  }

  @override
  Future<void> upsertStatement(MonthlyStatement statement) async {}
}

class _FakeAuditRepository implements AuditRepository {
  @override
  Future<void> append(NewAuditEvent event) async {}

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 100}) =>
      const Stream<List<AuditEvent>>.empty();
}

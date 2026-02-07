import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/core/domain/money_bdt.dart';
import 'package:tan_shomiti/src/features/audit/data/drift_audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/exports/data/csv/csv_escape.dart';
import 'package:tan_shomiti/src/features/exports/data/csv/ledger_csv_exporter.dart';
import 'package:tan_shomiti/src/features/exports/data/csv/statement_csv_exporter.dart';
import 'package:tan_shomiti/src/features/exports/data/io_export_file_store.dart';
import 'package:tan_shomiti/src/features/exports/domain/entities/export_format.dart';
import 'package:tan_shomiti/src/features/exports/domain/entities/export_redaction.dart';
import 'package:tan_shomiti/src/features/exports/domain/entities/export_result.dart';
import 'package:tan_shomiti/src/features/exports/domain/gateways/platform_share_gateway.dart';
import 'package:tan_shomiti/src/features/exports/domain/usecases/export_exceptions.dart';
import 'package:tan_shomiti/src/features/exports/domain/usecases/generate_ledger_export.dart';
import 'package:tan_shomiti/src/features/exports/domain/usecases/generate_statement_export.dart';
import 'package:tan_shomiti/src/features/exports/domain/usecases/share_export.dart';
import 'package:tan_shomiti/src/features/ledger/data/drift_ledger_repository.dart';
import 'package:tan_shomiti/src/features/ledger/domain/entities/ledger_entry.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/domain/entities/shomiti.dart';
import 'package:tan_shomiti/src/features/statements/domain/entities/monthly_statement.dart';
import 'package:tan_shomiti/src/features/statements/domain/repositories/statements_repository.dart';

void main() {
  test('csvEscape quotes commas, quotes, and newlines', () {
    expect(csvEscape('plain'), 'plain');
    expect(csvEscape('a,b'), '"a,b"');
    expect(csvEscape('a"b'), '"a""b"');
    expect(csvEscape('a\nb'), '"a\nb"');
  });

  test('statementToCsv redacts winner name when configured', () {
    final statement = MonthlyStatement(
      shomitiId: activeShomitiId,
      month: const BillingMonth(year: 2026, month: 2),
      ruleSetVersionId: 'rsv_1',
      generatedAt: DateTime.utc(2026, 2, 7, 12),
      totalDueBdt: 100,
      totalCollectedBdt: 100,
      coveredBdt: 0,
      shortfallBdt: 0,
      winnerLabel: 'Member 1 (share 1)',
      drawProofReference: 'draw-1',
      payoutProofReference: 'payout-1',
    );

    final csvRedacted = statementToCsv(
      statement,
      const ExportRedaction(
        includeFreeTextNotes: false,
        includeMemberNames: false,
        includeProofReferences: true,
      ),
    );
    expect(csvRedacted, contains('Winner (redacted)'));
    expect(csvRedacted, isNot(contains('Member 1')));
  });

  test('ledgerToCsv redacts notes when configured', () {
    final entries = [
      LedgerEntry(
        id: 1,
        amount: MoneyBdt.fromMinorUnits(1000),
        direction: LedgerDirection.incoming,
        occurredAt: DateTime.utc(2026, 2, 7, 12),
        category: 'contribution',
        note: 'sensitive note',
      ),
    ];

    final csvRedacted = ledgerToCsv(
      entries,
      const ExportRedaction(
        includeFreeTextNotes: false,
        includeMemberNames: false,
        includeProofReferences: true,
      ),
    );
    expect(csvRedacted, isNot(contains('sensitive note')));
  });

  test('GenerateStatementExport writes file and appends audit event', () async {
    final statement = MonthlyStatement(
      shomitiId: activeShomitiId,
      month: const BillingMonth(year: 2026, month: 2),
      ruleSetVersionId: 'rsv_1',
      generatedAt: DateTime.utc(2026, 2, 7, 12),
      totalDueBdt: 100,
      totalCollectedBdt: 100,
      coveredBdt: 0,
      shortfallBdt: 0,
      winnerLabel: 'Member 1 (share 1)',
      drawProofReference: 'draw-1',
      payoutProofReference: 'payout-1',
    );

    final db = AppDatabase.memory();
    addTearDown(db.close);
    final auditRepo = DriftAuditRepository(db);
    final appendAudit = AppendAuditEvent(auditRepo);

    final tempDir = await Directory.systemTemp.createTemp('exports_test_');
    addTearDown(() => tempDir.delete(recursive: true));
    final store = IoExportFileStore(baseDir: () async => tempDir);

    final usecase = GenerateStatementExport(
      statementsRepository: _FakeStatementsRepository(statement),
      fileStore: store,
      appendAuditEvent: appendAudit,
    );

    final result = await usecase(
      shomitiId: activeShomitiId,
      month: statement.month,
      format: ExportFormat.csv,
      redaction: ExportRedaction.defaults(),
      now: DateTime.utc(2026, 2, 7, 13),
    );
    expect(File(result.filePath).existsSync(), isTrue);

    final events = await auditRepo.watchLatest().first;
    expect(events.first.action, 'export_generated');
  });

  test('GenerateLedgerExport validates limit and appends audit event', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);
    final auditRepo = DriftAuditRepository(db);
    final appendAudit = AppendAuditEvent(auditRepo);

    final tempDir = await Directory.systemTemp.createTemp('exports_test_');
    addTearDown(() => tempDir.delete(recursive: true));
    final store = IoExportFileStore(baseDir: () async => tempDir);

    final ledgerRepo = DriftLedgerRepository(db);

    final usecase = GenerateLedgerExport(
      ledgerRepository: ledgerRepo,
      fileStore: store,
      appendAuditEvent: appendAudit,
    );

    await expectLater(
      usecase(
        limit: 0,
        format: ExportFormat.csv,
        redaction: ExportRedaction.defaults(),
        now: DateTime.utc(2026, 2, 7, 13),
      ),
      throwsA(isA<ExportException>()),
    );

    final result = await usecase(
      limit: 50,
      format: ExportFormat.csv,
      redaction: ExportRedaction.defaults(),
      now: DateTime.utc(2026, 2, 7, 13),
    );
    expect(File(result.filePath).existsSync(), isTrue);
    final events = await auditRepo.watchLatest().first;
    expect(events.first.action, 'export_generated');
  });

  test('ShareExport requires consent reference and appends audit event', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);
    final auditRepo = DriftAuditRepository(db);
    final appendAudit = AppendAuditEvent(auditRepo);

    final gateway = _FakeShareGateway();
    final share = ShareExport(
      shareGateway: gateway,
      appendAuditEvent: appendAudit,
    );

    await expectLater(
      share(
        export: const ExportResult(
          filePath: '/tmp/file.csv',
          fileName: 'file.csv',
          mimeType: 'text/csv',
        ),
        consentReference: ' ',
        now: DateTime.utc(2026, 2, 7, 14),
      ),
      throwsA(isA<ExportException>()),
    );

    await share(
      export: const ExportResult(
        filePath: '/tmp/file.csv',
        fileName: 'file.csv',
        mimeType: 'text/csv',
      ),
      consentReference: 'chat-msg-1',
      now: DateTime.utc(2026, 2, 7, 14),
    );
    expect(gateway.calls, 1);

    final events = await auditRepo.watchLatest().first;
    expect(events.first.action, 'export_shared');
  });
}

final class _FakeStatementsRepository implements StatementsRepository {
  const _FakeStatementsRepository(this._statement);

  final MonthlyStatement _statement;

  @override
  Stream<MonthlyStatement?> watchStatement({
    required String shomitiId,
    required BillingMonth month,
  }) {
    if (shomitiId != _statement.shomitiId || month != _statement.month) {
      return Stream.value(null);
    }
    return Stream.value(_statement);
  }

  @override
  Future<void> upsertStatement(MonthlyStatement statement) async {}

  @override
  Future<MonthlyStatement?> getStatement({
    required String shomitiId,
    required BillingMonth month,
  }) async =>
      shomitiId == _statement.shomitiId && month == _statement.month
          ? _statement
          : null;
}

final class _FakeShareGateway implements PlatformShareGateway {
  int calls = 0;

  @override
  Future<void> shareFile({
    required ExportResult export,
    required String text,
  }) async {
    calls++;
  }
}

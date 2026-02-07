import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../../statements/domain/repositories/statements_repository.dart';
import '../entities/export_format.dart';
import '../entities/export_redaction.dart';
import '../entities/export_result.dart';
import '../repositories/export_file_store.dart';
import 'export_exceptions.dart';
import '../../data/csv/statement_csv_exporter.dart';

class GenerateStatementExport {
  const GenerateStatementExport({
    required StatementsRepository statementsRepository,
    required ExportFileStore fileStore,
    required AppendAuditEvent appendAuditEvent,
  })  : _statementsRepository = statementsRepository,
        _fileStore = fileStore,
        _appendAuditEvent = appendAuditEvent;

  final StatementsRepository _statementsRepository;
  final ExportFileStore _fileStore;
  final AppendAuditEvent _appendAuditEvent;

  Future<ExportResult> call({
    required String shomitiId,
    required BillingMonth month,
    required ExportFormat format,
    required ExportRedaction redaction,
    required DateTime now,
  }) async {
    if (format != ExportFormat.csv) {
      throw const ExportException('PDF export is not available yet.');
    }

    final statement = await _statementsRepository
        .watchStatement(shomitiId: shomitiId, month: month)
        .first;
    if (statement == null) {
      throw const ExportException('No statement exists for this month.');
    }

    final fileName = 'statement_${month.key}.csv';
    final csv = statementToCsv(statement, redaction);
    final stored = await _fileStore.writeText(
      fileName: fileName,
      contents: csv,
      mimeType: 'text/csv',
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'export_generated',
        occurredAt: now,
        message: 'Generated export file.',
        metadataJson: jsonEncode({
          'kind': 'statement',
          'shomitiId': shomitiId,
          'monthKey': month.key,
          'format': format.name,
          'redaction': redaction.toJson(),
          'fileName': stored.fileName,
        }),
      ),
    );

    return ExportResult(
      filePath: stored.path,
      fileName: stored.fileName,
      mimeType: stored.mimeType,
    );
  }
}


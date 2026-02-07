import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../ledger/domain/repositories/ledger_repository.dart';
import '../entities/export_format.dart';
import '../entities/export_redaction.dart';
import '../entities/export_result.dart';
import '../repositories/export_file_store.dart';
import 'export_exceptions.dart';
import '../../data/csv/ledger_csv_exporter.dart';

class GenerateLedgerExport {
  const GenerateLedgerExport({
    required LedgerRepository ledgerRepository,
    required ExportFileStore fileStore,
    required AppendAuditEvent appendAuditEvent,
  })  : _ledgerRepository = ledgerRepository,
        _fileStore = fileStore,
        _appendAuditEvent = appendAuditEvent;

  final LedgerRepository _ledgerRepository;
  final ExportFileStore _fileStore;
  final AppendAuditEvent _appendAuditEvent;

  Future<ExportResult> call({
    required int limit,
    required ExportFormat format,
    required ExportRedaction redaction,
    required DateTime now,
  }) async {
    if (limit <= 0) throw const ExportException('Limit must be > 0.');
    if (format != ExportFormat.csv) {
      throw const ExportException('PDF export is not available yet.');
    }

    final entries = await _ledgerRepository.watchLatest(limit: limit).first;
    final fileName = 'ledger_latest_$limit.csv';
    final csv = ledgerToCsv(entries, redaction);
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
          'kind': 'ledger',
          'format': format.name,
          'limit': limit,
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


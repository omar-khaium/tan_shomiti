import '../../../ledger/domain/entities/ledger_entry.dart';
import '../../domain/entities/export_redaction.dart';
import 'csv_escape.dart';

String ledgerToCsv(List<LedgerEntry> entries, ExportRedaction redaction) {
  final header = csvRow([
    'id',
    'occurredAt',
    'direction',
    'category',
    'amountMinor',
    'note',
  ]);

  final rows = entries.map((e) {
    final note = redaction.includeFreeTextNotes ? (e.note ?? '') : '';
    final dir = e.direction == LedgerDirection.incoming ? 'in' : 'out';
    return csvRow([
      e.id.toString(),
      e.occurredAt.toIso8601String(),
      dir,
      e.category ?? '',
      e.amount.minorUnits.toString(),
      note,
    ]);
  }).join();

  return header + rows;
}

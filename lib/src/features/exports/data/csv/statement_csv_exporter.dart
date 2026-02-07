import '../../../statements/domain/entities/monthly_statement.dart';
import '../../domain/entities/export_redaction.dart';
import 'csv_escape.dart';

String statementToCsv(MonthlyStatement statement, ExportRedaction redaction) {
  final winner = redaction.includeMemberNames
      ? statement.winnerLabel
      : 'Winner (redacted)';
  final drawRef =
      redaction.includeProofReferences ? statement.drawProofReference : '';
  final payoutRef =
      redaction.includeProofReferences ? statement.payoutProofReference : '';

  final header = csvRow([
    'shomitiId',
    'monthKey',
    'ruleSetVersionId',
    'generatedAt',
    'totalDueBdt',
    'totalCollectedBdt',
    'coveredBdt',
    'shortfallBdt',
    'winnerLabel',
    'drawProofReference',
    'payoutProofReference',
  ]);

  final row = csvRow([
    statement.shomitiId,
    statement.month.key,
    statement.ruleSetVersionId,
    statement.generatedAt.toIso8601String(),
    statement.totalDueBdt.toString(),
    statement.totalCollectedBdt.toString(),
    statement.coveredBdt.toString(),
    statement.shortfallBdt.toString(),
    winner,
    drawRef,
    payoutRef,
  ]);

  return header + row;
}

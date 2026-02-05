import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/draw_record.dart';
import '../repositories/draw_records_repository.dart';
import 'witness_exceptions.dart';

class InvalidateDrawRecord {
  const InvalidateDrawRecord({
    required DrawRecordsRepository drawRecordsRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _drawRecordsRepository = drawRecordsRepository,
       _appendAuditEvent = appendAuditEvent;

  final DrawRecordsRepository _drawRecordsRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String drawId,
    required String reason,
    required DateTime now,
  }) async {
    final draw = await _drawRecordsRepository.getById(id: drawId);
    if (draw == null) {
      throw const DrawWitnessException('Draw record not found.');
    }
    final trimmed = reason.trim();
    if (trimmed.isEmpty) {
      throw const DrawWitnessException('Redo reason is required.');
    }
    if (draw.isInvalidated) return;

    await _drawRecordsRepository.upsert(
      DrawRecord(
        id: draw.id,
        shomitiId: draw.shomitiId,
        month: draw.month,
        ruleSetVersionId: draw.ruleSetVersionId,
        method: draw.method,
        proofReference: draw.proofReference,
        notes: draw.notes,
        winnerMemberId: draw.winnerMemberId,
        winnerShareIndex: draw.winnerShareIndex,
        eligibleShareKeys: draw.eligibleShareKeys,
        redoOfDrawId: draw.redoOfDrawId,
        invalidatedAt: now,
        invalidatedReason: trimmed,
        finalizedAt: draw.finalizedAt,
        recordedAt: draw.recordedAt,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'draw_invalidated',
        occurredAt: now,
        message: 'Draw invalidated for redo.',
        metadataJson: '{"drawId":"$drawId"}',
      ),
    );
  }
}

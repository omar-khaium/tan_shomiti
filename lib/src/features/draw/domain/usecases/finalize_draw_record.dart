import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/draw_record.dart';
import '../repositories/draw_records_repository.dart';
import '../repositories/draw_witness_repository.dart';
import 'witness_exceptions.dart';

class FinalizeDrawRecord {
  const FinalizeDrawRecord({
    required DrawRecordsRepository drawRecordsRepository,
    required DrawWitnessRepository drawWitnessRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _drawRecordsRepository = drawRecordsRepository,
       _drawWitnessRepository = drawWitnessRepository,
       _appendAuditEvent = appendAuditEvent;

  final DrawRecordsRepository _drawRecordsRepository;
  final DrawWitnessRepository _drawWitnessRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String drawId,
    required DateTime now,
  }) async {
    final draw = await _drawRecordsRepository.getById(id: drawId);
    if (draw == null) {
      throw const DrawWitnessException('Draw record not found.');
    }
    if (draw.isInvalidated) {
      throw const DrawWitnessException('Cannot finalize an invalidated draw.');
    }
    if (draw.finalizedAt != null) return;

    final approvals = await _drawWitnessRepository.listApprovals(drawId: drawId);
    if (approvals.length < 2) {
      throw const DrawWitnessException('At least 2 witness sign-offs are required.');
    }

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
        invalidatedAt: draw.invalidatedAt,
        invalidatedReason: draw.invalidatedReason,
        finalizedAt: now,
        recordedAt: draw.recordedAt,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'draw_finalized',
        occurredAt: now,
        message: 'Draw finalized with witness approvals.',
        metadataJson: '{"drawId":"$drawId","witnessCount":${approvals.length}}',
      ),
    );
  }
}

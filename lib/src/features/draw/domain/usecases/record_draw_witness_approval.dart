import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/draw_witness_approval.dart';
import '../repositories/draw_witness_repository.dart';
import 'witness_exceptions.dart';

class RecordDrawWitnessApproval {
  const RecordDrawWitnessApproval({
    required DrawWitnessRepository repository,
    required AppendAuditEvent appendAuditEvent,
  }) : _repository = repository,
       _appendAuditEvent = appendAuditEvent;

  final DrawWitnessRepository _repository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String drawId,
    required String witnessMemberId,
    required String ruleSetVersionId,
    required String? note,
    required DateTime now,
  }) async {
    if (witnessMemberId.trim().isEmpty) {
      throw const DrawWitnessException('Witness member is required.');
    }

    final existing = await _repository.listApprovals(drawId: drawId);
    if (existing.any((a) => a.witnessMemberId == witnessMemberId)) {
      throw const DrawWitnessException('This witness already signed off.');
    }

    await _repository.upsertApproval(
      DrawWitnessApproval(
        drawId: drawId,
        witnessMemberId: witnessMemberId,
        ruleSetVersionId: ruleSetVersionId,
        note: note?.trim().isEmpty == true ? null : note?.trim(),
        approvedAt: now,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'draw_witness_signed',
        occurredAt: now,
        message: 'Witness sign-off recorded.',
        metadataJson: '{"drawId":"$drawId","witnessMemberId":"$witnessMemberId"}',
      ),
    );
  }
}


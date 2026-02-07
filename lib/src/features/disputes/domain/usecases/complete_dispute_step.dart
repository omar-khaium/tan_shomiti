import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/dispute_step.dart';
import '../repositories/disputes_repository.dart';
import 'disputes_exceptions.dart';

class CompleteDisputeStep {
  const CompleteDisputeStep({
    required DisputesRepository disputesRepository,
    required AppendAuditEvent appendAuditEvent,
  })  : _repository = disputesRepository,
        _appendAuditEvent = appendAuditEvent;

  final DisputesRepository _repository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String disputeId,
    required DisputeStep step,
    required String note,
    required String? proofReference,
    required DateTime now,
  }) async {
    if (step == DisputeStep.finalOutcome) {
      throw const DisputesValidationException(
        'Use resolve for the final outcome.',
      );
    }
    if (note.trim().isEmpty) {
      throw const DisputesValidationException('Note is required.');
    }

    final dispute = await _repository.getById(
      shomitiId: shomitiId,
      disputeId: disputeId,
    );
    if (dispute == null) {
      throw const DisputesValidationException('Dispute not found.');
    }
    if (!dispute.canCompleteStep(step)) {
      throw const DisputesValidationException(
        'Step cannot be completed out of order.',
      );
    }

    await _repository.completeStep(
      shomitiId: shomitiId,
      disputeId: disputeId,
      step: step,
      note: note,
      proofReference: proofReference,
      now: now,
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'dispute_step_completed',
        occurredAt: now,
        message: 'Dispute step completed.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'disputeId': disputeId,
          'step': step.name,
        }),
      ),
    );
  }
}


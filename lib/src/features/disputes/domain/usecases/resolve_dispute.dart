import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../repositories/disputes_repository.dart';
import 'disputes_exceptions.dart';

class ResolveDispute {
  const ResolveDispute({
    required DisputesRepository disputesRepository,
    required AppendAuditEvent appendAuditEvent,
  })  : _repository = disputesRepository,
        _appendAuditEvent = appendAuditEvent;

  final DisputesRepository _repository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String disputeId,
    required String outcomeNote,
    required String? proofReference,
    required DateTime now,
  }) async {
    if (outcomeNote.trim().isEmpty) {
      throw const DisputesValidationException('Outcome note is required.');
    }

    final dispute = await _repository.getById(
      shomitiId: shomitiId,
      disputeId: disputeId,
    );
    if (dispute == null) {
      throw const DisputesValidationException('Dispute not found.');
    }
    if (!dispute.canResolve) {
      throw const DisputesValidationException(
        'Complete Steps 1–3 before resolving.',
      );
    }

    await _repository.resolve(
      shomitiId: shomitiId,
      disputeId: disputeId,
      outcomeNote: outcomeNote,
      proofReference: proofReference,
      now: now,
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'dispute_resolved',
        occurredAt: now,
        message: 'Dispute resolved.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'disputeId': disputeId,
        }),
      ),
    );
  }
}


import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../repositories/disputes_repository.dart';
import 'disputes_exceptions.dart';

class ReopenDispute {
  const ReopenDispute({
    required DisputesRepository disputesRepository,
    required AppendAuditEvent appendAuditEvent,
  })  : _repository = disputesRepository,
        _appendAuditEvent = appendAuditEvent;

  final DisputesRepository _repository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String disputeId,
    required String note,
    required DateTime now,
  }) async {
    if (note.trim().isEmpty) {
      throw const DisputesValidationException('Reopen note is required.');
    }

    await _repository.reopen(
      shomitiId: shomitiId,
      disputeId: disputeId,
      note: note,
      now: now,
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'dispute_reopened',
        occurredAt: now,
        message: 'Dispute reopened.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'disputeId': disputeId,
          'note': note.trim(),
        }),
      ),
    );
  }
}


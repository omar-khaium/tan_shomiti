import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../repositories/disputes_repository.dart';
import 'disputes_exceptions.dart';

class CreateDispute {
  const CreateDispute({
    required DisputesRepository repository,
    required AppendAuditEvent appendAuditEvent,
  })  : _repository = repository,
        _appendAuditEvent = appendAuditEvent;

  final DisputesRepository _repository;
  final AppendAuditEvent _appendAuditEvent;

  Future<String> call({
    required String shomitiId,
    required String title,
    required String description,
    required DateTime now,
    required String? relatedMonthKey,
    required String? involvedMembersText,
    required List<String> evidenceReferences,
  }) async {
    if (title.trim().isEmpty) {
      throw const DisputesValidationException('Title is required.');
    }
    if (description.trim().isEmpty) {
      throw const DisputesValidationException('Description is required.');
    }

    final id = await _repository.createDispute(
      shomitiId: shomitiId,
      title: title,
      description: description,
      now: now,
      relatedMonthKey: relatedMonthKey,
      involvedMembersText: involvedMembersText,
      evidenceReferences: evidenceReferences,
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'dispute_created',
        occurredAt: now,
        message: 'Dispute created.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'disputeId': id,
        }),
      ),
    );

    return id;
  }
}


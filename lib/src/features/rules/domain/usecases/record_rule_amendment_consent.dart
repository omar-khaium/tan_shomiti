import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../members/domain/entities/member_consent.dart';
import '../../../members/domain/repositories/member_consents_repository.dart';

class RecordRuleAmendmentConsent {
  const RecordRuleAmendmentConsent({
    required MemberConsentsRepository consentsRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _consentsRepository = consentsRepository,
       _appendAuditEvent = appendAuditEvent;

  final MemberConsentsRepository _consentsRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String memberId,
    required String ruleSetVersionId,
    required ConsentProofType proofType,
    required String proofReference,
    required DateTime now,
  }) async {
    final trimmed = proofReference.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(proofReference, 'proofReference', 'Required');
    }

    await _consentsRepository.upsert(
      MemberConsent(
        shomitiId: shomitiId,
        memberId: memberId,
        ruleSetVersionId: ruleSetVersionId,
        proofType: proofType,
        proofReference: trimmed,
        signedAt: now,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'rule_change_consent_recorded',
        occurredAt: now,
        message: 'Recorded consent for rule change.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': memberId,
          'ruleSetVersionId': ruleSetVersionId,
          'proofType': proofType.name,
        }),
      ),
    );
  }
}


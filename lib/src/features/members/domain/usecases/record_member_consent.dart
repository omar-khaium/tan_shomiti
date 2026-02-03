import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/member_consent.dart';
import '../repositories/member_consents_repository.dart';

class RecordMemberConsent {
  RecordMemberConsent({
    required MemberConsentsRepository consentsRepository,
    required AppendAuditEvent appendAuditEvent,
  })  : _consentsRepository = consentsRepository,
        _appendAuditEvent = appendAuditEvent;

  final MemberConsentsRepository _consentsRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String memberId,
    required String ruleSetVersionId,
    required ConsentProofType proofType,
    required String proofReference,
  }) async {
    final now = DateTime.now();
    final consent = MemberConsent(
      shomitiId: shomitiId,
      memberId: memberId,
      ruleSetVersionId: ruleSetVersionId,
      proofType: proofType,
      proofReference: proofReference,
      signedAt: now,
    );

    await _consentsRepository.upsert(consent);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'recorded_member_consent',
        occurredAt: now,
        message: 'Recorded member sign-off for the active rules.',
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


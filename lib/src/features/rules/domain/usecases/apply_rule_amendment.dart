import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../members/domain/repositories/member_consents_repository.dart';
import '../../../members/domain/repositories/members_repository.dart';
import '../../../shomiti_setup/domain/repositories/shomiti_repository.dart';
import '../../../shomiti_setup/domain/entities/shomiti.dart';
import '../entities/rule_amendment.dart';
import '../repositories/rule_amendments_repository.dart';
import 'rule_amendment_exceptions.dart';

class ApplyRuleAmendment {
  const ApplyRuleAmendment({
    required ShomitiRepository shomitiRepository,
    required RuleAmendmentsRepository amendmentsRepository,
    required MembersRepository membersRepository,
    required MemberConsentsRepository memberConsentsRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _shomitiRepository = shomitiRepository,
       _amendmentsRepository = amendmentsRepository,
       _membersRepository = membersRepository,
       _memberConsentsRepository = memberConsentsRepository,
       _appendAuditEvent = appendAuditEvent;

  final ShomitiRepository _shomitiRepository;
  final RuleAmendmentsRepository _amendmentsRepository;
  final MembersRepository _membersRepository;
  final MemberConsentsRepository _memberConsentsRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String amendmentId,
    required DateTime now,
  }) async {
    final shomiti = await _shomitiRepository.getActive();
    if (shomiti == null) {
      throw const RuleAmendmentException('No active Shomiti found.');
    }
    if (shomiti.id != shomitiId) {
      throw const RuleAmendmentException('Invalid Shomiti context.');
    }

    final amendment = await _amendmentsRepository.getById(
      shomitiId: shomitiId,
      amendmentId: amendmentId,
    );
    if (amendment == null) {
      throw const RuleAmendmentException('Rule amendment not found.');
    }
    if (amendment.status != RuleAmendmentStatus.pendingConsent) {
      throw const RuleAmendmentException('Rule amendment is not pending.');
    }

    final note = amendment.note?.trim() ?? '';
    if (note.isEmpty) {
      throw const RuleAmendmentException('Amendment note is required.');
    }
    final sharedRef = amendment.sharedReference?.trim() ?? '';
    if (sharedRef.isEmpty) {
      throw const RuleAmendmentException(
        'Shared reference is required to apply a rule change.',
      );
    }

    final activeMembers = (await _membersRepository.listMembers(
      shomitiId: shomitiId,
    ))
        .where((m) => m.isActive)
        .toList(growable: false);

    final consents = await _memberConsentsRepository
        .watchConsents(
          shomitiId: shomitiId,
          ruleSetVersionId: amendment.proposedRuleSetVersionId,
        )
        .first;

    final consentMemberIds = {for (final c in consents) c.memberId};
    final missing = activeMembers.where((m) => !consentMemberIds.contains(m.id));
    if (missing.isNotEmpty) {
      throw const RuleAmendmentException(
        'All active members must consent before applying a rule change.',
      );
    }

    await _shomitiRepository.upsert(
      Shomiti(
        id: shomiti.id,
        name: shomiti.name,
        startDate: shomiti.startDate,
        createdAt: shomiti.createdAt,
        activeRuleSetVersionId: amendment.proposedRuleSetVersionId,
      ),
    );

    await _amendmentsRepository.upsert(
      RuleAmendment(
        id: amendment.id,
        shomitiId: amendment.shomitiId,
        baseRuleSetVersionId: amendment.baseRuleSetVersionId,
        proposedRuleSetVersionId: amendment.proposedRuleSetVersionId,
        status: RuleAmendmentStatus.applied,
        note: amendment.note,
        sharedReference: amendment.sharedReference,
        createdAt: amendment.createdAt,
        appliedAt: now,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'rule_change_applied',
        occurredAt: now,
        message: 'Rule change applied.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'amendmentId': amendment.id,
          'proposedRuleSetVersionId': amendment.proposedRuleSetVersionId,
        }),
      ),
    );
  }
}

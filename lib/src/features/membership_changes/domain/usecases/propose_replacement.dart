import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../domain/entities/membership_change_request.dart';
import '../../domain/repositories/membership_changes_repository.dart';
import 'membership_changes_exceptions.dart';

class ProposeReplacement {
  ProposeReplacement({
    required MembershipChangesRepository membershipChangesRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _membershipChangesRepository = membershipChangesRepository,
       _appendAuditEvent = appendAuditEvent;

  final MembershipChangesRepository _membershipChangesRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<MembershipChangeRequest> call({
    required String shomitiId,
    required String outgoingMemberId,
    required String replacementName,
    required String replacementPhone,
    DateTime? now,
  }) async {
    final cleanName = replacementName.trim();
    final cleanPhone = replacementPhone.trim();
    if (cleanName.isEmpty) {
      throw const MembershipChangeValidationException(
        'Replacement name is required.',
      );
    }
    if (cleanPhone.isEmpty) {
      throw const MembershipChangeValidationException(
        'Replacement phone is required.',
      );
    }

    final existing = await _membershipChangesRepository.getOpenRequestForMember(
      shomitiId: shomitiId,
      outgoingMemberId: outgoingMemberId,
    );
    if (existing == null) {
      throw const MembershipChangeNotFoundException(
        'Request exit first, then propose a replacement.',
      );
    }

    if (!existing.isOpen) {
      throw const MembershipChangeConflictException(
        'This membership change is already finalized.',
      );
    }

    final ts = now ?? DateTime.now();
    final updated = MembershipChangeRequest(
      id: existing.id,
      shomitiId: existing.shomitiId,
      outgoingMemberId: existing.outgoingMemberId,
      type: MembershipChangeType.replacement,
      requiresReplacement: existing.requiresReplacement,
      replacementCandidateName: cleanName,
      replacementCandidatePhone: cleanPhone,
      removalReasonCode: existing.removalReasonCode,
      removalReasonDetails: existing.removalReasonDetails,
      requestedAt: existing.requestedAt,
      updatedAt: ts,
      finalizedAt: existing.finalizedAt,
    );

    await _membershipChangesRepository.upsertRequest(updated);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'replacement_proposed',
        occurredAt: ts,
        message: 'Proposed replacement candidate.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': outgoingMemberId,
          'requestId': existing.id,
        }),
      ),
    );

    return updated;
  }
}

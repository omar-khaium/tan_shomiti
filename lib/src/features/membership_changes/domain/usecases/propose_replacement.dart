import 'dart:convert';
import 'dart:math';

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
       _appendAuditEvent = appendAuditEvent,
       _random = Random.secure();

  final MembershipChangesRepository _membershipChangesRepository;
  final AppendAuditEvent _appendAuditEvent;
  final Random _random;

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

    final ts = now ?? DateTime.now();
    final request = MembershipChangeRequest(
      id: existing?.id ?? _newRequestId(ts),
      shomitiId: shomitiId,
      outgoingMemberId: outgoingMemberId,
      type: MembershipChangeType.replacement,
      requiresReplacement: existing?.requiresReplacement ?? true,
      replacementCandidateName: cleanName,
      replacementCandidatePhone: cleanPhone,
      removalReasonCode: existing?.removalReasonCode,
      removalReasonDetails: existing?.removalReasonDetails,
      requestedAt: existing?.requestedAt ?? ts,
      updatedAt: ts,
      finalizedAt: existing?.finalizedAt,
    );

    await _membershipChangesRepository.upsertRequest(request);

    if (existing == null) {
      await _appendAuditEvent(
        NewAuditEvent(
          action: 'exit_requested',
          occurredAt: ts,
          message: 'Recorded exit request (via replacement proposal).',
          metadataJson: jsonEncode({
            'shomitiId': shomitiId,
            'memberId': outgoingMemberId,
            'requestId': request.id,
            'requiresReplacement': true,
          }),
        ),
      );
    }

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'replacement_proposed',
        occurredAt: ts,
        message: 'Proposed replacement candidate.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': outgoingMemberId,
          'requestId': request.id,
        }),
      ),
    );

    return request;
  }

  String _newRequestId(DateTime now) {
    final ts = now.microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36).padLeft(7, '0');
    return 'mcr_${ts}_$rand';
  }
}

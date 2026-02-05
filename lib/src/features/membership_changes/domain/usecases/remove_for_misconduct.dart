import 'dart:convert';
import 'dart:math';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../domain/entities/membership_change_request.dart';
import '../../domain/repositories/membership_changes_repository.dart';
import 'membership_changes_exceptions.dart';

class RemoveForMisconduct {
  RemoveForMisconduct({
    required MembershipChangesRepository membershipChangesRepository,
    required AppendAuditEvent appendAuditEvent,
    Random? random,
  }) : _membershipChangesRepository = membershipChangesRepository,
       _appendAuditEvent = appendAuditEvent,
       _random = random ?? Random.secure();

  final MembershipChangesRepository _membershipChangesRepository;
  final AppendAuditEvent _appendAuditEvent;
  final Random _random;

  Future<MembershipChangeRequest> call({
    required String shomitiId,
    required String memberId,
    required String reasonCode,
    String? details,
    DateTime? now,
  }) async {
    final cleanReason = reasonCode.trim();
    final cleanDetails = _cleanOptional(details);
    if (cleanReason.isEmpty) {
      throw const MembershipChangeValidationException(
        'Removal reason is required.',
      );
    }

    final existing = await _membershipChangesRepository.getOpenRequestForMember(
      shomitiId: shomitiId,
      outgoingMemberId: memberId,
    );
    if (existing != null) {
      throw const MembershipChangeConflictException(
        'There is already a pending change for this member.',
      );
    }

    final ts = now ?? DateTime.now();
    final request = MembershipChangeRequest(
      id: _newRequestId(ts),
      shomitiId: shomitiId,
      outgoingMemberId: memberId,
      type: MembershipChangeType.removal,
      requiresReplacement: false,
      replacementCandidateName: null,
      replacementCandidatePhone: null,
      removalReasonCode: cleanReason,
      removalReasonDetails: cleanDetails,
      requestedAt: ts,
      updatedAt: ts,
      finalizedAt: null,
    );

    await _membershipChangesRepository.upsertRequest(request);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'removal_proposed',
        occurredAt: ts,
        message: 'Proposed removal for misconduct.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': memberId,
          'requestId': request.id,
        }),
      ),
    );

    return request;
  }

  String? _cleanOptional(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  String _newRequestId(DateTime now) {
    final ts = now.microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36).padLeft(7, '0');
    return 'mcr_${ts}_$rand';
  }
}


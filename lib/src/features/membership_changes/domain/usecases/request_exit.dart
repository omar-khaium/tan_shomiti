import 'dart:convert';
import 'dart:math';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../domain/entities/membership_change_request.dart';
import '../../domain/repositories/membership_changes_repository.dart';
import 'membership_changes_exceptions.dart';

class RequestExit {
  RequestExit({
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
    bool requiresReplacement = true,
    DateTime? now,
  }) async {
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
      type: MembershipChangeType.exit,
      requiresReplacement: requiresReplacement,
      replacementCandidateName: null,
      replacementCandidatePhone: null,
      removalReasonCode: null,
      removalReasonDetails: null,
      requestedAt: ts,
      updatedAt: ts,
      finalizedAt: null,
    );

    await _membershipChangesRepository.upsertRequest(request);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'exit_requested',
        occurredAt: ts,
        message: 'Recorded exit request.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': memberId,
          'requestId': request.id,
          'requiresReplacement': requiresReplacement,
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


import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../members/domain/repositories/members_repository.dart';
import '../../domain/entities/membership_change_approval.dart';
import '../../domain/entities/membership_change_request.dart';
import '../../domain/repositories/membership_changes_repository.dart';
import 'membership_changes_exceptions.dart';

class ApproveMembershipChange {
  ApproveMembershipChange({
    required MembershipChangesRepository membershipChangesRepository,
    required MembersRepository membersRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _membershipChangesRepository = membershipChangesRepository,
       _membersRepository = membersRepository,
       _appendAuditEvent = appendAuditEvent;

  final MembershipChangesRepository _membershipChangesRepository;
  final MembersRepository _membersRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String requestId,
    required String outgoingMemberId,
    required String approverMemberId,
    String? note,
    DateTime? now,
  }) async {
    if (approverMemberId == outgoingMemberId) {
      throw const MembershipChangeValidationException(
        'Outgoing member cannot approve their own change.',
      );
    }

    final ts = now ?? DateTime.now();

    final approval = MembershipChangeApproval(
      shomitiId: shomitiId,
      requestId: requestId,
      approverMemberId: approverMemberId,
      approvedAt: ts,
      note: _cleanOptional(note),
    );

    await _membershipChangesRepository.upsertApproval(approval);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'membership_change_approved',
        occurredAt: ts,
        message: 'Recorded approval for membership change.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'requestId': requestId,
          'approverMemberId': approverMemberId,
        }),
      ),
    );

    await _maybeFinalize(
      shomitiId: shomitiId,
      requestId: requestId,
      outgoingMemberId: outgoingMemberId,
      now: ts,
    );
  }

  Future<void> _maybeFinalize({
    required String shomitiId,
    required String requestId,
    required String outgoingMemberId,
    required DateTime now,
  }) async {
    final request = await _membershipChangesRepository.getById(
      shomitiId: shomitiId,
      requestId: requestId,
    );
    if (request == null) {
      throw const MembershipChangeNotFoundException(
        'Membership change request not found.',
      );
    }
    if (!request.isOpen) return;

    final members = await _membersRepository.listMembers(shomitiId: shomitiId);
    final activeMemberIds = members
        .where((m) => m.isActive)
        .map((m) => m.id)
        .toList(growable: false);

    final requiredApproverIds = activeMemberIds
        .where((id) => id != outgoingMemberId)
        .toList(growable: false);

    final approvals = await _membershipChangesRepository.listApprovals(
      shomitiId: shomitiId,
      requestId: requestId,
    );
    final approvedIds = approvals.map((a) => a.approverMemberId).toSet();

    final isUnanimous =
        requiredApproverIds.isNotEmpty &&
        requiredApproverIds.every(approvedIds.contains);

    if (!isUnanimous) return;

    await _finalize(
      request: request,
      shomitiId: shomitiId,
      outgoingMemberId: outgoingMemberId,
      now: now,
    );
  }

  Future<void> _finalize({
    required MembershipChangeRequest request,
    required String shomitiId,
    required String outgoingMemberId,
    required DateTime now,
  }) async {
    if (request.type == MembershipChangeType.exit) {
      if (request.requiresReplacement) {
        throw const MembershipChangeValidationException(
          'Exit requires an approved replacement by default.',
        );
      }
    }

    if (request.type == MembershipChangeType.replacement) {
      final name = request.replacementCandidateName?.trim();
      final phone = request.replacementCandidatePhone?.trim();
      if (name == null || name.isEmpty || phone == null || phone.isEmpty) {
        throw const MembershipChangeValidationException(
          'Replacement candidate details are missing.',
        );
      }

      final member = await _membersRepository.getById(
        shomitiId: shomitiId,
        memberId: outgoingMemberId,
      );
      if (member == null) {
        throw const MembershipChangeNotFoundException('Member not found.');
      }

      await _membersRepository.upsert(
        member.copyWith(
          fullName: name,
          phone: phone,
          addressOrWorkplace: null,
          emergencyContactName: null,
          emergencyContactPhone: null,
          nidOrPassport: null,
          notes: null,
          isActive: true,
          updatedAt: now,
        ),
      );
    } else if (request.type == MembershipChangeType.removal) {
      final member = await _membersRepository.getById(
        shomitiId: shomitiId,
        memberId: outgoingMemberId,
      );
      if (member == null) {
        throw const MembershipChangeNotFoundException('Member not found.');
      }
      await _membersRepository.upsert(
        member.copyWith(isActive: false, updatedAt: now),
      );
    }

    final finalized = MembershipChangeRequest(
      id: request.id,
      shomitiId: request.shomitiId,
      outgoingMemberId: request.outgoingMemberId,
      type: request.type,
      requiresReplacement: request.requiresReplacement,
      replacementCandidateName: request.replacementCandidateName,
      replacementCandidatePhone: request.replacementCandidatePhone,
      removalReasonCode: request.removalReasonCode,
      removalReasonDetails: request.removalReasonDetails,
      requestedAt: request.requestedAt,
      updatedAt: now,
      finalizedAt: now,
    );

    await _membershipChangesRepository.upsertRequest(finalized);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'membership_change_finalized',
        occurredAt: now,
        message: 'Finalized membership change after unanimous approval.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'requestId': request.id,
          'memberId': outgoingMemberId,
          'type': request.type.name,
        }),
      ),
    );
  }

  String? _cleanOptional(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

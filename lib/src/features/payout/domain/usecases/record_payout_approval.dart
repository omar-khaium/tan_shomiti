import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../../members/domain/entities/governance_role.dart';
import '../../../members/domain/repositories/roles_repository.dart';
import '../../domain/entities/payout_approval.dart';
import '../../domain/entities/payout_approval_role.dart';
import '../repositories/payout_repository.dart';
import 'payout_exceptions.dart';

class RecordPayoutApproval {
  RecordPayoutApproval({
    required PayoutRepository payoutRepository,
    required RolesRepository rolesRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _payoutRepository = payoutRepository,
       _rolesRepository = rolesRepository,
       _appendAuditEvent = appendAuditEvent;

  final PayoutRepository _payoutRepository;
  final RolesRepository _rolesRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String ruleSetVersionId,
    required BillingMonth month,
    required PayoutApprovalRole role,
    required String approverMemberId,
    String? note,
    DateTime? now,
  }) async {
    final ts = now ?? DateTime.now();

    final verification = await _payoutRepository.getCollectionVerification(
      shomitiId: shomitiId,
      month: month,
    );
    if (verification == null) {
      throw const PayoutValidationException(
        'Collection must be verified before approvals.',
      );
    }

    final approvals = await _payoutRepository.listApprovals(
      shomitiId: shomitiId,
      month: month,
    );

    final otherRole = role == PayoutApprovalRole.treasurer
        ? PayoutApprovalRole.auditor
        : PayoutApprovalRole.treasurer;
    final otherApproverIds = approvals
        .where((a) => a.role == otherRole)
        .map((a) => a.approverMemberId)
        .toSet();

    if (otherApproverIds.contains(approverMemberId)) {
      throw const PayoutValidationException(
        'Treasurer and auditor approvals must be from distinct members.',
      );
    }

    final assignedTreasurer = await _assignedMemberId(
      shomitiId: shomitiId,
      role: GovernanceRole.treasurer,
    );
    final assignedAuditor = await _assignedMemberId(
      shomitiId: shomitiId,
      role: GovernanceRole.auditor,
    );

    if (role == PayoutApprovalRole.treasurer &&
        assignedTreasurer != null &&
        approverMemberId != assignedTreasurer) {
      throw const PayoutValidationException(
        'Only the assigned treasurer can approve as treasurer.',
      );
    }

    if (role == PayoutApprovalRole.auditor &&
        assignedAuditor != null &&
        approverMemberId != assignedAuditor) {
      throw const PayoutValidationException(
        'Only the assigned auditor can approve as auditor.',
      );
    }

    if (assignedTreasurer != null &&
        assignedAuditor != null &&
        assignedTreasurer == assignedAuditor) {
      throw const PayoutValidationException(
        'Treasurer and auditor must be different members.',
      );
    }

    final approval = PayoutApproval(
      shomitiId: shomitiId,
      month: month,
      role: role,
      approverMemberId: approverMemberId,
      ruleSetVersionId: ruleSetVersionId,
      approvedAt: ts,
      note: _cleanOptional(note),
    );

    await _payoutRepository.upsertApproval(approval);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'payout_approved',
        occurredAt: ts,
        message: 'Recorded payout approval.',
        actor: approverMemberId,
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'monthKey': month.key,
          'role': role.name,
          'approverMemberId': approverMemberId,
        }),
      ),
    );
  }

  Future<String?> _assignedMemberId({
    required String shomitiId,
    required GovernanceRole role,
  }) async {
    final assignments = await _rolesRepository
        .watchRoleAssignments(shomitiId: shomitiId)
        .first;
    for (final a in assignments) {
      if (a.role == role) return a.memberId;
    }
    return null;
  }

  String? _cleanOptional(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}


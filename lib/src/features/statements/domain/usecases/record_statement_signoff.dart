import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../../members/domain/repositories/members_repository.dart';
import '../../../members/domain/repositories/roles_repository.dart';
import '../../../members/domain/entities/governance_role.dart';
import '../../domain/entities/statement_signer_role.dart';
import '../entities/statement_signoff.dart';
import '../repositories/statement_signoffs_repository.dart';
import '../repositories/statements_repository.dart';
import 'statement_signoff_exceptions.dart';

class RecordStatementSignoff {
  const RecordStatementSignoff({
    required StatementsRepository statementsRepository,
    required StatementSignoffsRepository signoffsRepository,
    required MembersRepository membersRepository,
    required RolesRepository rolesRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _statementsRepository = statementsRepository,
       _signoffsRepository = signoffsRepository,
       _membersRepository = membersRepository,
       _rolesRepository = rolesRepository,
       _appendAuditEvent = appendAuditEvent;

  final StatementsRepository _statementsRepository;
  final StatementSignoffsRepository _signoffsRepository;
  final MembersRepository _membersRepository;
  final RolesRepository _rolesRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required BillingMonth month,
    required String signerMemberId,
    required StatementSignerRole role,
    required String proofReference,
    required String? note,
    required DateTime now,
  }) async {
    if (signerMemberId.trim().isEmpty) {
      throw const StatementSignoffException('Signer member is required.');
    }
    if (proofReference.trim().isEmpty) {
      throw const StatementSignoffException('Proof reference is required.');
    }

    final statement = await _statementsRepository.getStatement(
      shomitiId: shomitiId,
      month: month,
    );
    if (statement == null) {
      throw const StatementSignoffException(
        'Generate the statement before adding a sign-off.',
      );
    }

    final member = await _membersRepository.getById(
      shomitiId: shomitiId,
      memberId: signerMemberId,
    );
    if (member == null || !member.isActive) {
      throw const StatementSignoffException('Signer member is not active.');
    }

    if (role == StatementSignerRole.auditor) {
      final assignments =
          await _rolesRepository.watchRoleAssignments(shomitiId: shomitiId).first;
      String? assignedAuditor;
      for (final a in assignments) {
        if (a.role == GovernanceRole.auditor) {
          assignedAuditor = a.memberId;
          break;
        }
      }
      if (assignedAuditor == null || assignedAuditor != signerMemberId) {
        throw const StatementSignoffException(
          'Only the assigned auditor can sign as Auditor.',
        );
      }
    }

    final existing = await _signoffsRepository.listForMonth(
      shomitiId: shomitiId,
      month: month,
    );
    if (existing.any((s) => s.signerMemberId == signerMemberId)) {
      throw const StatementSignoffException('This member already signed off.');
    }

    await _signoffsRepository.upsert(
      StatementSignoff(
        shomitiId: shomitiId,
        month: month,
        signerMemberId: signerMemberId,
        role: role,
        proofReference: proofReference.trim(),
        note: note?.trim().isEmpty == true ? null : note?.trim(),
        signedAt: now,
        createdAt: now,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'statement_signed',
        occurredAt: now,
        message: 'Statement sign-off recorded.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'monthKey': month.key,
          'signerMemberId': signerMemberId,
          'role': role.name,
        }),
      ),
    );
  }
}

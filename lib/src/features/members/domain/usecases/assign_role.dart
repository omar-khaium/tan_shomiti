import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/governance_role.dart';
import '../repositories/roles_repository.dart';

class AssignRole {
  AssignRole({
    required RolesRepository rolesRepository,
    required AppendAuditEvent appendAuditEvent,
  })  : _rolesRepository = rolesRepository,
        _appendAuditEvent = appendAuditEvent;

  final RolesRepository _rolesRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required GovernanceRole role,
    required String? memberId,
  }) async {
    final now = DateTime.now();
    await _rolesRepository.setRoleAssignment(
      shomitiId: shomitiId,
      role: role,
      memberId: memberId,
      assignedAt: now,
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: memberId == null ? 'cleared_role' : 'assigned_role',
        occurredAt: now,
        message: memberId == null
            ? 'Cleared role assignment.'
            : 'Assigned governance role.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'role': role.name,
          'memberId': memberId,
        }),
      ),
    );
  }
}


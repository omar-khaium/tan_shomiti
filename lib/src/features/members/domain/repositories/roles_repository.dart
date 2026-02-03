import '../entities/governance_role.dart';
import '../entities/role_assignment.dart';

abstract class RolesRepository {
  Stream<List<RoleAssignment>> watchRoleAssignments({required String shomitiId});

  /// If [memberId] is null, the role is cleared.
  Future<void> setRoleAssignment({
    required String shomitiId,
    required GovernanceRole role,
    required String? memberId,
    required DateTime assignedAt,
  });
}


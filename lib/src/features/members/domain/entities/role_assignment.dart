import 'governance_role.dart';

class RoleAssignment {
  const RoleAssignment({
    required this.shomitiId,
    required this.role,
    required this.memberId,
    required this.assignedAt,
  });

  final String shomitiId;
  final GovernanceRole role;
  final String memberId;
  final DateTime assignedAt;
}


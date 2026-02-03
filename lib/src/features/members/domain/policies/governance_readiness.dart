import '../entities/governance_role.dart';

class GovernanceReadiness {
  const GovernanceReadiness({
    required this.requiredMemberCount,
    this.requiredRoles = const {
      GovernanceRole.treasurer,
      GovernanceRole.auditor,
    },
  });

  final int requiredMemberCount;
  final Set<GovernanceRole> requiredRoles;

  bool isReady({
    required Map<GovernanceRole, String?> roleAssignments,
    required Set<String> signedMemberIds,
  }) {
    for (final role in requiredRoles) {
      if (roleAssignments[role] == null) return false;
    }
    return signedMemberIds.length >= requiredMemberCount;
  }
}


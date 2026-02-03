import 'package:flutter/foundation.dart';

import '../../../domain/entities/governance_role.dart';
import '../../../domain/entities/member.dart';
import '../../../domain/entities/member_consent.dart';

@immutable
class GovernanceUiState {
  const GovernanceUiState({
    required this.shomitiId,
    required this.ruleSetVersionId,
    required this.requiredMemberCount,
    required this.members,
    required this.roleAssignments,
    required this.consentsByMemberId,
    required this.isGovernanceReady,
  });

  final String shomitiId;
  final String ruleSetVersionId;
  final int requiredMemberCount;
  final List<Member> members;
  final Map<GovernanceRole, String?> roleAssignments;
  final Map<String, MemberConsent> consentsByMemberId;
  final bool isGovernanceReady;

  bool get hasTreasurer => roleAssignments[GovernanceRole.treasurer] != null;
  bool get hasAuditor => roleAssignments[GovernanceRole.auditor] != null;

  int get signedCount => consentsByMemberId.length;
}

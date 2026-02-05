import 'package:flutter/foundation.dart';

enum MemberChangeStatus {
  active,
  exitRequested,
  replacementProposed,
  removalProposed,
  removedForMisconduct,
}

@immutable
class MemberChangeRow {
  const MemberChangeRow({
    required this.memberId,
    required this.position,
    required this.displayName,
    required this.status,
    required this.activeRequestId,
    required this.approvalsCount,
    required this.approvalsRequired,
    required this.approvedByMemberIds,
    required this.replacementCandidateName,
    required this.replacementCandidatePhone,
  });

  final String memberId;
  final int position;
  final String displayName;
  final MemberChangeStatus status;
  final String? activeRequestId;
  final int approvalsCount;
  final int approvalsRequired;
  final List<String> approvedByMemberIds;
  final String? replacementCandidateName;
  final String? replacementCandidatePhone;
}

@immutable
class ApproverOption {
  const ApproverOption({
    required this.memberId,
    required this.position,
    required this.displayName,
    required this.isActive,
  });

  final String memberId;
  final int position;
  final String displayName;
  final bool isActive;
}

@immutable
class MembershipChangesUiState {
  const MembershipChangesUiState({required this.rows, required this.members});

  final List<MemberChangeRow> rows;
  final List<ApproverOption> members;
}

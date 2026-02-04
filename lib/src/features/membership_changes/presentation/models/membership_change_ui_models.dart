import 'package:flutter/foundation.dart';

enum MemberChangeStatus {
  active,
  exitRequested,
  replacementProposed,
  removedForMisconduct,
}

@immutable
class MemberChangeRow {
  const MemberChangeRow({
    required this.memberId,
    required this.position,
    required this.displayName,
    required this.status,
  });

  final String memberId;
  final int position;
  final String displayName;
  final MemberChangeStatus status;
}

@immutable
class MembershipChangesUiState {
  const MembershipChangesUiState({required this.rows});

  final List<MemberChangeRow> rows;
}

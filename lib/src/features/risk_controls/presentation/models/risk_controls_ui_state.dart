import 'package:flutter/foundation.dart';

enum RiskControlStatus {
  missing,
  guarantorRecorded,
  depositRecorded,
  depositReturned,
}

@immutable
class RiskControlRow {
  const RiskControlRow({
    required this.memberId,
    required this.position,
    required this.displayName,
    required this.status,
  });

  final String memberId;
  final int position;
  final String displayName;
  final RiskControlStatus status;
}

@immutable
class RiskControlsUiState {
  const RiskControlsUiState({required this.rows});

  final List<RiskControlRow> rows;

  int get missingCount =>
      rows.where((r) => r.status == RiskControlStatus.missing).length;
}

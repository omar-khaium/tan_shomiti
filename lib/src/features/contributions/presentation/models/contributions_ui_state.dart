import 'package:flutter/foundation.dart';

@immutable
class MonthlyDueRow {
  const MonthlyDueRow({
    required this.memberId,
    required this.position,
    required this.displayName,
    required this.shares,
    required this.dueAmountBdt,
  });

  final String memberId;
  final int position;
  final String displayName;
  final int shares;
  final int dueAmountBdt;
}

@immutable
class ContributionsUiState {
  const ContributionsUiState({
    required this.month,
    required this.totalDueBdt,
    required this.rows,
  });

  /// Month anchor (first day of the month, local time).
  final DateTime month;
  final int totalDueBdt;
  final List<MonthlyDueRow> rows;
}


import 'package:flutter/foundation.dart';

import '../../domain/value_objects/billing_month.dart';

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
    required this.shomitiId,
    required this.month,
    required this.totalDueBdt,
    required this.rows,
  });

  final String shomitiId;
  final BillingMonth month;
  final int totalDueBdt;
  final List<MonthlyDueRow> rows;
}

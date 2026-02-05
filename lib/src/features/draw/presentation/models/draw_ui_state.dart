import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';

@immutable
class DrawEligibilityRowUiModel {
  const DrawEligibilityRowUiModel({
    required this.position,
    required this.memberId,
    required this.memberName,
    required this.shares,
    required this.isEligible,
    required this.reason,
  });

  final int position;
  final String memberId;
  final String memberName;
  final int shares;
  final bool isEligible;
  final String? reason;
}

@immutable
class DrawEligibleShareUiModel {
  const DrawEligibleShareUiModel({
    required this.memberId,
    required this.memberName,
    required this.shareIndex,
  });

  final String memberId;
  final String memberName;
  final int shareIndex;

  String get shareKey => '$memberId#$shareIndex';

  String get label => '$memberName (share $shareIndex)';
}

@immutable
class DrawEligibilitySummary {
  const DrawEligibilitySummary({
    required this.eligibleEntries,
    required this.ineligibleEntries,
    required this.ineligibleReasons,
  });

  final int eligibleEntries;
  final int ineligibleEntries;
  final Map<String, int> ineligibleReasons;
}

@immutable
class DrawUiState {
  const DrawUiState({
    required this.shomitiId,
    required this.ruleSetVersionId,
    required this.month,
    required this.summary,
    required this.rows,
    required this.eligibleShares,
    required this.hasDuesForMonth,
  });

  final String shomitiId;
  final String ruleSetVersionId;
  final BillingMonth month;
  final DrawEligibilitySummary summary;
  final List<DrawEligibilityRowUiModel> rows;
  final List<DrawEligibleShareUiModel> eligibleShares;
  final bool hasDuesForMonth;

  bool get canRunDraw => summary.eligibleEntries > 0;
}

import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';

@immutable
class PayoutCollectionTotalsUiState {
  const PayoutCollectionTotalsUiState({
    required this.dueTotalBdt,
    required this.paidTotalBdt,
    required this.coveredTotalBdt,
    required this.shortfallBdt,
  });

  final int dueTotalBdt;
  final int paidTotalBdt;
  final int coveredTotalBdt;
  final int shortfallBdt;

  bool get isComplete => shortfallBdt == 0;
}

@immutable
class PayoutVerificationUiState {
  const PayoutVerificationUiState({
    required this.isVerified,
    required this.verifiedByMemberId,
    required this.verifiedByName,
    required this.verifiedAt,
  });

  final bool isVerified;
  final String? verifiedByMemberId;
  final String? verifiedByName;
  final DateTime? verifiedAt;
}

@immutable
class PayoutRoleApprovalUiState {
  const PayoutRoleApprovalUiState({
    required this.hasApproval,
    required this.approverMemberId,
    required this.approverName,
    required this.approvedAt,
    required this.note,
  });

  final bool hasApproval;
  final String? approverMemberId;
  final String? approverName;
  final DateTime? approvedAt;
  final String? note;
}

@immutable
class PayoutPaidUiState {
  const PayoutPaidUiState({
    required this.isPaid,
    required this.proofReference,
    required this.paidAt,
  });

  final bool isPaid;
  final String? proofReference;
  final DateTime? paidAt;
}

@immutable
class PayoutPrerequisitesUiState {
  const PayoutPrerequisitesUiState({
    required this.hasRecordedDraw,
    required this.isDrawFinalized,
    required this.isCollectionComplete,
    required this.isCollectionVerified,
    required this.hasTreasurerApproval,
    required this.hasAuditorApproval,
  });

  final bool hasRecordedDraw;
  final bool isDrawFinalized;
  final bool isCollectionComplete;
  final bool isCollectionVerified;
  final bool hasTreasurerApproval;
  final bool hasAuditorApproval;

  bool get canProceed =>
      hasRecordedDraw &&
      isDrawFinalized &&
      isCollectionComplete &&
      isCollectionVerified &&
      hasTreasurerApproval &&
      hasAuditorApproval;
}

@immutable
class PayoutUiState {
  const PayoutUiState({
    required this.shomitiId,
    required this.ruleSetVersionId,
    required this.month,
    required this.drawId,
    required this.winnerLabel,
    required this.amountBdt,
    required this.totals,
    required this.verification,
    required this.treasurerApproval,
    required this.auditorApproval,
    required this.paid,
    required this.allowShortfallCoverage,
    required this.prerequisites,
  });

  final String shomitiId;
  final String ruleSetVersionId;
  final BillingMonth month;
  final String? drawId;
  final String winnerLabel;
  final int amountBdt;
  final PayoutCollectionTotalsUiState totals;
  final PayoutVerificationUiState verification;
  final PayoutRoleApprovalUiState treasurerApproval;
  final PayoutRoleApprovalUiState auditorApproval;
  final PayoutPaidUiState paid;
  final bool allowShortfallCoverage;
  final PayoutPrerequisitesUiState prerequisites;
}

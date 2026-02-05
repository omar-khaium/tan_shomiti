import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';

@immutable
class PayoutPrerequisitesUiState {
  const PayoutPrerequisitesUiState({
    required this.hasRecordedDraw,
    required this.isCollectionVerified,
    required this.hasTreasurerApproval,
    required this.hasAuditorApproval,
  });

  final bool hasRecordedDraw;
  final bool isCollectionVerified;
  final bool hasTreasurerApproval;
  final bool hasAuditorApproval;

  bool get canProceed =>
      hasRecordedDraw &&
      isCollectionVerified &&
      hasTreasurerApproval &&
      hasAuditorApproval;
}

@immutable
class PayoutUiState {
  const PayoutUiState({
    required this.month,
    required this.prerequisites,
  });

  final BillingMonth month;
  final PayoutPrerequisitesUiState prerequisites;
}


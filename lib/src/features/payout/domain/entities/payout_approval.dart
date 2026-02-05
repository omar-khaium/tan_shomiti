import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';
import 'payout_approval_role.dart';

@immutable
class PayoutApproval {
  const PayoutApproval({
    required this.shomitiId,
    required this.month,
    required this.role,
    required this.approverMemberId,
    required this.ruleSetVersionId,
    required this.approvedAt,
    this.note,
  });

  final String shomitiId;
  final BillingMonth month;
  final PayoutApprovalRole role;
  final String approverMemberId;
  final String ruleSetVersionId;
  final DateTime approvedAt;
  final String? note;
}


import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';

@immutable
class PayoutRecord {
  const PayoutRecord({
    required this.shomitiId,
    required this.month,
    required this.drawId,
    required this.ruleSetVersionId,
    required this.winnerMemberId,
    required this.winnerShareIndex,
    required this.amountBdt,
    required this.recordedAt,
    this.proofReference,
    this.markedPaidByMemberId,
    this.paidAt,
  });

  final String shomitiId;
  final BillingMonth month;
  final String drawId;
  final String ruleSetVersionId;
  final String winnerMemberId;
  final int winnerShareIndex;
  final int amountBdt;
  final String? proofReference;
  final String? markedPaidByMemberId;
  final DateTime? paidAt;
  final DateTime recordedAt;

  bool get isPaid => paidAt != null;
}


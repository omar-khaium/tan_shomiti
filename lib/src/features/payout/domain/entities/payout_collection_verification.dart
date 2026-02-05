import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';

@immutable
class PayoutCollectionVerification {
  const PayoutCollectionVerification({
    required this.shomitiId,
    required this.month,
    required this.ruleSetVersionId,
    required this.verifiedByMemberId,
    required this.verifiedAt,
    this.note,
  });

  final String shomitiId;
  final BillingMonth month;
  final String ruleSetVersionId;
  final String verifiedByMemberId;
  final DateTime verifiedAt;
  final String? note;
}


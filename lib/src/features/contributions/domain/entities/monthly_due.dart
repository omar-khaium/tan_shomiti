import 'package:flutter/foundation.dart';

import '../value_objects/billing_month.dart';

@immutable
class MonthlyDue {
  const MonthlyDue({
    required this.shomitiId,
    required this.month,
    required this.memberId,
    required this.shares,
    required this.shareValueBdt,
    required this.dueAmountBdt,
    required this.createdAt,
  });

  final String shomitiId;
  final BillingMonth month;
  final String memberId;
  final int shares;
  final int shareValueBdt;
  final int dueAmountBdt;
  final DateTime createdAt;
}


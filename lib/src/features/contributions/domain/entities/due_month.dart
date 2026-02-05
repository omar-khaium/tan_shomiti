import 'package:flutter/foundation.dart';

import '../value_objects/billing_month.dart';

@immutable
class DueMonth {
  const DueMonth({
    required this.shomitiId,
    required this.month,
    required this.ruleSetVersionId,
    required this.generatedAt,
  });

  final String shomitiId;
  final BillingMonth month;
  final String ruleSetVersionId;
  final DateTime generatedAt;
}


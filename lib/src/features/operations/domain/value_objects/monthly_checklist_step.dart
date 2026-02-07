import 'package:flutter/foundation.dart';

@immutable
class MonthlyChecklistStep {
  const MonthlyChecklistStep._(this.key);

  final String key;

  static const attendance = MonthlyChecklistStep._('attendance');
  static const payments = MonthlyChecklistStep._('payments');
  static const draw = MonthlyChecklistStep._('draw');
  static const payoutAmount = MonthlyChecklistStep._('payout_amount');
  static const payoutProof = MonthlyChecklistStep._('payout_proof');
  static const publishStatement = MonthlyChecklistStep._('publish_statement');

  static const values = <MonthlyChecklistStep>[
    attendance,
    payments,
    draw,
    payoutAmount,
    payoutProof,
    publishStatement,
  ];

  static MonthlyChecklistStep fromKey(String key) {
    for (final item in values) {
      if (item.key == key) return item;
    }
    throw FormatException('Unknown MonthlyChecklistStep key: $key');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyChecklistStep && other.key == key;

  @override
  int get hashCode => key.hashCode;
}

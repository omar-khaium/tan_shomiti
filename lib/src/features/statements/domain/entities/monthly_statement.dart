import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';

@immutable
class MonthlyStatement {
  const MonthlyStatement({
    required this.shomitiId,
    required this.month,
    required this.ruleSetVersionId,
    required this.generatedAt,
    required this.totalDueBdt,
    required this.totalCollectedBdt,
    required this.coveredBdt,
    required this.shortfallBdt,
    required this.winnerLabel,
    required this.drawProofReference,
    required this.payoutProofReference,
  });

  final String shomitiId;
  final BillingMonth month;
  final String ruleSetVersionId;
  final DateTime generatedAt;

  final int totalDueBdt;
  final int totalCollectedBdt;
  final int coveredBdt;
  final int shortfallBdt;

  final String winnerLabel;
  final String drawProofReference;
  final String payoutProofReference;

  Map<String, Object?> toJson() {
    return {
      'shomitiId': shomitiId,
      'monthKey': month.key,
      'ruleSetVersionId': ruleSetVersionId,
      'generatedAt': generatedAt.toIso8601String(),
      'totalDueBdt': totalDueBdt,
      'totalCollectedBdt': totalCollectedBdt,
      'coveredBdt': coveredBdt,
      'shortfallBdt': shortfallBdt,
      'winnerLabel': winnerLabel,
      'drawProofReference': drawProofReference,
      'payoutProofReference': payoutProofReference,
    };
  }

  factory MonthlyStatement.fromJson(Map<String, Object?> json) {
    return MonthlyStatement(
      shomitiId: json['shomitiId'] as String,
      month: BillingMonth.fromKey(json['monthKey'] as String),
      ruleSetVersionId: json['ruleSetVersionId'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      totalDueBdt: json['totalDueBdt'] as int,
      totalCollectedBdt: json['totalCollectedBdt'] as int,
      coveredBdt: json['coveredBdt'] as int,
      shortfallBdt: json['shortfallBdt'] as int,
      winnerLabel: json['winnerLabel'] as String,
      drawProofReference: json['drawProofReference'] as String,
      payoutProofReference: json['payoutProofReference'] as String,
    );
  }
}


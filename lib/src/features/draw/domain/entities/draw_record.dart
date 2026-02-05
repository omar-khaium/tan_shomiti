import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';
import '../value_objects/draw_method.dart';

@immutable
class DrawRecord {
  const DrawRecord({
    required this.id,
    required this.shomitiId,
    required this.month,
    required this.ruleSetVersionId,
    required this.method,
    required this.proofReference,
    required this.notes,
    required this.winnerMemberId,
    required this.winnerShareIndex,
    required this.eligibleShareKeys,
    required this.recordedAt,
  });

  final String id;
  final String shomitiId;
  final BillingMonth month;
  final String ruleSetVersionId;
  final DrawMethod method;
  final String proofReference;
  final String? notes;
  final String winnerMemberId;
  final int winnerShareIndex;
  final List<String> eligibleShareKeys;
  final DateTime recordedAt;

  String get winnerShareKey => '$winnerMemberId#$winnerShareIndex';
}

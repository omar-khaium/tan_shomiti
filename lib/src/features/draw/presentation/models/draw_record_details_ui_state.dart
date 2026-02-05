import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';

@immutable
class DrawRecordDetailsUiState {
  const DrawRecordDetailsUiState({
    required this.month,
    required this.hasRecord,
    required this.methodLabel,
    required this.proofReference,
    required this.winnerLabel,
    required this.statusLabel,
    required this.witnessCount,
    required this.drawId,
  });

  final BillingMonth month;
  final bool hasRecord;
  final String? drawId;
  final String? methodLabel;
  final String? proofReference;
  final String? winnerLabel;
  final String? statusLabel;
  final int witnessCount;
}


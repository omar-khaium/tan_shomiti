import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';

@immutable
class StatementsUiState {
  const StatementsUiState({
    required this.month,
    required this.isReadyToGenerate,
    required this.hasGeneratedStatement,
  });

  final BillingMonth month;
  final bool isReadyToGenerate;
  final bool hasGeneratedStatement;
}

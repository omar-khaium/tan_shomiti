import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';

@immutable
class StatementsUiState {
  const StatementsUiState({
    required this.month,
    required this.isReadyToGenerate,
  });

  final BillingMonth month;
  final bool isReadyToGenerate;
}


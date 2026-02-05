import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';
import '../models/statements_ui_state.dart';

class StatementsController extends AutoDisposeAsyncNotifier<StatementsUiState> {
  BillingMonth? _month;

  @override
  Future<StatementsUiState> build() async {
    _month ??= BillingMonth.fromDate(DateTime.now());

    // Stage 2: UI-only placeholder. Real readiness + generation comes in
    // TS-501 stage3.
    return StatementsUiState(
      month: _month!,
      isReadyToGenerate: false,
    );
  }

  Future<void> previousMonth() async {
    _month = (_month ?? BillingMonth.fromDate(DateTime.now())).previous();
    state = const AsyncValue.loading();
    state = AsyncValue.data(await build());
  }

  Future<void> nextMonth() async {
    _month = (_month ?? BillingMonth.fromDate(DateTime.now())).next();
    state = const AsyncValue.loading();
    state = AsyncValue.data(await build());
  }
}


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';
import '../models/payout_ui_state.dart';

class PayoutController extends AutoDisposeAsyncNotifier<PayoutUiState> {
  BillingMonth? _month;

  @override
  Future<PayoutUiState> build() async {
    _month ??= BillingMonth.fromDate(DateTime.now());

    // Stage 2: UI-only placeholder. Real gating and persistence happen in
    // TS-403 stage3.
    return PayoutUiState(
      month: _month!,
      prerequisites: const PayoutPrerequisitesUiState(
        hasRecordedDraw: false,
        isCollectionVerified: false,
        hasTreasurerApproval: false,
        hasAuditorApproval: false,
      ),
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


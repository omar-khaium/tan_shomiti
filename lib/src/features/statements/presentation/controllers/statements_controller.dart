import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import '../models/statements_ui_state.dart';
import '../providers/statements_domain_providers.dart';
import '../../../payout/presentation/providers/payout_domain_providers.dart';

class StatementsController extends AutoDisposeAsyncNotifier<StatementsUiState> {
  BillingMonth? _month;

  @override
  Future<StatementsUiState> build() async {
    _month ??= BillingMonth.fromDate(DateTime.now());

    final month = _month!;
    final shomiti = await ref.watch(activeShomitiProvider.future);
    if (shomiti == null) {
      return StatementsUiState(
        month: month,
        isReadyToGenerate: false,
        hasGeneratedStatement: false,
      );
    }

    final statement = await ref
        .watch(statementsRepositoryProvider)
        .getStatement(shomitiId: shomiti.id, month: month);
    final payout = await ref
        .watch(payoutRepositoryProvider)
        .getPayoutRecord(shomitiId: shomiti.id, month: month);

    final ready = payout != null && payout.isPaid && payout.proofReference != null;

    return StatementsUiState(
      month: month,
      isReadyToGenerate: ready,
      hasGeneratedStatement: statement != null,
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

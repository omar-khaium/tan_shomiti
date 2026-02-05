import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/payout_controller.dart';
import '../models/payout_ui_state.dart';

final payoutControllerProvider =
    AsyncNotifierProvider.autoDispose<PayoutController, PayoutUiState>(
      PayoutController.new,
    );

final payoutUiStateProvider = Provider.autoDispose<AsyncValue<PayoutUiState>>(
  (ref) => ref.watch(payoutControllerProvider),
);


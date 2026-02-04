import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/risk_controls_controller.dart';
import '../models/risk_controls_ui_state.dart';

final riskControlsControllerProvider =
    AsyncNotifierProvider.autoDispose<
      RiskControlsController,
      RiskControlsUiState?
    >(RiskControlsController.new);

final riskControlsUiStateProvider =
    Provider.autoDispose<AsyncValue<RiskControlsUiState?>>(
      (ref) => ref.watch(riskControlsControllerProvider),
    );

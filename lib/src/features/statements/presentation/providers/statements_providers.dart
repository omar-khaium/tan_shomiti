import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/statements_controller.dart';
import '../models/statements_ui_state.dart';

final statementsControllerProvider =
    AsyncNotifierProvider.autoDispose<StatementsController, StatementsUiState>(
      StatementsController.new,
    );

final statementsUiStateProvider =
    Provider.autoDispose<AsyncValue<StatementsUiState>>(
      (ref) => ref.watch(statementsControllerProvider),
    );


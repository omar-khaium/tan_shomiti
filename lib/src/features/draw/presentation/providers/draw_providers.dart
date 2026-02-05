import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/draw_controller.dart';
import '../models/draw_ui_state.dart';

final drawControllerProvider =
    AsyncNotifierProvider.autoDispose<DrawController, DrawUiState>(
      DrawController.new,
    );

final drawUiStateProvider = Provider.autoDispose<AsyncValue<DrawUiState>>(
  (ref) => ref.watch(drawControllerProvider),
);

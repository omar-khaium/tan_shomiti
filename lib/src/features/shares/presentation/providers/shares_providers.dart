import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/shares_controller.dart';
import '../models/shares_ui_state.dart';

final sharesControllerProvider =
    AsyncNotifierProvider.autoDispose<SharesController, SharesUiState?>(
      SharesController.new,
    );

final sharesUiStateProvider = Provider.autoDispose<AsyncValue<SharesUiState?>>(
  (ref) => ref.watch(sharesControllerProvider),
);

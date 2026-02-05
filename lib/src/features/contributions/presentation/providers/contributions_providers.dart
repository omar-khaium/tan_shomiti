import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/contributions_controller.dart';
import '../models/contributions_ui_state.dart';

final contributionsControllerProvider =
    AsyncNotifierProvider.autoDispose<ContributionsController, ContributionsUiState?>(
      ContributionsController.new,
    );

final contributionsUiStateProvider =
    Provider.autoDispose<AsyncValue<ContributionsUiState?>>(
      (ref) => ref.watch(contributionsControllerProvider),
    );


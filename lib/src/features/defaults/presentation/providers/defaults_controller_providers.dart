import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/defaults_controller.dart';
import '../models/defaults_row_ui_model.dart';

final defaultsControllerProvider =
    AutoDisposeAsyncNotifierProvider<DefaultsController, List<DefaultsRowUiModel>>(
  DefaultsController.new,
);


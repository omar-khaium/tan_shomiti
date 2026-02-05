import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/defaults_row_ui_model.dart';

final defaultsDashboardRowsProvider =
    FutureProvider<List<DefaultsRowUiModel>>((ref) async {
  // Stage 2 uses demo data only. Stage 3 replaces this with persisted
  // computation from monthly dues + payments and enforcement logs.
  return const [
    DefaultsRowUiModel(
      memberId: 'm1',
      memberName: 'Member 1',
      status: DefaultsStatusUi.clear,
      missedCount: 0,
      nextStep: DefaultsNextStepUi.none,
    ),
    DefaultsRowUiModel(
      memberId: 'm2',
      memberName: 'Member 2',
      status: DefaultsStatusUi.atRisk,
      missedCount: 1,
      nextStep: DefaultsNextStepUi.reminder,
    ),
    DefaultsRowUiModel(
      memberId: 'm3',
      memberName: 'Member 3',
      status: DefaultsStatusUi.inDefault,
      missedCount: 2,
      nextStep: DefaultsNextStepUi.notice,
    ),
  ];
});


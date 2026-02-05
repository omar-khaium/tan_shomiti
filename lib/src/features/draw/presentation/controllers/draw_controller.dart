import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';
import '../models/draw_ui_state.dart';

class DrawController extends AutoDisposeAsyncNotifier<DrawUiState> {
  @override
  Future<DrawUiState> build() async {
    // Stage 2: UI-only. Domain/data integration is added in Stage 3.
    final month = BillingMonth.fromDate(DateTime.now());

    return DrawUiState(
      shomitiId: 'active',
      month: month,
      hasDuesForMonth: false,
      summary: const DrawEligibilitySummary(
        eligibleEntries: 0,
        ineligibleEntries: 0,
        ineligibleReasons: {},
      ),
      rows: const [],
    );
  }

  void setMonth(BillingMonth month) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(
      DrawUiState(
        shomitiId: current.shomitiId,
        month: month,
        hasDuesForMonth: current.hasDuesForMonth,
        summary: current.summary,
        rows: current.rows,
      ),
    );
  }
}


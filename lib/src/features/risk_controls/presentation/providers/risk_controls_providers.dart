import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../members/presentation/providers/members_providers.dart';
import '../models/risk_controls_ui_state.dart';
import 'risk_controls_demo_store.dart';

final riskControlsUiStateProvider = Provider<AsyncValue<RiskControlsUiState?>>((
  ref,
) {
  final membersAsync = ref.watch(membersUiStateProvider);

  return membersAsync.when(
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    data: (members) {
      if (members == null) return const AsyncValue.data(null);

      final controls = ref.watch(demoRiskControlsStoreProvider);

      final rows = [
        for (final m in members.members)
          RiskControlRow(
            memberId: m.id,
            position: m.position,
            displayName: m.fullName,
            status: _statusFor(
              memberId: m.id,
              position: m.position,
              controls: controls,
            ),
          ),
      ];

      return AsyncValue.data(
        RiskControlsUiState(rows: List.unmodifiable(rows)),
      );
    },
  );
});

RiskControlStatus _statusFor({
  required String memberId,
  required int position,
  required Map<String, DemoRiskControl> controls,
}) {
  final existing = controls[memberId];
  if (existing != null) {
    if (existing.hasGuarantor) return RiskControlStatus.guarantorRecorded;
    if (existing.hasDepositHeld) return RiskControlStatus.depositRecorded;
    if (existing.hasDepositReturned) return RiskControlStatus.depositReturned;
  }

  // Demo-only: prefill a couple of statuses so UI isn't empty.
  if (position == 1) return RiskControlStatus.guarantorRecorded;
  if (position == 2) return RiskControlStatus.depositRecorded;
  return RiskControlStatus.missing;
}

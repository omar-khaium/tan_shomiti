import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../rules/presentation/providers/rules_viewer_providers.dart';
import '../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import '../../domain/entities/default_enforcement_step.dart';
import '../../domain/entities/member_default_summary.dart';
import '../../domain/usecases/defaults_exceptions.dart';
import '../models/defaults_row_ui_model.dart';
import '../providers/defaults_domain_providers.dart';

class DefaultsController extends AutoDisposeAsyncNotifier<List<DefaultsRowUiModel>> {
  @override
  Future<List<DefaultsRowUiModel>> build() async {
    final shomiti = await ref.watch(activeShomitiProvider.future);
    if (shomiti == null) return const [];

    final rulesVersion = await ref.watch(rulesViewerProvider.future);
    if (rulesVersion == null) return const [];

    final summaries = await ref.read(computeDefaultsDashboardProvider)(
      shomitiId: shomiti.id,
      ruleSet: rulesVersion.snapshot,
    );

    return summaries
        .map((s) => DefaultsRowUiModel(
              memberId: s.memberId,
              memberName: s.memberName,
              status: _mapStatus(s.status),
              missedCount: s.totalMissedPayments,
              episodeKey: s.episodeKey,
              nextStep: _mapNextStep(s.nextStep),
            ))
        .toList(growable: false);
  }

  Future<void> recordReminder({
    required String memberId,
    required String episodeKey,
  }) =>
      _recordStep(
        memberId: memberId,
        episodeKey: episodeKey,
        stepType: DefaultEnforcementStepType.reminder,
      );

  Future<void> recordNotice({
    required String memberId,
    required String episodeKey,
  }) =>
      _recordStep(
        memberId: memberId,
        episodeKey: episodeKey,
        stepType: DefaultEnforcementStepType.notice,
      );

  Future<void> applyGuarantorOrDeposit({
    required String memberId,
    required String episodeKey,
  }) =>
      _recordStep(
        memberId: memberId,
        episodeKey: episodeKey,
        stepType: DefaultEnforcementStepType.guarantorOrDeposit,
      );

  Future<void> _recordStep({
    required String memberId,
    required String episodeKey,
    required DefaultEnforcementStepType stepType,
  }) async {
    final shomiti = await ref.read(activeShomitiProvider.future);
    if (shomiti == null) {
      throw const DefaultsValidationException('Shomiti is not configured.');
    }
    final rulesVersion = await ref.read(rulesViewerProvider.future);
    if (rulesVersion == null) {
      throw const DefaultsValidationException('Rules are not available.');
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(recordDefaultEnforcementStepProvider)(
        shomitiId: shomiti.id,
        ruleSetVersionId: shomiti.activeRuleSetVersionId,
        ruleSet: rulesVersion.snapshot,
        memberId: memberId,
        episodeKey: episodeKey,
        stepType: stepType,
      );

      return await build();
    });
  }

  static DefaultsStatusUi _mapStatus(DefaultStatus status) => switch (status) {
        DefaultStatus.clear => DefaultsStatusUi.clear,
        DefaultStatus.atRisk => DefaultsStatusUi.atRisk,
        DefaultStatus.inDefault => DefaultsStatusUi.inDefault,
      };

  static DefaultsNextStepUi _mapNextStep(DefaultEnforcementStepType? step) =>
      switch (step) {
        null => DefaultsNextStepUi.none,
        DefaultEnforcementStepType.reminder => DefaultsNextStepUi.reminder,
        DefaultEnforcementStepType.notice => DefaultsNextStepUi.notice,
        DefaultEnforcementStepType.guarantorOrDeposit =>
          DefaultsNextStepUi.guarantorOrDeposit,
        DefaultEnforcementStepType.dispute => DefaultsNextStepUi.dispute,
      };
}


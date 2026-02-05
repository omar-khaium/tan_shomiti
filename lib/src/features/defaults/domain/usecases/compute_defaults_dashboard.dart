import '../../../rules/domain/entities/rule_set_snapshot.dart';
import '../entities/default_enforcement_step.dart';
import '../entities/member_default_summary.dart';
import '../repositories/defaults_repository.dart';

class ComputeDefaultsDashboard {
  const ComputeDefaultsDashboard(this._repository);

  final DefaultsRepository _repository;

  Future<List<MemberDefaultSummary>> call({
    required String shomitiId,
    required RuleSetSnapshot ruleSet,
  }) async {
    final dues = await _repository.listMemberDuePayments(shomitiId: shomitiId);
    final enforcementSteps =
        await _repository.listEnforcementSteps(shomitiId: shomitiId);

    final stepsByMemberAndEpisode =
        <String, List<DefaultEnforcementStep>>{};
    for (final step in enforcementSteps) {
      final key = '${step.memberId}::${step.episodeKey}';
      (stepsByMemberAndEpisode[key] ??= []).add(step);
    }
    for (final entry in stepsByMemberAndEpisode.entries) {
      entry.value.sort((a, b) {
        final byTime = a.recordedAt.compareTo(b.recordedAt);
        if (byTime != 0) return byTime;
        return a.id.compareTo(b.id);
      });
    }

    final byMember = <String, List<MemberDuePaymentRow>>{};
    final memberNames = <String, String>{};
    for (final row in dues) {
      (byMember[row.memberId] ??= []).add(row);
      memberNames[row.memberId] = row.memberName;
    }

    final thresholdConsecutive = ruleSet.defaultConsecutiveMissedThreshold;
    final thresholdTotal = ruleSet.defaultTotalMissedThreshold;

    final results = <MemberDefaultSummary>[];
    for (final entry in byMember.entries) {
      final memberId = entry.key;
      final rows = entry.value..sort((a, b) => a.monthKey.compareTo(b.monthKey));

      final missed = rows.where((r) => !r.hasPayment).toList(growable: false);
      final totalMissed = missed.length;

      int consecutiveMissed = 0;
      for (final row in rows.reversed) {
        if (row.hasPayment) break;
        consecutiveMissed += 1;
      }

      String? episodeKey;
      if (consecutiveMissed > 0) {
        final startIndex = rows.length - consecutiveMissed;
        episodeKey = rows[startIndex].monthKey;
      }

      final status = switch (totalMissed) {
        0 => DefaultStatus.clear,
        _ when consecutiveMissed >= thresholdConsecutive ||
                totalMissed >= thresholdTotal =>
          DefaultStatus.inDefault,
        _ => DefaultStatus.atRisk,
      };

      DefaultEnforcementStepType? nextStep;
      if (status != DefaultStatus.clear && episodeKey != null) {
        final stepKey = '$memberId::$episodeKey';
        final steps = stepsByMemberAndEpisode[stepKey] ?? const [];
        final last = steps.isEmpty ? null : steps.last.type;
        nextStep = _nextStep(last);
      }

      results.add(
        MemberDefaultSummary(
          memberId: memberId,
          memberName: memberNames[memberId] ?? memberId,
          totalMissedPayments: totalMissed,
          consecutiveMissedPayments: consecutiveMissed,
          status: status,
          episodeKey: episodeKey,
          nextStep: nextStep,
        ),
      );
    }

    results.sort((a, b) {
      final statusOrder = _statusRank(a.status).compareTo(_statusRank(b.status));
      if (statusOrder != 0) return statusOrder;
      return a.memberName.compareTo(b.memberName);
    });

    return results;
  }

  static int _statusRank(DefaultStatus status) => switch (status) {
        DefaultStatus.inDefault => 0,
        DefaultStatus.atRisk => 1,
        DefaultStatus.clear => 2,
      };

  static DefaultEnforcementStepType? _nextStep(DefaultEnforcementStepType? last) {
    return switch (last) {
      null => DefaultEnforcementStepType.reminder,
      DefaultEnforcementStepType.reminder => DefaultEnforcementStepType.notice,
      DefaultEnforcementStepType.notice =>
        DefaultEnforcementStepType.guarantorOrDeposit,
      DefaultEnforcementStepType.guarantorOrDeposit =>
        DefaultEnforcementStepType.dispute,
      DefaultEnforcementStepType.dispute => null,
    };
  }
}

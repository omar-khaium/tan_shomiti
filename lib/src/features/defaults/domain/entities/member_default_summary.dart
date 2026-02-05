import 'package:flutter/foundation.dart';

import 'default_enforcement_step.dart';

@immutable
class MemberDefaultSummary {
  const MemberDefaultSummary({
    required this.memberId,
    required this.memberName,
    required this.totalMissedPayments,
    required this.consecutiveMissedPayments,
    required this.status,
    required this.episodeKey,
    required this.nextStep,
  });

  final String memberId;
  final String memberName;
  final int totalMissedPayments;
  final int consecutiveMissedPayments;
  final DefaultStatus status;

  /// `null` when there is no missed payment streak.
  final String? episodeKey;

  final DefaultEnforcementStepType? nextStep;
}

enum DefaultStatus {
  clear,
  atRisk,
  inDefault,
}


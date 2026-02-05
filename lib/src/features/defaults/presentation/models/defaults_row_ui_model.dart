import 'package:flutter/foundation.dart';

@immutable
class DefaultsRowUiModel {
  const DefaultsRowUiModel({
    required this.memberId,
    required this.memberName,
    required this.status,
    required this.missedCount,
    required this.episodeKey,
    required this.nextStep,
  });

  final String memberId;
  final String memberName;
  final DefaultsStatusUi status;
  final int missedCount;
  final String? episodeKey;
  final DefaultsNextStepUi nextStep;
}

enum DefaultsStatusUi {
  clear,
  atRisk,
  inDefault,
}

enum DefaultsNextStepUi {
  none,
  reminder,
  notice,
  guarantorOrDeposit,
  dispute,
}

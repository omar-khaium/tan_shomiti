import 'package:flutter/foundation.dart';

@immutable
class DefaultEnforcementStep {
  const DefaultEnforcementStep({
    required this.id,
    required this.shomitiId,
    required this.memberId,
    required this.episodeKey,
    required this.type,
    required this.recordedAt,
    required this.ruleSetVersionId,
    this.note,
    this.amountBdt,
  });

  final int id;
  final String shomitiId;
  final String memberId;
  final String episodeKey;
  final DefaultEnforcementStepType type;
  final DateTime recordedAt;
  final String ruleSetVersionId;
  final String? note;
  final int? amountBdt;
}

@immutable
class NewDefaultEnforcementStep {
  const NewDefaultEnforcementStep({
    required this.shomitiId,
    required this.memberId,
    required this.episodeKey,
    required this.type,
    required this.recordedAt,
    required this.ruleSetVersionId,
    this.note,
    this.amountBdt,
  });

  final String shomitiId;
  final String memberId;
  final String episodeKey;
  final DefaultEnforcementStepType type;
  final DateTime recordedAt;
  final String ruleSetVersionId;
  final String? note;
  final int? amountBdt;
}

enum DefaultEnforcementStepType {
  reminder,
  notice,
  guarantorOrDeposit,
  dispute,
}


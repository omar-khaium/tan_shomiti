import 'package:flutter/foundation.dart';

@immutable
class DrawWitnessApproval {
  const DrawWitnessApproval({
    required this.drawId,
    required this.witnessMemberId,
    required this.ruleSetVersionId,
    required this.note,
    required this.approvedAt,
  });

  final String drawId;
  final String witnessMemberId;
  final String ruleSetVersionId;
  final String? note;
  final DateTime approvedAt;
}


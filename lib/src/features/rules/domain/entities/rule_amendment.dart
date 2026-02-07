import 'package:flutter/foundation.dart';

@immutable
class RuleAmendment {
  const RuleAmendment({
    required this.id,
    required this.shomitiId,
    required this.baseRuleSetVersionId,
    required this.proposedRuleSetVersionId,
    required this.status,
    required this.note,
    required this.sharedReference,
    required this.createdAt,
    required this.appliedAt,
  });

  final String id;
  final String shomitiId;
  final String baseRuleSetVersionId;
  final String proposedRuleSetVersionId;
  final RuleAmendmentStatus status;
  final String? note;
  final String? sharedReference;
  final DateTime createdAt;
  final DateTime? appliedAt;
}

enum RuleAmendmentStatus {
  draft,
  pendingConsent,
  applied,
}


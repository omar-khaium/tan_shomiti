import 'package:flutter/foundation.dart';

enum MembershipChangeType { exit, replacement, removal }

@immutable
class MembershipChangeRequest {
  const MembershipChangeRequest({
    required this.id,
    required this.shomitiId,
    required this.outgoingMemberId,
    required this.type,
    required this.requiresReplacement,
    required this.replacementCandidateName,
    required this.replacementCandidatePhone,
    required this.removalReasonCode,
    required this.removalReasonDetails,
    required this.requestedAt,
    required this.updatedAt,
    required this.finalizedAt,
  });

  final String id;
  final String shomitiId;
  final String outgoingMemberId;
  final MembershipChangeType type;
  final bool requiresReplacement;
  final String? replacementCandidateName;
  final String? replacementCandidatePhone;
  final String? removalReasonCode;
  final String? removalReasonDetails;
  final DateTime requestedAt;
  final DateTime? updatedAt;
  final DateTime? finalizedAt;

  bool get isOpen => finalizedAt == null;
}


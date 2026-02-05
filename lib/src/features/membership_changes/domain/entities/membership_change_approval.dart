import 'package:flutter/foundation.dart';

@immutable
class MembershipChangeApproval {
  const MembershipChangeApproval({
    required this.shomitiId,
    required this.requestId,
    required this.approverMemberId,
    required this.approvedAt,
    required this.note,
  });

  final String shomitiId;
  final String requestId;
  final String approverMemberId;
  final DateTime approvedAt;
  final String? note;
}


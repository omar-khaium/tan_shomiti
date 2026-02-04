import 'package:flutter/foundation.dart';

@immutable
class MemberShareAllocation {
  const MemberShareAllocation({
    required this.shomitiId,
    required this.memberId,
    required this.shares,
    required this.createdAt,
    required this.updatedAt,
  });

  final String shomitiId;
  final String memberId;
  final int shares;
  final DateTime createdAt;
  final DateTime? updatedAt;
}

import 'package:flutter/foundation.dart';

@immutable
class Guarantor {
  const Guarantor({
    required this.shomitiId,
    required this.memberId,
    required this.name,
    required this.phone,
    required this.relationship,
    required this.proofRef,
    required this.recordedAt,
    required this.updatedAt,
  });

  final String shomitiId;
  final String memberId;
  final String name;
  final String phone;
  final String? relationship;
  final String? proofRef;
  final DateTime recordedAt;
  final DateTime? updatedAt;
}

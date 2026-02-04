import 'package:flutter/foundation.dart';

@immutable
class SecurityDeposit {
  const SecurityDeposit({
    required this.shomitiId,
    required this.memberId,
    required this.amountBdt,
    required this.heldBy,
    required this.proofRef,
    required this.recordedAt,
    required this.returnedAt,
    required this.updatedAt,
  });

  final String shomitiId;
  final String memberId;
  final int amountBdt;
  final String heldBy;
  final String? proofRef;
  final DateTime recordedAt;
  final DateTime? returnedAt;
  final DateTime? updatedAt;

  bool get isReturned => returnedAt != null;
}

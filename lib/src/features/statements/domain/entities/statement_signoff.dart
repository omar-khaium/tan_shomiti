import 'package:flutter/foundation.dart';

import '../../../contributions/domain/value_objects/billing_month.dart';
import 'statement_signer_role.dart';

@immutable
class StatementSignoff {
  const StatementSignoff({
    required this.shomitiId,
    required this.month,
    required this.signerMemberId,
    required this.role,
    required this.proofReference,
    required this.note,
    required this.signedAt,
    required this.createdAt,
  });

  final String shomitiId;
  final BillingMonth month;
  final String signerMemberId;
  final StatementSignerRole role;
  final String proofReference;
  final String? note;
  final DateTime signedAt;
  final DateTime createdAt;
}


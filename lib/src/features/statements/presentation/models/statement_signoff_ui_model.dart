import 'package:flutter/foundation.dart';

import '../../domain/entities/statement_signer_role.dart';

@immutable
class StatementSignoffUiModel {
  const StatementSignoffUiModel({
    required this.signerMemberId,
    required this.signerName,
    required this.role,
    required this.proofReference,
    required this.signedAt,
  });

  final String signerMemberId;
  final String signerName;
  final StatementSignerRole role;
  final String proofReference;
  final DateTime signedAt;

  String get roleLabel => switch (role) {
    StatementSignerRole.auditor => 'Auditor',
    StatementSignerRole.witness => 'Witness',
  };
}

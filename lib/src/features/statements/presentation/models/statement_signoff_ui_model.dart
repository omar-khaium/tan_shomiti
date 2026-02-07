import 'package:flutter/foundation.dart';

enum StatementSignerRoleUi {
  auditor,
  witness,
}

@immutable
class StatementSignoffUiModel {
  const StatementSignoffUiModel({
    required this.signerName,
    required this.role,
    required this.proofReference,
    required this.signedAt,
  });

  final String signerName;
  final StatementSignerRoleUi role;
  final String proofReference;
  final DateTime signedAt;

  String get roleLabel => switch (role) {
    StatementSignerRoleUi.auditor => 'Auditor',
    StatementSignerRoleUi.witness => 'Witness',
  };
}


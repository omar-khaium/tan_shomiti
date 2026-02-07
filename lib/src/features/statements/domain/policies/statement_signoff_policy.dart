import '../entities/statement_signer_role.dart';
import '../entities/statement_signoff.dart';

enum StatementSignoffStatus {
  notSigned,
  partiallySigned,
  signed,
}

class StatementSignoffPolicy {
  const StatementSignoffPolicy();

  /// A statement is considered signed when:
  /// - at least 1 Auditor sign-off exists, OR
  /// - at least 2 Witness sign-offs exist (distinct members)
  StatementSignoffStatus statusOf(List<StatementSignoff> signoffs) {
    if (signoffs.isEmpty) return StatementSignoffStatus.notSigned;

    final auditorCount =
        signoffs.where((s) => s.role == StatementSignerRole.auditor).length;
    final witnessIds = {
      for (final s in signoffs)
        if (s.role == StatementSignerRole.witness) s.signerMemberId,
    };

    if (auditorCount >= 1 || witnessIds.length >= 2) {
      return StatementSignoffStatus.signed;
    }
    return StatementSignoffStatus.partiallySigned;
  }
}


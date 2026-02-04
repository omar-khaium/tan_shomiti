import '../entities/guarantor.dart';
import '../entities/security_deposit.dart';
import 'risk_controls_exceptions.dart';

class CheckRiskControlsComplete {
  const CheckRiskControlsComplete();

  /// Enforces `rules.md` Section 9.3 risk controls.
  ///
  /// - A member is **complete** if they have a guarantor OR a deposit that is
  ///   currently held (not returned).
  /// - Returned deposits do not count as complete.
  ///
  /// If [required] is true and any member is incomplete, throws
  /// [RiskControlMissingException].
  void call({
    required List<String> memberIds,
    required List<Guarantor> guarantors,
    required List<SecurityDeposit> deposits,
    required bool required,
  }) {
    if (!required) return;

    final guarantorMemberIds = guarantors.map((g) => g.memberId).toSet();
    final heldDepositMemberIds = deposits
        .where((d) => !d.isReturned)
        .map((d) => d.memberId)
        .toSet();

    final missing = <String>[];
    for (final memberId in memberIds) {
      if (guarantorMemberIds.contains(memberId)) continue;
      if (heldDepositMemberIds.contains(memberId)) continue;
      missing.add(memberId);
    }

    if (missing.isNotEmpty) {
      throw RiskControlMissingException(missingMemberIds: missing);
    }
  }
}

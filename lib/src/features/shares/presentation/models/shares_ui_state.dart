import 'package:flutter/foundation.dart';

import '../../../members/domain/entities/member.dart';
import '../../../rules/domain/entities/rule_set_snapshot.dart';

@immutable
class SharesMemberAllocation {
  const SharesMemberAllocation({
    required this.memberId,
    required this.displayName,
    required this.shares,
    required this.monthlyDueBdt,
  });

  final String memberId;
  final String displayName;
  final int shares;
  final int monthlyDueBdt;
}

@immutable
class SharesUiState {
  const SharesUiState({
    required this.shomitiId,
    required this.ruleSetVersionId,
    required this.rules,
    required this.totalShares,
    required this.shareValueBdt,
    required this.allowShareTransfers,
    required this.maxSharesPerPerson,
    required this.allocations,
    required this.allocatedShares,
    required this.remainingShares,
    required this.monthlyPotBdt,
    required this.isValid,
    required this.validationMessage,
  });

  final String shomitiId;
  final String ruleSetVersionId;
  final RuleSetSnapshot rules;

  /// Total fixed shares for the cycle. `rules.md` Section 5.1.
  ///
  /// The setup wizard states cycle length typically equals total shares.
  final int totalShares;

  /// Share value per month (S), in BDT. `rules.md` Section 6.1.
  final int shareValueBdt;

  final bool allowShareTransfers;
  final int maxSharesPerPerson;

  final List<SharesMemberAllocation> allocations;
  final int allocatedShares;
  final int remainingShares;
  final int monthlyPotBdt;

  final bool isValid;
  final String? validationMessage;

  static SharesUiState from({
    required String shomitiId,
    required String ruleSetVersionId,
    required RuleSetSnapshot rules,
    required List<Member> members,
    required Map<String, int> sharesByMemberId,
  }) {
    final totalShares = rules.cycleLengthMonths;
    final shareValueBdt = rules.shareValueBdt;
    final maxSharesPerPerson = rules.maxSharesPerPerson;

    var allocatedShares = 0;
    var invalidMemberShares = false;

    final allocations = <SharesMemberAllocation>[];
    for (final member in members) {
      final shares = sharesByMemberId[member.id] ?? 1;
      allocatedShares += shares;

      if (shares < 1 || shares > maxSharesPerPerson) {
        invalidMemberShares = true;
      }

      allocations.add(
        SharesMemberAllocation(
          memberId: member.id,
          displayName: member.fullName,
          shares: shares,
          monthlyDueBdt: shares * shareValueBdt,
        ),
      );
    }

    final remainingShares = totalShares - allocatedShares;
    final monthlyPotBdt = totalShares * shareValueBdt;

    final isValid = !invalidMemberShares && remainingShares == 0;
    final validationMessage = isValid
        ? null
        : invalidMemberShares
        ? 'Each member must have 1–$maxSharesPerPerson shares.'
        : remainingShares > 0
        ? 'Allocate $remainingShares more shares to reach $totalShares total.'
        : 'Too many shares allocated. Reduce ${remainingShares.abs()} share(s) to reach $totalShares total.';

    return SharesUiState(
      shomitiId: shomitiId,
      ruleSetVersionId: ruleSetVersionId,
      rules: rules,
      totalShares: totalShares,
      shareValueBdt: shareValueBdt,
      allowShareTransfers: rules.allowShareTransfers,
      maxSharesPerPerson: maxSharesPerPerson,
      allocations: List.unmodifiable(allocations),
      allocatedShares: allocatedShares,
      remainingShares: remainingShares,
      monthlyPotBdt: monthlyPotBdt,
      isValid: isValid,
      validationMessage: validationMessage,
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/rule_set_snapshot.dart';
import '../../domain/entities/rule_set_version.dart';

final rulesViewerProvider = FutureProvider.autoDispose<RuleSetVersion?>((ref) async {
  // Stage 2 (UI): demo-only data. Real wiring lands in Stage 3.
  return RuleSetVersion(
    id: 'demo',
    createdAt: DateTime(2026, 1, 1),
    snapshot: RuleSetSnapshot(
      schemaVersion: 1,
      shomitiName: 'Demo Shomiti',
      startDate: DateTime(2026, 1, 1),
      groupType: GroupTypePolicy.closed,
      memberCount: 10,
      shareValueBdt: 1000,
      maxSharesPerPerson: 1,
      allowShareTransfers: false,
      cycleLengthMonths: 10,
      meetingSchedule: 'Every month, Friday 8pm',
      paymentDeadline: '5th day of the month',
      payoutMethod: PayoutMethod.mobileWallet,
      groupChannel: null,
      missedPaymentPolicy: MissedPaymentPolicy.postponePayout,
      gracePeriodDays: null,
      lateFeeBdtPerDay: null,
      feesEnabled: false,
      feeAmountBdt: null,
      feePayerModel: FeePayerModel.everyoneEqually,
      ruleChangeAfterStartRequiresUnanimous: true,
    ),
  );
});


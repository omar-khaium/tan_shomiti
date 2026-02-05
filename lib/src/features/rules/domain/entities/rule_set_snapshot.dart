enum GroupTypePolicy {
  closed,
  open,
}

enum MissedPaymentPolicy {
  postponePayout,
  coverFromReserve,
  coverByGuarantor,
}

enum PayoutMethod {
  cash,
  bank,
  mobileWallet,
  mixed,
}

enum FeePayerModel {
  everyoneEqually,
  winnerPays,
}

class RuleSetSnapshot {
  const RuleSetSnapshot({
    required this.schemaVersion,
    required this.shomitiName,
    required this.startDate,
    required this.groupType,
    required this.memberCount,
    required this.shareValueBdt,
    required this.maxSharesPerPerson,
    required this.allowShareTransfers,
    required this.cycleLengthMonths,
    required this.meetingSchedule,
    required this.paymentDeadline,
    required this.payoutMethod,
    required this.groupChannel,
    required this.missedPaymentPolicy,
    required this.gracePeriodDays,
    required this.lateFeeBdtPerDay,
    required this.defaultConsecutiveMissedThreshold,
    required this.defaultTotalMissedThreshold,
    required this.feesEnabled,
    required this.feeAmountBdt,
    required this.feePayerModel,
    required this.ruleChangeAfterStartRequiresUnanimous,
  });

  /// Snapshot schema version (for future migrations).
  final int schemaVersion;

  /// `rules.md` Section 1 fields.
  final String shomitiName;
  final DateTime startDate;
  final GroupTypePolicy groupType;
  final int memberCount;
  final int shareValueBdt;
  final int maxSharesPerPerson;
  final bool allowShareTransfers;
  final int cycleLengthMonths;
  final String meetingSchedule;
  final String paymentDeadline;
  final PayoutMethod payoutMethod;
  final String? groupChannel;

  /// `rules.md` Sections 9.1 & 9.2.
  final MissedPaymentPolicy missedPaymentPolicy;
  final int? gracePeriodDays;
  final int? lateFeeBdtPerDay;

  /// `rules.md` Section 9.3.
  final int defaultConsecutiveMissedThreshold;
  final int defaultTotalMissedThreshold;

  /// `rules.md` Section 11.
  final bool feesEnabled;
  final int? feeAmountBdt;
  final FeePayerModel feePayerModel;

  /// `rules.md` Section 15 default.
  final bool ruleChangeAfterStartRequiresUnanimous;

  Map<String, Object?> toJson() {
    return {
      'schemaVersion': schemaVersion,
      'shomitiName': shomitiName,
      'startDate': startDate.toIso8601String(),
      'groupType': groupType.name,
      'memberCount': memberCount,
      'shareValueBdt': shareValueBdt,
      'maxSharesPerPerson': maxSharesPerPerson,
      'allowShareTransfers': allowShareTransfers,
      'cycleLengthMonths': cycleLengthMonths,
      'meetingSchedule': meetingSchedule,
      'paymentDeadline': paymentDeadline,
      'payoutMethod': payoutMethod.name,
      'groupChannel': groupChannel,
      'missedPaymentPolicy': missedPaymentPolicy.name,
      'gracePeriodDays': gracePeriodDays,
      'lateFeeBdtPerDay': lateFeeBdtPerDay,
      'defaultConsecutiveMissedThreshold': defaultConsecutiveMissedThreshold,
      'defaultTotalMissedThreshold': defaultTotalMissedThreshold,
      'feesEnabled': feesEnabled,
      'feeAmountBdt': feeAmountBdt,
      'feePayerModel': feePayerModel.name,
      'ruleChangeAfterStartRequiresUnanimous':
          ruleChangeAfterStartRequiresUnanimous,
    };
  }

  factory RuleSetSnapshot.fromJson(Map<String, Object?> json) {
    final schemaVersion = (json['schemaVersion'] as int?) ?? 1;

    return RuleSetSnapshot(
      schemaVersion: schemaVersion,
      shomitiName: json['shomitiName'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      groupType: GroupTypePolicy.values.byName(json['groupType'] as String),
      memberCount: json['memberCount'] as int,
      shareValueBdt: json['shareValueBdt'] as int,
      maxSharesPerPerson: json['maxSharesPerPerson'] as int,
      allowShareTransfers: json['allowShareTransfers'] as bool,
      cycleLengthMonths: json['cycleLengthMonths'] as int,
      meetingSchedule: json['meetingSchedule'] as String,
      paymentDeadline: json['paymentDeadline'] as String,
      payoutMethod: PayoutMethod.values.byName(json['payoutMethod'] as String),
      groupChannel: json['groupChannel'] as String?,
      missedPaymentPolicy: MissedPaymentPolicy.values.byName(
        json['missedPaymentPolicy'] as String,
      ),
      gracePeriodDays: json['gracePeriodDays'] as int?,
      lateFeeBdtPerDay: json['lateFeeBdtPerDay'] as int?,
      defaultConsecutiveMissedThreshold:
          (json['defaultConsecutiveMissedThreshold'] as int?) ?? 2,
      defaultTotalMissedThreshold:
          (json['defaultTotalMissedThreshold'] as int?) ?? 3,
      feesEnabled: json['feesEnabled'] as bool,
      feeAmountBdt: json['feeAmountBdt'] as int?,
      feePayerModel: FeePayerModel.values.byName(
        json['feePayerModel'] as String,
      ),
      ruleChangeAfterStartRequiresUnanimous:
          json['ruleChangeAfterStartRequiresUnanimous'] as bool,
    );
  }
}

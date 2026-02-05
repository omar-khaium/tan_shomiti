import '../entities/default_enforcement_step.dart';

class MemberDuePaymentRow {
  const MemberDuePaymentRow({
    required this.memberId,
    required this.memberName,
    required this.monthKey,
    required this.dueAmountBdt,
    required this.hasPayment,
  });

  final String memberId;
  final String memberName;
  final String monthKey;
  final int dueAmountBdt;
  final bool hasPayment;
}

abstract class DefaultsRepository {
  Future<List<MemberDuePaymentRow>> listMemberDuePayments({
    required String shomitiId,
  });

  Future<List<DefaultEnforcementStep>> listEnforcementSteps({
    required String shomitiId,
  });

  Future<void> addEnforcementStep(NewDefaultEnforcementStep step);
}


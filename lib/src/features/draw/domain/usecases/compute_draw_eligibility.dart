import '../../../contributions/domain/repositories/monthly_dues_repository.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../../members/domain/repositories/members_repository.dart';
import '../../../payments/domain/repositories/payments_repository.dart';
import '../../../payments/domain/usecases/compute_payment_compliance.dart';
import '../../../rules/domain/entities/rule_set_snapshot.dart';
import '../repositories/draw_records_repository.dart';

class DrawShareEligibility {
  const DrawShareEligibility({
    required this.memberId,
    required this.memberName,
    required this.shareIndex,
    required this.isEligible,
    required this.reason,
  });

  final String memberId;
  final String memberName;
  final int shareIndex;
  final bool isEligible;
  final String? reason;

  String get shareKey => '$memberId#$shareIndex';
}

class ComputeDrawEligibilityResult {
  const ComputeDrawEligibilityResult({
    required this.hasDuesForMonth,
    required this.items,
  });

  final bool hasDuesForMonth;
  final List<DrawShareEligibility> items;
}

class ComputeDrawEligibility {
  const ComputeDrawEligibility({
    required MonthlyDuesRepository monthlyDuesRepository,
    required MembersRepository membersRepository,
    required PaymentsRepository paymentsRepository,
    required DrawRecordsRepository drawRecordsRepository,
    required ComputePaymentCompliance computePaymentCompliance,
  }) : _monthlyDuesRepository = monthlyDuesRepository,
       _membersRepository = membersRepository,
       _paymentsRepository = paymentsRepository,
       _drawRecordsRepository = drawRecordsRepository,
       _computePaymentCompliance = computePaymentCompliance;

  final MonthlyDuesRepository _monthlyDuesRepository;
  final MembersRepository _membersRepository;
  final PaymentsRepository _paymentsRepository;
  final DrawRecordsRepository _drawRecordsRepository;
  final ComputePaymentCompliance _computePaymentCompliance;

  Future<ComputeDrawEligibilityResult> call({
    required String shomitiId,
    required BillingMonth month,
    required RuleSetSnapshot rules,
  }) async {
    final dueMonth = await _monthlyDuesRepository.getDueMonth(
      shomitiId: shomitiId,
      month: month,
    );
    if (dueMonth == null) {
      return const ComputeDrawEligibilityResult(
        hasDuesForMonth: false,
        items: [],
      );
    }

    final members = await _membersRepository.listMembers(shomitiId: shomitiId);
    final memberNameById = {
      for (final m in members) m.id: m.fullName,
    };

    final dues = await _monthlyDuesRepository.listMonthlyDues(
      shomitiId: shomitiId,
      month: month,
    );

    final payments = await _paymentsRepository
        .watchPaymentsForMonth(shomitiId: shomitiId, month: month)
        .first;
    final paymentByMemberId = {
      for (final p in payments) p.memberId: p,
    };

    final draws = await _drawRecordsRepository.listAll(shomitiId: shomitiId);
    final winnerShareKeys = draws
        .where((r) => !r.isInvalidated)
        .map((r) => r.winnerShareKey)
        .toSet();

    final items = <DrawShareEligibility>[];

    for (final due in dues) {
      final memberName = memberNameById[due.memberId] ?? 'Member';
      final payment = paymentByMemberId[due.memberId];

      final compliance = payment == null
          ? null
          : _computePaymentCompliance(
              month: month,
              confirmedAt: payment.confirmedAt,
              paymentDeadline: rules.paymentDeadline,
              gracePeriodDays: rules.gracePeriodDays,
              lateFeeBdtPerDay: rules.lateFeeBdtPerDay,
            );

      for (var i = 1; i <= due.shares; i++) {
        final shareKey = '${due.memberId}#$i';
        if (winnerShareKeys.contains(shareKey)) {
          items.add(
            DrawShareEligibility(
              memberId: due.memberId,
              memberName: memberName,
              shareIndex: i,
              isEligible: false,
              reason: 'Already won',
            ),
          );
          continue;
        }

        if (payment == null) {
          items.add(
            DrawShareEligibility(
              memberId: due.memberId,
              memberName: memberName,
              shareIndex: i,
              isEligible: false,
              reason: 'Payment not confirmed',
            ),
          );
          continue;
        }

        if (compliance != null && compliance.isEligible) {
          items.add(
            DrawShareEligibility(
              memberId: due.memberId,
              memberName: memberName,
              shareIndex: i,
              isEligible: true,
              reason: null,
            ),
          );
        } else {
          items.add(
            DrawShareEligibility(
              memberId: due.memberId,
              memberName: memberName,
              shareIndex: i,
              isEligible: false,
              reason: 'Late (outside grace)',
            ),
          );
        }
      }
    }

    return ComputeDrawEligibilityResult(
      hasDuesForMonth: true,
      items: List.unmodifiable(items),
    );
  }
}

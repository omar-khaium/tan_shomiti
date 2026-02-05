import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/payments/domain/usecases/compute_payment_compliance.dart';

void main() {
  test('ComputePaymentCompliance parses deadline day (1..28)', () {
    const policy = ComputePaymentCompliance();
    const month = BillingMonth(year: 2026, month: 2);

    final result = policy(
      month: month,
      confirmedAt: DateTime.utc(2026, 2, 1),
      paymentDeadline: '5th day of the month',
      gracePeriodDays: 0,
      lateFeeBdtPerDay: 50,
    );

    expect(result.deadlineDay, 5);
  });

  test('ComputePaymentCompliance falls back when parsing fails', () {
    const policy = ComputePaymentCompliance();
    const month = BillingMonth(year: 2026, month: 2);

    final result = policy(
      month: month,
      confirmedAt: DateTime.utc(2030, 1, 1),
      paymentDeadline: 'end of month',
      gracePeriodDays: 0,
      lateFeeBdtPerDay: 50,
    );

    expect(result.deadlineDay, isNull);
    expect(result.isEligible, isTrue);
    expect(result.lateFeeBdt, 0);
  });

  test('ComputePaymentCompliance computes late fee and ineligibility', () {
    const policy = ComputePaymentCompliance();
    const month = BillingMonth(year: 2026, month: 2);

    final result = policy(
      month: month,
      confirmedAt: DateTime.utc(2026, 2, 8, 1), // after deadline+grace
      paymentDeadline: '5th day of the month',
      gracePeriodDays: 2, // cutoff: Feb 7
      lateFeeBdtPerDay: 50,
    );

    expect(result.isEligible, isFalse);
    expect(result.isOnTime, isFalse);
    expect(result.lateFeeBdt, 50); // 1 day late (ceil)
  });
}

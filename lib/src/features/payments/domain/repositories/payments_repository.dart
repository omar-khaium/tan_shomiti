import '../../../contributions/domain/value_objects/billing_month.dart';
import '../entities/payment.dart';

abstract class PaymentsRepository {
  Stream<List<Payment>> watchPaymentsForMonth({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<Payment?> getPayment({
    required String id,
  });

  Future<Payment?> getPaymentForMember({
    required String shomitiId,
    required BillingMonth month,
    required String memberId,
  });

  Future<void> upsertPayment(Payment payment);
}


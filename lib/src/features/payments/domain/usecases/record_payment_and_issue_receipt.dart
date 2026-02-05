import '../../../contributions/domain/value_objects/billing_month.dart';
import '../entities/payment.dart';
import '../value_objects/payment_method.dart';
import 'issue_receipt.dart';
import 'record_payment.dart';

class RecordPaymentAndIssueReceipt {
  const RecordPaymentAndIssueReceipt({
    required RecordPayment recordPayment,
    required IssueReceipt issueReceipt,
  }) : _recordPayment = recordPayment,
       _issueReceipt = issueReceipt;

  final RecordPayment _recordPayment;
  final IssueReceipt _issueReceipt;

  Future<Payment> call({
    required String shomitiId,
    required BillingMonth month,
    required String memberId,
    required int amountBdt,
    required PaymentMethod method,
    required String reference,
    required String? proofNote,
    DateTime? now,
  }) async {
    final payment = await _recordPayment(
      shomitiId: shomitiId,
      month: month,
      memberId: memberId,
      amountBdt: amountBdt,
      method: method,
      reference: reference,
      proofNote: proofNote,
      now: now,
    );
    return _issueReceipt(paymentId: payment.id, now: now);
  }
}


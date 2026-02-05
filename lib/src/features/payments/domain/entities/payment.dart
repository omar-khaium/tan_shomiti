import '../../../contributions/domain/value_objects/billing_month.dart';
import '../value_objects/payment_method.dart';

class Payment {
  const Payment({
    required this.id,
    required this.shomitiId,
    required this.month,
    required this.memberId,
    required this.amountBdt,
    required this.method,
    required this.reference,
    required this.proofNote,
    required this.recordedAt,
    required this.confirmedAt,
    required this.receiptNumber,
    required this.receiptIssuedAt,
  });

  final String id;
  final String shomitiId;
  final BillingMonth month;
  final String memberId;
  final int amountBdt;
  final PaymentMethod method;
  final String reference;
  final String? proofNote;
  final DateTime recordedAt;
  final DateTime confirmedAt;
  final String? receiptNumber;
  final DateTime? receiptIssuedAt;

  bool get hasReceipt => receiptNumber != null && receiptIssuedAt != null;
}


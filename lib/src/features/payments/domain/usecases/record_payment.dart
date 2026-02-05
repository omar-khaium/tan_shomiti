import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../entities/payment.dart';
import '../repositories/payments_repository.dart';
import '../usecases/payments_exceptions.dart';
import '../value_objects/payment_method.dart';

class RecordPayment {
  const RecordPayment({
    required PaymentsRepository paymentsRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _paymentsRepository = paymentsRepository,
       _appendAuditEvent = appendAuditEvent;

  final PaymentsRepository _paymentsRepository;
  final AppendAuditEvent _appendAuditEvent;

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
    final ts = now ?? DateTime.now().toUtc();
    final ref = reference.trim();
    if (amountBdt <= 0) {
      throw const PaymentValidationException('Amount must be positive.');
    }
    if (ref.isEmpty) {
      throw const PaymentValidationException('Reference is required.');
    }

    final id = 'payment_${shomitiId}_${month.key}_$memberId';
    final payment = Payment(
      id: id,
      shomitiId: shomitiId,
      month: month,
      memberId: memberId,
      amountBdt: amountBdt,
      method: method,
      reference: ref,
      proofNote: proofNote?.trim().isEmpty == true ? null : proofNote?.trim(),
      recordedAt: ts,
      confirmedAt: ts,
      receiptNumber: null,
      receiptIssuedAt: null,
    );

    await _paymentsRepository.upsertPayment(payment);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'payment_recorded',
        occurredAt: ts,
        message: 'Recorded payment.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'month': month.key,
          'memberId': memberId,
          'amountBdt': amountBdt,
          'method': method.value,
        }),
      ),
    );

    return payment;
  }
}


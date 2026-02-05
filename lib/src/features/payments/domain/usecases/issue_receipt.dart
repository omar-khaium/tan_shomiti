import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/payment.dart';
import '../repositories/payments_repository.dart';

class IssueReceipt {
  const IssueReceipt({
    required PaymentsRepository paymentsRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _paymentsRepository = paymentsRepository,
       _appendAuditEvent = appendAuditEvent;

  final PaymentsRepository _paymentsRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<Payment> call({
    required String paymentId,
    DateTime? now,
  }) async {
    final ts = now ?? DateTime.now().toUtc();
    final existing = await _paymentsRepository.getPayment(id: paymentId);
    if (existing == null) {
      throw StateError('Payment not found: $paymentId');
    }
    if (existing.hasReceipt) return existing;

    final receiptNumber =
        'RCT-${existing.month.key}-${ts.microsecondsSinceEpoch}';
    final updated = Payment(
      id: existing.id,
      shomitiId: existing.shomitiId,
      month: existing.month,
      memberId: existing.memberId,
      amountBdt: existing.amountBdt,
      method: existing.method,
      reference: existing.reference,
      proofNote: existing.proofNote,
      recordedAt: existing.recordedAt,
      confirmedAt: existing.confirmedAt,
      receiptNumber: receiptNumber,
      receiptIssuedAt: ts,
    );

    await _paymentsRepository.upsertPayment(updated);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'receipt_issued',
        occurredAt: ts,
        message: 'Issued receipt.',
        metadataJson: jsonEncode({
          'paymentId': paymentId,
          'receiptNumber': receiptNumber,
        }),
      ),
    );

    return updated;
  }
}


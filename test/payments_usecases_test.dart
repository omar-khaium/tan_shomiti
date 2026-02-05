import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/payments/domain/entities/payment.dart';
import 'package:tan_shomiti/src/features/payments/domain/repositories/payments_repository.dart';
import 'package:tan_shomiti/src/features/payments/domain/usecases/issue_receipt.dart';
import 'package:tan_shomiti/src/features/payments/domain/usecases/payments_exceptions.dart';
import 'package:tan_shomiti/src/features/payments/domain/usecases/record_payment.dart';
import 'package:tan_shomiti/src/features/payments/domain/usecases/record_payment_and_issue_receipt.dart';
import 'package:tan_shomiti/src/features/payments/domain/value_objects/payment_method.dart';

class _FakePaymentsRepository implements PaymentsRepository {
  final Map<String, Payment> _byId = {};

  @override
  Stream<List<Payment>> watchPaymentsForMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async* {
    yield const [];
  }

  @override
  Future<Payment?> getPayment({required String id}) async => _byId[id];

  @override
  Future<Payment?> getPaymentForMember({
    required String shomitiId,
    required BillingMonth month,
    required String memberId,
  }) async {
    final id = 'payment_${shomitiId}_${month.key}_$memberId';
    return _byId[id];
  }

  @override
  Future<void> upsertPayment(Payment payment) async {
    _byId[payment.id] = payment;
  }
}

class _FakeAuditRepository implements AuditRepository {
  final List<NewAuditEvent> appended = [];

  @override
  Future<void> append(NewAuditEvent event) async {
    appended.add(event);
  }

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) async* {
    yield const [];
  }
}

void main() {
  test('RecordPayment validates amount and reference', () async {
    final paymentsRepo = _FakePaymentsRepository();
    final auditRepo = _FakeAuditRepository();
    final recordPayment = RecordPayment(
      paymentsRepository: paymentsRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    await expectLater(
      () => recordPayment(
        shomitiId: 's1',
        month: const BillingMonth(year: 2026, month: 2),
        memberId: 'm1',
        amountBdt: 0,
        method: PaymentMethod.cash,
        reference: 'r',
        proofNote: null,
        now: DateTime.utc(2026, 2, 5),
      ),
      throwsA(isA<PaymentValidationException>()),
    );

    await expectLater(
      () => recordPayment(
        shomitiId: 's1',
        month: const BillingMonth(year: 2026, month: 2),
        memberId: 'm1',
        amountBdt: 1,
        method: PaymentMethod.cash,
        reference: '   ',
        proofNote: null,
        now: DateTime.utc(2026, 2, 5),
      ),
      throwsA(isA<PaymentValidationException>()),
    );

    expect(auditRepo.appended, isEmpty);
  });

  test('RecordPaymentAndIssueReceipt issues one receipt per payment id', () async {
    final paymentsRepo = _FakePaymentsRepository();
    final auditRepo = _FakeAuditRepository();
    final recordPayment = RecordPayment(
      paymentsRepository: paymentsRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );
    final issueReceipt = IssueReceipt(
      paymentsRepository: paymentsRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );
    final recordAndIssue = RecordPaymentAndIssueReceipt(
      recordPayment: recordPayment,
      issueReceipt: issueReceipt,
    );

    final now = DateTime.utc(2026, 2, 5);
    final month = const BillingMonth(year: 2026, month: 2);
    final payment1 = await recordAndIssue(
      shomitiId: 's1',
      month: month,
      memberId: 'm1',
      amountBdt: 2000,
      method: PaymentMethod.mobileWallet,
      reference: 'trx-1',
      proofNote: null,
      now: now,
    );

    expect(payment1.hasReceipt, isTrue);
    expect(payment1.receiptNumber, isNotNull);

    final payment2 = await recordAndIssue(
      shomitiId: 's1',
      month: month,
      memberId: 'm1',
      amountBdt: 2000,
      method: PaymentMethod.mobileWallet,
      reference: 'trx-1',
      proofNote: null,
      now: now,
    );

    expect(payment2.receiptNumber, payment1.receiptNumber);
    expect(
      auditRepo.appended.map((e) => e.action),
      containsAll(['payment_recorded', 'receipt_issued']),
    );
  });
}


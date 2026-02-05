import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../domain/entities/payment.dart';
import '../domain/repositories/payments_repository.dart';
import '../domain/value_objects/payment_method.dart';

class DriftPaymentsRepository implements PaymentsRepository {
  DriftPaymentsRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Payment>> watchPaymentsForMonth({
    required String shomitiId,
    required BillingMonth month,
  }) {
    final query = _db.select(_db.payments)
      ..where((p) => p.shomitiId.equals(shomitiId))
      ..where((p) => p.monthKey.equals(month.key))
      ..orderBy([(p) => OrderingTerm(expression: p.memberId)]);

    return query.watch().map(
          (rows) => rows.map(_mapRow).toList(growable: false),
        );
  }

  @override
  Future<Payment?> getPayment({required String id}) async {
    final row =
        await (_db.select(_db.payments)..where((p) => p.id.equals(id)))
            .getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  @override
  Future<Payment?> getPaymentForMember({
    required String shomitiId,
    required BillingMonth month,
    required String memberId,
  }) async {
    final row =
        await (_db.select(_db.payments)
              ..where(
                (p) =>
                    p.shomitiId.equals(shomitiId) &
                    p.monthKey.equals(month.key) &
                    p.memberId.equals(memberId),
              ))
            .getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  @override
  Future<void> upsertPayment(Payment payment) async {
    await _db.into(_db.payments).insertOnConflictUpdate(
          PaymentsCompanion.insert(
            id: payment.id,
            shomitiId: payment.shomitiId,
            monthKey: payment.month.key,
            memberId: payment.memberId,
            amountBdt: payment.amountBdt,
            method: payment.method.value,
            reference: payment.reference,
            proofNote: Value(payment.proofNote),
            recordedAt: payment.recordedAt,
            confirmedAt: payment.confirmedAt,
            receiptNumber: Value(payment.receiptNumber),
            receiptIssuedAt: Value(payment.receiptIssuedAt),
          ),
        );
  }

  static Payment _mapRow(PaymentRow row) {
    return Payment(
      id: row.id,
      shomitiId: row.shomitiId,
      month: BillingMonth.fromKey(row.monthKey),
      memberId: row.memberId,
      amountBdt: row.amountBdt,
      method: PaymentMethodStorage.fromValue(row.method),
      reference: row.reference,
      proofNote: row.proofNote,
      recordedAt: row.recordedAt,
      confirmedAt: row.confirmedAt,
      receiptNumber: row.receiptNumber,
      receiptIssuedAt: row.receiptIssuedAt,
    );
  }
}


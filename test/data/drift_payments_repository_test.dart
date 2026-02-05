import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/payments/data/drift_payments_repository.dart';
import 'package:tan_shomiti/src/features/payments/domain/entities/payment.dart';
import 'package:tan_shomiti/src/features/payments/domain/value_objects/payment_method.dart';

void main() {
  test('DriftPaymentsRepository persists payment and receipt', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);

    final now = DateTime.utc(2026, 2, 5);

    await db.into(db.shomitis).insert(
          ShomitisCompanion.insert(
            id: 's1',
            name: 'Demo',
            startDate: now,
            createdAt: now,
            activeRuleSetVersionId: 'rsv_1',
          ),
        );

    await db.into(db.members).insert(
          MembersCompanion.insert(
            id: 'm1',
            shomitiId: 's1',
            position: 1,
            displayName: 'Member 1',
            createdAt: now,
          ),
        );

    final repo = DriftPaymentsRepository(db);
    const month = BillingMonth(year: 2026, month: 2);

    final payment = Payment(
      id: 'payment_s1_${month.key}_m1',
      shomitiId: 's1',
      month: month,
      memberId: 'm1',
      amountBdt: 2000,
      method: PaymentMethod.cash,
      reference: 'cash-1',
      proofNote: null,
      recordedAt: now,
      confirmedAt: now,
      receiptNumber: 'RCT-2026-02-1',
      receiptIssuedAt: now,
    );

    await repo.upsertPayment(payment);

    final loaded = await repo.getPaymentForMember(
      shomitiId: 's1',
      month: month,
      memberId: 'm1',
    );
    expect(loaded, isNotNull);
    expect(loaded!.receiptNumber, 'RCT-2026-02-1');
    expect(loaded.amountBdt, 2000);
  });
}


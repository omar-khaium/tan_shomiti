import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/audit/data/drift_audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/contributions/data/drift_monthly_collection_repository.dart';
import 'package:tan_shomiti/src/features/contributions/data/drift_monthly_dues_repository.dart';
import 'package:tan_shomiti/src/features/contributions/domain/entities/collection_resolution.dart';
import 'package:tan_shomiti/src/features/contributions/domain/entities/monthly_due.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/draw/data/drift_draw_records_repository.dart';
import 'package:tan_shomiti/src/features/draw/data/drift_draw_witness_repository.dart';
import 'package:tan_shomiti/src/features/draw/domain/entities/draw_record.dart';
import 'package:tan_shomiti/src/features/draw/domain/entities/draw_witness_approval.dart';
import 'package:tan_shomiti/src/features/draw/domain/value_objects/draw_method.dart';
import 'package:tan_shomiti/src/features/members/data/drift_members_repository.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';
import 'package:tan_shomiti/src/features/payments/data/drift_payments_repository.dart';
import 'package:tan_shomiti/src/features/payments/domain/entities/payment.dart';
import 'package:tan_shomiti/src/features/payments/domain/value_objects/payment_method.dart';
import 'package:tan_shomiti/src/features/payout/data/drift_payout_repository.dart';
import 'package:tan_shomiti/src/features/payout/domain/entities/payout_record.dart';
import 'package:tan_shomiti/src/features/statements/data/drift_statements_repository.dart';
import 'package:tan_shomiti/src/features/statements/domain/usecases/generate_monthly_statement.dart';

void main() {
  Future<AppDatabase> seededDb({DateTime? now}) async {
    final db = AppDatabase.memory();
    final ts = now ?? DateTime.utc(2026, 2, 5);

    await db.into(db.shomitis).insert(
          ShomitisCompanion.insert(
            id: 'active',
            name: 'Demo',
            startDate: ts,
            createdAt: ts,
            activeRuleSetVersionId: 'rsv_1',
          ),
        );

    await db.into(db.ruleSetVersions).insert(
          RuleSetVersionsCompanion.insert(
            id: 'rsv_1',
            createdAt: ts,
            json: '{}',
          ),
        );

    return db;
  }

  test('GenerateMonthlyStatement requires payout paid and finalized draw', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final auditRepo = DriftAuditRepository(db);
    final statementsRepo = DriftStatementsRepository(db);
    final duesRepo = DriftMonthlyDuesRepository(db);
    final paymentsRepo = DriftPaymentsRepository(db);
    final collectionRepo = DriftMonthlyCollectionRepository(db);
    final drawRepo = DriftDrawRecordsRepository(db);
    final witnessRepo = DriftDrawWitnessRepository(db);
    final membersRepo = DriftMembersRepository(db);
    final payoutRepo = DriftPayoutRepository(db);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 9);

    // Seed minimal dues+payments.
    await duesRepo.replaceMonthlyDues(
      shomitiId: 'active',
      month: month,
      dues: [
        MonthlyDue(
          shomitiId: 'active',
          month: month,
          memberId: 'm1',
          shares: 1,
          shareValueBdt: 1000,
          dueAmountBdt: 1000,
          createdAt: now,
        ),
      ],
    );
    await paymentsRepo.upsertPayment(
      Payment(
        id: 'p1',
        shomitiId: 'active',
        month: month,
        memberId: 'm1',
        amountBdt: 1000,
        method: PaymentMethod.cash,
        reference: 'ref1',
        proofNote: null,
        recordedAt: now,
        confirmedAt: now,
        receiptNumber: null,
        receiptIssuedAt: null,
      ),
    );
    await collectionRepo.upsertResolution(
      CollectionResolution(
        shomitiId: 'active',
        month: month,
        method: CollectionResolutionMethod.reserve,
        amountBdt: 0,
        note: null,
        createdAt: now,
      ),
    );

    await membersRepo.upsert(
      Member(
        shomitiId: 'active',
        id: 'm1',
        position: 1,
        fullName: 'Member 1',
        phone: null,
        addressOrWorkplace: null,
        nidOrPassport: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await drawRepo.upsert(
      DrawRecord(
        id: 'draw_1',
        shomitiId: 'active',
        month: month,
        ruleSetVersionId: 'rsv_1',
        method: DrawMethod.numberedTokens,
        proofReference: 'vid-1',
        notes: null,
        winnerMemberId: 'm1',
        winnerShareIndex: 0,
        eligibleShareKeys: const ['m1#0'],
        redoOfDrawId: null,
        invalidatedAt: null,
        invalidatedReason: null,
        finalizedAt: null,
        recordedAt: now,
      ),
    );

    final usecase = GenerateMonthlyStatement(
      statementsRepository: statementsRepo,
      monthlyDuesRepository: duesRepo,
      paymentsRepository: paymentsRepo,
      monthlyCollectionRepository: collectionRepo,
      drawRecordsRepository: drawRepo,
      drawWitnessRepository: witnessRepo,
      membersRepository: membersRepo,
      payoutRepository: payoutRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    await expectLater(
      usecase(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        now: now,
      ),
      throwsA(isA<FormatException>()),
    );

    await payoutRepo.upsertPayoutRecord(
      PayoutRecord(
        shomitiId: 'active',
        month: month,
        drawId: 'draw_1',
        ruleSetVersionId: 'rsv_1',
        winnerMemberId: 'm1',
        winnerShareIndex: 0,
        amountBdt: 1000,
        proofReference: 'trx-1',
        markedPaidByMemberId: 'm1',
        paidAt: now,
        recordedAt: now,
      ),
    );

    await expectLater(
      usecase(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        now: now.add(const Duration(minutes: 1)),
      ),
      throwsA(isA<FormatException>()),
    );

    await witnessRepo.upsertApproval(
      DrawWitnessApproval(
        drawId: 'draw_1',
        witnessMemberId: 'w1',
        ruleSetVersionId: 'rsv_1',
        note: null,
        approvedAt: now,
      ),
    );
    await witnessRepo.upsertApproval(
      DrawWitnessApproval(
        drawId: 'draw_1',
        witnessMemberId: 'w2',
        ruleSetVersionId: 'rsv_1',
        note: null,
        approvedAt: now.add(const Duration(seconds: 1)),
      ),
    );

    await drawRepo.upsert(
      DrawRecord(
        id: 'draw_1',
        shomitiId: 'active',
        month: month,
        ruleSetVersionId: 'rsv_1',
        method: DrawMethod.numberedTokens,
        proofReference: 'vid-1',
        notes: null,
        winnerMemberId: 'm1',
        winnerShareIndex: 0,
        eligibleShareKeys: const ['m1#0'],
        redoOfDrawId: null,
        invalidatedAt: null,
        invalidatedReason: null,
        finalizedAt: now,
        recordedAt: now,
      ),
    );

    final statement = await usecase(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      now: now.add(const Duration(minutes: 2)),
    );
    expect(statement.totalDueBdt, 1000);
    expect(statement.totalCollectedBdt, 1000);
    expect(statement.shortfallBdt, 0);
    expect(statement.winnerLabel, contains('Member 1'));
    expect(statement.drawProofReference, 'vid-1');
    expect(statement.payoutProofReference, 'trx-1');

    final loaded = await statementsRepo.getStatement(
      shomitiId: 'active',
      month: month,
    );
    expect(loaded, isNotNull);

    final events = await auditRepo.watchLatest(limit: 10).first;
    expect(events.any((e) => e.action == 'statement_generated'), isTrue);
  });
}


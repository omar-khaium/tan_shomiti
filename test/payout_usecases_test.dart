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
import 'package:tan_shomiti/src/features/draw/domain/entities/draw_record.dart';
import 'package:tan_shomiti/src/features/draw/domain/value_objects/draw_method.dart';
import 'package:tan_shomiti/src/features/ledger/data/drift_ledger_repository.dart';
import 'package:tan_shomiti/src/features/ledger/domain/entities/ledger_entry.dart';
import 'package:tan_shomiti/src/features/ledger/domain/usecases/append_ledger_entry.dart';
import 'package:tan_shomiti/src/features/members/data/drift_roles_repository.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/governance_role.dart';
import 'package:tan_shomiti/src/features/payments/data/drift_payments_repository.dart';
import 'package:tan_shomiti/src/features/payments/domain/entities/payment.dart';
import 'package:tan_shomiti/src/features/payments/domain/value_objects/payment_method.dart';
import 'package:tan_shomiti/src/features/payout/data/drift_payout_repository.dart';
import 'package:tan_shomiti/src/features/payout/domain/entities/payout_approval_role.dart';
import 'package:tan_shomiti/src/features/payout/domain/entities/payout_collection_verification.dart';
import 'package:tan_shomiti/src/features/payout/domain/usecases/mark_payout_paid.dart';
import 'package:tan_shomiti/src/features/payout/domain/usecases/payout_exceptions.dart';
import 'package:tan_shomiti/src/features/payout/domain/usecases/record_payout_approval.dart';
import 'package:tan_shomiti/src/features/payout/domain/usecases/verify_monthly_collection.dart';

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

  test('VerifyMonthlyCollection blocks when shortfall exists', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final duesRepo = DriftMonthlyDuesRepository(db);
    final paymentsRepo = DriftPaymentsRepository(db);
    final collectionRepo = DriftMonthlyCollectionRepository(db);
    final payoutRepo = DriftPayoutRepository(db);
    final auditRepo = DriftAuditRepository(db);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 9);

    await duesRepo.replaceMonthlyDues(
      shomitiId: 'active',
      month: month,
      dues: [
        MonthlyDue(
          shomitiId: 'active',
          month: month,
          memberId: 'm1',
          shares: 1,
          shareValueBdt: 50,
          dueAmountBdt: 50,
          createdAt: now,
        ),
        MonthlyDue(
          shomitiId: 'active',
          month: month,
          memberId: 'm2',
          shares: 1,
          shareValueBdt: 50,
          dueAmountBdt: 50,
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
        amountBdt: 50,
        method: PaymentMethod.cash,
        reference: 'ref1',
        proofNote: null,
        recordedAt: now,
        confirmedAt: now,
        receiptNumber: null,
        receiptIssuedAt: null,
      ),
    );

    final usecase = VerifyMonthlyCollection(
      payoutRepository: payoutRepo,
      monthlyDuesRepository: duesRepo,
      paymentsRepository: paymentsRepo,
      monthlyCollectionRepository: collectionRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    await expectLater(
      usecase(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        verifiedByMemberId: 't1',
        now: now,
      ),
      throwsA(isA<PayoutValidationException>()),
    );

    await collectionRepo.upsertResolution(
      CollectionResolution(
        shomitiId: 'active',
        month: month,
        method: CollectionResolutionMethod.reserve,
        amountBdt: 50,
        note: 'covered',
        createdAt: now,
      ),
    );

    await usecase(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      verifiedByMemberId: 't1',
      now: now.add(const Duration(minutes: 1)),
    );

    final verification = await payoutRepo.getCollectionVerification(
      shomitiId: 'active',
      month: month,
    );
    expect(verification, isNotNull);

    final events = await auditRepo.watchLatest(limit: 10).first;
    expect(events.any((e) => e.action == 'payout_collection_verified'), isTrue);
  });

  test('RecordPayoutApproval enforces collection verified and distinct approvers', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final payoutRepo = DriftPayoutRepository(db);
    final rolesRepo = DriftRolesRepository(db);
    final auditRepo = DriftAuditRepository(db);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 9);

    final usecase = RecordPayoutApproval(
      payoutRepository: payoutRepo,
      rolesRepository: rolesRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    await expectLater(
      usecase(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        role: PayoutApprovalRole.treasurer,
        approverMemberId: 't1',
        now: now,
      ),
      throwsA(isA<PayoutValidationException>()),
    );

    await payoutRepo.upsertCollectionVerification(
      PayoutCollectionVerification(
        shomitiId: 'active',
        month: month,
        ruleSetVersionId: 'rsv_1',
        verifiedByMemberId: 't1',
        verifiedAt: now,
        note: null,
      ),
    );

    await rolesRepo.setRoleAssignment(
      shomitiId: 'active',
      role: GovernanceRole.treasurer,
      memberId: 't1',
      assignedAt: now,
    );
    await rolesRepo.setRoleAssignment(
      shomitiId: 'active',
      role: GovernanceRole.auditor,
      memberId: 'a1',
      assignedAt: now,
    );

    await expectLater(
      usecase(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        role: PayoutApprovalRole.treasurer,
        approverMemberId: 'x',
        now: now,
      ),
      throwsA(isA<PayoutValidationException>()),
    );

    await usecase(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      role: PayoutApprovalRole.treasurer,
      approverMemberId: 't1',
      now: now,
    );

    await expectLater(
      usecase(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        role: PayoutApprovalRole.auditor,
        approverMemberId: 't1',
        now: now.add(const Duration(minutes: 1)),
      ),
      throwsA(isA<PayoutValidationException>()),
    );

    await usecase(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      role: PayoutApprovalRole.auditor,
      approverMemberId: 'a1',
      now: now.add(const Duration(minutes: 2)),
    );

    final approvals = await payoutRepo.listApprovals(
      shomitiId: 'active',
      month: month,
    );
    expect(approvals.where((a) => a.role == PayoutApprovalRole.treasurer).length, 1);
    expect(approvals.where((a) => a.role == PayoutApprovalRole.auditor).length, 1);
  });

  test('MarkPayoutPaid requires finalized draw, approvals, and proof; writes ledger + audit', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final drawsRepo = DriftDrawRecordsRepository(db);
    final duesRepo = DriftMonthlyDuesRepository(db);
    final paymentsRepo = DriftPaymentsRepository(db);
    final collectionRepo = DriftMonthlyCollectionRepository(db);
    final payoutRepo = DriftPayoutRepository(db);
    final ledgerRepo = DriftLedgerRepository(db);
    final auditRepo = DriftAuditRepository(db);

    final appendLedger = AppendLedgerEntry(ledgerRepo);
    final appendAudit = AppendAuditEvent(auditRepo);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 9);

    await duesRepo.replaceMonthlyDues(
      shomitiId: 'active',
      month: month,
      dues: [
        MonthlyDue(
          shomitiId: 'active',
          month: month,
          memberId: 'm1',
          shares: 1,
          shareValueBdt: 100,
          dueAmountBdt: 100,
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
        amountBdt: 100,
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

    await drawsRepo.upsert(
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

    await payoutRepo.upsertCollectionVerification(
      PayoutCollectionVerification(
        shomitiId: 'active',
        month: month,
        ruleSetVersionId: 'rsv_1',
        verifiedByMemberId: 't1',
        verifiedAt: now,
        note: null,
      ),
    );

    final recordApproval = RecordPayoutApproval(
      payoutRepository: payoutRepo,
      rolesRepository: DriftRolesRepository(db),
      appendAuditEvent: appendAudit,
    );

    await recordApproval(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      role: PayoutApprovalRole.treasurer,
      approverMemberId: 't1',
      note: 'ok',
      now: now,
    );
    await recordApproval(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      role: PayoutApprovalRole.auditor,
      approverMemberId: 'a1',
      note: 'ok',
      now: now.add(const Duration(seconds: 1)),
    );

    final markPaid = MarkPayoutPaid(
      payoutRepository: payoutRepo,
      drawRecordsRepository: drawsRepo,
      monthlyDuesRepository: duesRepo,
      paymentsRepository: paymentsRepo,
      monthlyCollectionRepository: collectionRepo,
      appendLedgerEntry: appendLedger,
      appendAuditEvent: appendAudit,
    );

    await expectLater(
      markPaid(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        proofReference: 'trx-1',
        now: now.add(const Duration(minutes: 1)),
      ),
      throwsA(isA<PayoutValidationException>()),
    );

    await drawsRepo.upsert(
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

    await expectLater(
      markPaid(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        proofReference: ' ',
        now: now.add(const Duration(minutes: 2)),
      ),
      throwsA(isA<PayoutValidationException>()),
    );

    await markPaid(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      proofReference: 'trx-1',
      markedPaidByMemberId: 't1',
      now: now.add(const Duration(minutes: 3)),
    );

    final payout = await payoutRepo.getPayoutRecord(
      shomitiId: 'active',
      month: month,
    );
    expect(payout, isNotNull);
    expect(payout!.isPaid, isTrue);
    expect(payout.proofReference, 'trx-1');

    final ledger = await ledgerRepo.watchLatest(limit: 10).first;
    expect(ledger.any((e) => e.category == 'payout'), isTrue);
    final payoutEntry = ledger.firstWhere((e) => e.category == 'payout');
    expect(payoutEntry.direction, LedgerDirection.outgoing);
    expect(payoutEntry.amount.takaFloor, 100);

    final events = await auditRepo.watchLatest(limit: 20).first;
    expect(events.any((e) => e.action == 'payout_marked_paid'), isTrue);

    await expectLater(
      markPaid(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        proofReference: 'trx-2',
        now: now.add(const Duration(minutes: 4)),
      ),
      throwsA(isA<PayoutValidationException>()),
    );
  });
}

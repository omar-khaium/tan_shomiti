import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/audit/data/drift_audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/contributions/data/drift_monthly_dues_repository.dart';
import 'package:tan_shomiti/src/features/contributions/domain/entities/due_month.dart';
import 'package:tan_shomiti/src/features/contributions/domain/entities/monthly_due.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/draw/data/drift_draw_records_repository.dart';
import 'package:tan_shomiti/src/features/draw/domain/entities/draw_record.dart';
import 'package:tan_shomiti/src/features/draw/domain/usecases/compute_draw_eligibility.dart';
import 'package:tan_shomiti/src/features/draw/domain/usecases/draw_exceptions.dart';
import 'package:tan_shomiti/src/features/draw/domain/usecases/record_draw_result.dart';
import 'package:tan_shomiti/src/features/draw/domain/value_objects/draw_method.dart';
import 'package:tan_shomiti/src/features/members/data/drift_members_repository.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';
import 'package:tan_shomiti/src/features/payments/data/drift_payments_repository.dart';
import 'package:tan_shomiti/src/features/payments/domain/entities/payment.dart';
import 'package:tan_shomiti/src/features/payments/domain/usecases/compute_payment_compliance.dart';
import 'package:tan_shomiti/src/features/payments/domain/value_objects/payment_method.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_snapshot.dart';

void main() {
  RuleSetSnapshot rules({
    String paymentDeadline = '5th',
    int? gracePeriodDays = 0,
    int? lateFeeBdtPerDay = 50,
  }) {
    return RuleSetSnapshot(
      schemaVersion: 1,
      shomitiName: 'Test',
      startDate: DateTime(2026, 1, 1),
      groupType: GroupTypePolicy.closed,
      memberCount: 2,
      shareValueBdt: 1000,
      maxSharesPerPerson: 3,
      allowShareTransfers: false,
      cycleLengthMonths: 6,
      meetingSchedule: 'Monthly',
      paymentDeadline: paymentDeadline,
      payoutMethod: PayoutMethod.cash,
      groupChannel: null,
      missedPaymentPolicy: MissedPaymentPolicy.postponePayout,
      gracePeriodDays: gracePeriodDays,
      lateFeeBdtPerDay: lateFeeBdtPerDay,
      defaultConsecutiveMissedThreshold: 2,
      defaultTotalMissedThreshold: 3,
      feesEnabled: false,
      feeAmountBdt: null,
      feePayerModel: FeePayerModel.everyoneEqually,
      ruleChangeAfterStartRequiresUnanimous: true,
    );
  }

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

  test('ComputeDrawEligibility returns hasDuesForMonth=false when dues missing', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final usecase = ComputeDrawEligibility(
      monthlyDuesRepository: DriftMonthlyDuesRepository(db),
      membersRepository: DriftMembersRepository(db),
      paymentsRepository: DriftPaymentsRepository(db),
      drawRecordsRepository: DriftDrawRecordsRepository(db),
      computePaymentCompliance: const ComputePaymentCompliance(),
    );

    const month = BillingMonth(year: 2026, month: 2);
    final result = await usecase(
      shomitiId: 'active',
      month: month,
      rules: rules(),
    );

    expect(result.hasDuesForMonth, isFalse);
    expect(result.items, isEmpty);
  });

  test('ComputeDrawEligibility marks shares eligible when payment confirmed in time', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final membersRepo = DriftMembersRepository(db);
    final duesRepo = DriftMonthlyDuesRepository(db);
    final paymentsRepo = DriftPaymentsRepository(db);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 12);

    await membersRepo.upsert(
      Member(
        id: 'm_active_1',
        shomitiId: 'active',
        position: 1,
        fullName: 'Alice',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: null,
      ),
    );

    await duesRepo.upsertDueMonth(
      DueMonth(
        shomitiId: 'active',
        month: month,
        ruleSetVersionId: 'rsv_1',
        generatedAt: now,
      ),
    );

    await duesRepo.replaceMonthlyDues(
      shomitiId: 'active',
      month: month,
      dues: [
        MonthlyDue(
          shomitiId: 'active',
          month: month,
          memberId: 'm_active_1',
          shares: 2,
          shareValueBdt: 1000,
          dueAmountBdt: 2000,
          createdAt: now,
        ),
      ],
    );

    await paymentsRepo.upsertPayment(
      Payment(
        id: 'p1',
        shomitiId: 'active',
        month: month,
        memberId: 'm_active_1',
        amountBdt: 2000,
        method: PaymentMethod.cash,
        reference: 'cash',
        proofNote: null,
        recordedAt: now,
        confirmedAt: now,
        receiptNumber: null,
        receiptIssuedAt: null,
      ),
    );

    final usecase = ComputeDrawEligibility(
      monthlyDuesRepository: duesRepo,
      membersRepository: membersRepo,
      paymentsRepository: paymentsRepo,
      drawRecordsRepository: DriftDrawRecordsRepository(db),
      computePaymentCompliance: const ComputePaymentCompliance(),
    );

    final result = await usecase(
      shomitiId: 'active',
      month: month,
      rules: rules(),
    );

    expect(result.hasDuesForMonth, isTrue);
    expect(result.items.length, 2);
    expect(result.items.where((i) => i.isEligible).length, 2);
  });

  test('ComputeDrawEligibility marks shares ineligible when payment missing', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final membersRepo = DriftMembersRepository(db);
    final duesRepo = DriftMonthlyDuesRepository(db);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5);

    await membersRepo.upsert(
      Member(
        id: 'm_active_1',
        shomitiId: 'active',
        position: 1,
        fullName: 'Alice',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: null,
      ),
    );

    await duesRepo.upsertDueMonth(
      DueMonth(
        shomitiId: 'active',
        month: month,
        ruleSetVersionId: 'rsv_1',
        generatedAt: now,
      ),
    );

    await duesRepo.replaceMonthlyDues(
      shomitiId: 'active',
      month: month,
      dues: [
        MonthlyDue(
          shomitiId: 'active',
          month: month,
          memberId: 'm_active_1',
          shares: 1,
          shareValueBdt: 1000,
          dueAmountBdt: 1000,
          createdAt: now,
        ),
      ],
    );

    final usecase = ComputeDrawEligibility(
      monthlyDuesRepository: duesRepo,
      membersRepository: membersRepo,
      paymentsRepository: DriftPaymentsRepository(db),
      drawRecordsRepository: DriftDrawRecordsRepository(db),
      computePaymentCompliance: const ComputePaymentCompliance(),
    );

    final result = await usecase(
      shomitiId: 'active',
      month: month,
      rules: rules(),
    );

    expect(result.items.single.isEligible, isFalse);
    expect(result.items.single.reason, 'Payment not confirmed');
  });

  test('ComputeDrawEligibility marks shares ineligible when payment late', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final membersRepo = DriftMembersRepository(db);
    final duesRepo = DriftMonthlyDuesRepository(db);
    final paymentsRepo = DriftPaymentsRepository(db);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 10);

    await membersRepo.upsert(
      Member(
        id: 'm_active_1',
        shomitiId: 'active',
        position: 1,
        fullName: 'Alice',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: null,
      ),
    );

    await duesRepo.upsertDueMonth(
      DueMonth(
        shomitiId: 'active',
        month: month,
        ruleSetVersionId: 'rsv_1',
        generatedAt: now,
      ),
    );

    await duesRepo.replaceMonthlyDues(
      shomitiId: 'active',
      month: month,
      dues: [
        MonthlyDue(
          shomitiId: 'active',
          month: month,
          memberId: 'm_active_1',
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
        memberId: 'm_active_1',
        amountBdt: 1000,
        method: PaymentMethod.cash,
        reference: 'cash',
        proofNote: null,
        recordedAt: now,
        confirmedAt: now,
        receiptNumber: null,
        receiptIssuedAt: null,
      ),
    );

    final usecase = ComputeDrawEligibility(
      monthlyDuesRepository: duesRepo,
      membersRepository: membersRepo,
      paymentsRepository: paymentsRepo,
      drawRecordsRepository: DriftDrawRecordsRepository(db),
      computePaymentCompliance: const ComputePaymentCompliance(),
    );

    final result = await usecase(
      shomitiId: 'active',
      month: month,
      rules: rules(gracePeriodDays: 0),
    );

    expect(result.items.single.isEligible, isFalse);
    expect(result.items.single.reason, 'Late (outside grace)');
  });

  test('ComputeDrawEligibility excludes a winner share from eligibility', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final membersRepo = DriftMembersRepository(db);
    final duesRepo = DriftMonthlyDuesRepository(db);
    final paymentsRepo = DriftPaymentsRepository(db);
    final drawsRepo = DriftDrawRecordsRepository(db);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 10);

    await membersRepo.upsert(
      Member(
        id: 'm_active_1',
        shomitiId: 'active',
        position: 1,
        fullName: 'Alice',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: null,
      ),
    );

    await duesRepo.upsertDueMonth(
      DueMonth(
        shomitiId: 'active',
        month: month,
        ruleSetVersionId: 'rsv_1',
        generatedAt: now,
      ),
    );

    await duesRepo.replaceMonthlyDues(
      shomitiId: 'active',
      month: month,
      dues: [
        MonthlyDue(
          shomitiId: 'active',
          month: month,
          memberId: 'm_active_1',
          shares: 2,
          shareValueBdt: 1000,
          dueAmountBdt: 2000,
          createdAt: now,
        ),
      ],
    );

    await paymentsRepo.upsertPayment(
      Payment(
        id: 'p1',
        shomitiId: 'active',
        month: month,
        memberId: 'm_active_1',
        amountBdt: 2000,
        method: PaymentMethod.cash,
        reference: 'cash',
        proofNote: null,
        recordedAt: now,
        confirmedAt: now,
        receiptNumber: null,
        receiptIssuedAt: null,
      ),
    );

    await drawsRepo.upsert(
      DrawRecord(
        id: 'draw_1',
        shomitiId: 'active',
        month: const BillingMonth(year: 2026, month: 1),
        ruleSetVersionId: 'rsv_1',
        method: DrawMethod.physicalSlips,
        proofReference: 'vid-1',
        notes: null,
        winnerMemberId: 'm_active_1',
        winnerShareIndex: 1,
        eligibleShareKeys: const ['m_active_1#1', 'm_active_1#2'],
        recordedAt: now,
      ),
    );

    final usecase = ComputeDrawEligibility(
      monthlyDuesRepository: duesRepo,
      membersRepository: membersRepo,
      paymentsRepository: paymentsRepo,
      drawRecordsRepository: drawsRepo,
      computePaymentCompliance: const ComputePaymentCompliance(),
    );

    final result = await usecase(
      shomitiId: 'active',
      month: month,
      rules: rules(),
    );

    final byShareKey = {for (final i in result.items) i.shareKey: i};
    expect(byShareKey['m_active_1#1']!.isEligible, isFalse);
    expect(byShareKey['m_active_1#1']!.reason, 'Already won');
    expect(byShareKey['m_active_1#2']!.isEligible, isTrue);
  });

  test('RecordDrawResult validates eligible list and winner selection', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final drawsRepo = DriftDrawRecordsRepository(db);
    final auditRepo = DriftAuditRepository(db);
    final usecase = RecordDrawResult(
      drawRecordsRepository: drawsRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    const month = BillingMonth(year: 2026, month: 2);

    expect(
      () => usecase(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        method: DrawMethod.physicalSlips,
        proofReference: 'vid',
        notes: null,
        winnerMemberId: 'm_active_1',
        winnerShareIndex: 1,
        eligibleShareKeys: const [],
        now: DateTime.utc(2026, 2, 5),
      ),
      throwsA(isA<DrawRecordingException>()),
    );

    expect(
      () => usecase(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        method: DrawMethod.physicalSlips,
        proofReference: 'vid',
        notes: null,
        winnerMemberId: 'm_active_1',
        winnerShareIndex: 1,
        eligibleShareKeys: const ['m_active_1#2'],
        now: DateTime.utc(2026, 2, 5),
      ),
      throwsA(isA<DrawRecordingException>()),
    );
  });

  test('RecordDrawResult persists record and appends audit event', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final drawsRepo = DriftDrawRecordsRepository(db);
    final auditRepo = DriftAuditRepository(db);
    final usecase = RecordDrawResult(
      drawRecordsRepository: drawsRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 9);

    final record = await usecase(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      method: DrawMethod.numberedTokens,
      proofReference: 'vid-123',
      notes: 'ok',
      winnerMemberId: 'm_active_1',
      winnerShareIndex: 2,
      eligibleShareKeys: const ['m_active_1#1', 'm_active_1#2'],
      now: now,
    );

    final loaded = await drawsRepo.getForMonth(shomitiId: 'active', month: month);
    expect(loaded, isNotNull);
    expect(loaded!.winnerShareKey, record.winnerShareKey);
    expect(loaded.eligibleShareKeys.length, 2);

    final events = await auditRepo.watchLatest(limit: 10).first;
    expect(events.any((e) => e.action == 'draw_recorded'), isTrue);
  });

  test('RecordDrawResult prevents recording twice for same month', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final drawsRepo = DriftDrawRecordsRepository(db);
    final auditRepo = DriftAuditRepository(db);
    final usecase = RecordDrawResult(
      drawRecordsRepository: drawsRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 9);

    await usecase(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      method: DrawMethod.physicalSlips,
      proofReference: 'vid-123',
      notes: null,
      winnerMemberId: 'm_active_1',
      winnerShareIndex: 1,
      eligibleShareKeys: const ['m_active_1#1'],
      now: now,
    );

    expect(
      () => usecase(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        method: DrawMethod.physicalSlips,
        proofReference: 'vid-999',
        notes: null,
        winnerMemberId: 'm_active_1',
        winnerShareIndex: 1,
        eligibleShareKeys: const ['m_active_1#1'],
        now: now.add(const Duration(minutes: 1)),
      ),
      throwsA(isA<DrawRecordingException>()),
    );
  });
}

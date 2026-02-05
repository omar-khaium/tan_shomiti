import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/defaults/domain/entities/default_enforcement_step.dart';
import 'package:tan_shomiti/src/features/defaults/domain/repositories/defaults_repository.dart';
import 'package:tan_shomiti/src/features/defaults/domain/usecases/compute_defaults_dashboard.dart';
import 'package:tan_shomiti/src/features/defaults/domain/usecases/defaults_exceptions.dart';
import 'package:tan_shomiti/src/features/defaults/domain/usecases/record_default_enforcement_step.dart';
import 'package:tan_shomiti/src/features/ledger/domain/entities/ledger_entry.dart';
import 'package:tan_shomiti/src/features/ledger/domain/repositories/ledger_repository.dart';
import 'package:tan_shomiti/src/features/ledger/domain/usecases/append_ledger_entry.dart';
import 'package:tan_shomiti/src/features/risk_controls/domain/entities/guarantor.dart';
import 'package:tan_shomiti/src/features/risk_controls/domain/entities/security_deposit.dart';
import 'package:tan_shomiti/src/features/risk_controls/domain/repositories/risk_controls_repository.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_snapshot.dart';

void main() {
  RuleSetSnapshot rules({
    int consecutiveThreshold = 2,
    int totalThreshold = 3,
  }) {
    return RuleSetSnapshot(
      schemaVersion: 1,
      shomitiName: 'Test',
      startDate: DateTime(2026, 1, 1),
      groupType: GroupTypePolicy.closed,
      memberCount: 3,
      shareValueBdt: 1000,
      maxSharesPerPerson: 1,
      allowShareTransfers: false,
      cycleLengthMonths: 3,
      meetingSchedule: 'Monthly',
      paymentDeadline: '5th',
      payoutMethod: PayoutMethod.cash,
      groupChannel: null,
      missedPaymentPolicy: MissedPaymentPolicy.postponePayout,
      gracePeriodDays: 0,
      lateFeeBdtPerDay: 50,
      defaultConsecutiveMissedThreshold: consecutiveThreshold,
      defaultTotalMissedThreshold: totalThreshold,
      feesEnabled: false,
      feeAmountBdt: null,
      feePayerModel: FeePayerModel.everyoneEqually,
      ruleChangeAfterStartRequiresUnanimous: true,
    );
  }

  test('ComputeDefaultsDashboard computes status, episodeKey, and nextStep', () async {
    final repo = _FakeDefaultsRepository(
      dues: const [
        // Member A: all paid.
        MemberDuePaymentRow(
          memberId: 'a',
          memberName: 'A',
          monthKey: '2026-01',
          dueAmountBdt: 1000,
          hasPayment: true,
        ),
        MemberDuePaymentRow(
          memberId: 'a',
          memberName: 'A',
          monthKey: '2026-02',
          dueAmountBdt: 1000,
          hasPayment: true,
        ),
        // Member B: missed latest month (at risk).
        MemberDuePaymentRow(
          memberId: 'b',
          memberName: 'B',
          monthKey: '2026-01',
          dueAmountBdt: 1000,
          hasPayment: true,
        ),
        MemberDuePaymentRow(
          memberId: 'b',
          memberName: 'B',
          monthKey: '2026-02',
          dueAmountBdt: 1000,
          hasPayment: false,
        ),
        // Member C: 2 consecutive missed (in default).
        MemberDuePaymentRow(
          memberId: 'c',
          memberName: 'C',
          monthKey: '2026-01',
          dueAmountBdt: 1000,
          hasPayment: false,
        ),
        MemberDuePaymentRow(
          memberId: 'c',
          memberName: 'C',
          monthKey: '2026-02',
          dueAmountBdt: 1000,
          hasPayment: false,
        ),
      ],
      steps: [
        DefaultEnforcementStep(
          id: 1,
          shomitiId: 's',
          memberId: 'c',
          episodeKey: '2026-01',
          type: DefaultEnforcementStepType.reminder,
          recordedAt: DateTime(2026, 2, 10),
          ruleSetVersionId: 'rsv',
        ),
      ],
    );

    final usecase = ComputeDefaultsDashboard(repo);
    final summaries = await usecase(shomitiId: 's', ruleSet: rules());

    final byMember = {for (final s in summaries) s.memberId: s};

    expect(byMember['a']!.status.name, 'clear');
    expect(byMember['a']!.episodeKey, isNull);
    expect(byMember['a']!.nextStep, isNull);

    expect(byMember['b']!.status.name, 'atRisk');
    expect(byMember['b']!.episodeKey, '2026-02');
    expect(byMember['b']!.nextStep, DefaultEnforcementStepType.reminder);

    expect(byMember['c']!.status.name, 'inDefault');
    expect(byMember['c']!.episodeKey, '2026-01');
    expect(byMember['c']!.nextStep, DefaultEnforcementStepType.notice);
  });

  test('RecordDefaultEnforcementStep enforces order and books ledger on apply', () async {
    final defaultsRepo = _FakeDefaultsRepository(
      dues: const [
        MemberDuePaymentRow(
          memberId: 'm1',
          memberName: 'Member 1',
          monthKey: '2026-01',
          dueAmountBdt: 1000,
          hasPayment: false,
        ),
        MemberDuePaymentRow(
          memberId: 'm1',
          memberName: 'Member 1',
          monthKey: '2026-02',
          dueAmountBdt: 1000,
          hasPayment: false,
        ),
      ],
    );
    final riskRepo = _FakeRiskControlsRepository();
    final auditRepo = _FakeAuditRepository();
    final ledgerRepo = _FakeLedgerRepository();

    final compute = ComputeDefaultsDashboard(defaultsRepo);
    final usecase = RecordDefaultEnforcementStep(
      defaultsRepository: defaultsRepo,
      riskControlsRepository: riskRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
      appendLedgerEntry: AppendLedgerEntry(ledgerRepo),
      computeDefaultsDashboard: compute,
    );

    final ruleSet = rules(consecutiveThreshold: 2, totalThreshold: 3);

    await expectLater(
      usecase(
        shomitiId: 's',
        ruleSetVersionId: 'rsv',
        ruleSet: ruleSet,
        memberId: 'm1',
        episodeKey: '2026-01',
        stepType: DefaultEnforcementStepType.notice,
        now: DateTime(2026, 2, 10),
      ),
      throwsA(isA<DefaultsValidationException>()),
    );

    await usecase(
      shomitiId: 's',
      ruleSetVersionId: 'rsv',
      ruleSet: ruleSet,
      memberId: 'm1',
      episodeKey: '2026-01',
      stepType: DefaultEnforcementStepType.reminder,
      now: DateTime(2026, 2, 10),
    );

    await usecase(
      shomitiId: 's',
      ruleSetVersionId: 'rsv',
      ruleSet: ruleSet,
      memberId: 'm1',
      episodeKey: '2026-01',
      stepType: DefaultEnforcementStepType.notice,
      now: DateTime(2026, 2, 11),
    );

    await expectLater(
      usecase(
        shomitiId: 's',
        ruleSetVersionId: 'rsv',
        ruleSet: ruleSet,
        memberId: 'm1',
        episodeKey: '2026-01',
        stepType: DefaultEnforcementStepType.guarantorOrDeposit,
        now: DateTime(2026, 2, 12),
      ),
      throwsA(isA<DefaultsValidationException>()),
    );

    riskRepo.setGuarantor(
      Guarantor(
        shomitiId: 's',
        memberId: 'm1',
        name: 'Guarantor',
        phone: '01',
        relationship: null,
        proofRef: null,
        recordedAt: DateTime(2026, 1, 1),
        updatedAt: null,
      ),
    );

    await usecase(
      shomitiId: 's',
      ruleSetVersionId: 'rsv',
      ruleSet: ruleSet,
      memberId: 'm1',
      episodeKey: '2026-01',
      stepType: DefaultEnforcementStepType.guarantorOrDeposit,
      now: DateTime(2026, 2, 13),
    );

    expect(defaultsRepo.addedSteps, hasLength(3));
    expect(auditRepo.appended.map((e) => e.action), contains('default_reminder_recorded'));
    expect(ledgerRepo.appended, hasLength(1));
    expect(ledgerRepo.appended.single.category, 'default_cover');
    expect(ledgerRepo.appended.single.amount.takaFloor, 2000);
  });
}

class _FakeDefaultsRepository implements DefaultsRepository {
  _FakeDefaultsRepository({
    List<MemberDuePaymentRow> dues = const [],
    List<DefaultEnforcementStep> steps = const [],
  }) : _dues = List.of(dues),
       _steps = List.of(steps);

  final List<MemberDuePaymentRow> _dues;
  final List<DefaultEnforcementStep> _steps;

  final List<NewDefaultEnforcementStep> addedSteps = [];

  @override
  Future<List<MemberDuePaymentRow>> listMemberDuePayments({
    required String shomitiId,
  }) async {
    return List.of(_dues);
  }

  @override
  Future<List<DefaultEnforcementStep>> listEnforcementSteps({
    required String shomitiId,
  }) async {
    return List.of(_steps);
  }

  @override
  Future<void> addEnforcementStep(NewDefaultEnforcementStep step) async {
    addedSteps.add(step);
    _steps.add(
      DefaultEnforcementStep(
        id: _steps.length + 1,
        shomitiId: step.shomitiId,
        memberId: step.memberId,
        episodeKey: step.episodeKey,
        type: step.type,
        recordedAt: step.recordedAt,
        ruleSetVersionId: step.ruleSetVersionId,
        note: step.note,
        amountBdt: step.amountBdt,
      ),
    );
  }
}

class _FakeRiskControlsRepository implements RiskControlsRepository {
  Guarantor? _guarantor;
  SecurityDeposit? _deposit;

  void setGuarantor(Guarantor? guarantor) => _guarantor = guarantor;

  void setDeposit(SecurityDeposit? deposit) => _deposit = deposit;

  @override
  Future<Guarantor?> getGuarantor({
    required String shomitiId,
    required String memberId,
  }) async {
    return _guarantor;
  }

  @override
  Future<SecurityDeposit?> getSecurityDeposit({
    required String shomitiId,
    required String memberId,
  }) async {
    return _deposit;
  }

  @override
  Future<List<Guarantor>> listGuarantors({required String shomitiId}) async {
    return _guarantor == null ? const [] : [_guarantor!];
  }

  @override
  Future<List<SecurityDeposit>> listSecurityDeposits({
    required String shomitiId,
  }) async {
    return _deposit == null ? const [] : [_deposit!];
  }

  @override
  Future<void> upsertGuarantor(Guarantor guarantor) async {
    _guarantor = guarantor;
  }

  @override
  Future<void> upsertSecurityDeposit(SecurityDeposit deposit) async {
    _deposit = deposit;
  }

  @override
  Future<void> markSecurityDepositReturned({
    required String shomitiId,
    required String memberId,
    required DateTime returnedAt,
    String? proofRef,
  }) async {}
}

class _FakeAuditRepository implements AuditRepository {
  final appended = <NewAuditEvent>[];

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) {
    return const Stream.empty();
  }

  @override
  Future<void> append(NewAuditEvent event) async {
    appended.add(event);
  }
}

class _FakeLedgerRepository implements LedgerRepository {
  final appended = <NewLedgerEntry>[];

  @override
  Stream<List<LedgerEntry>> watchLatest({int limit = 100}) {
    return const Stream.empty();
  }

  @override
  Future<void> append(NewLedgerEntry entry) async {
    appended.add(entry);
  }
}

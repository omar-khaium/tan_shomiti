import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/risk_controls/domain/entities/guarantor.dart';
import 'package:tan_shomiti/src/features/risk_controls/domain/entities/security_deposit.dart';
import 'package:tan_shomiti/src/features/risk_controls/domain/repositories/risk_controls_repository.dart';
import 'package:tan_shomiti/src/features/risk_controls/domain/usecases/check_risk_controls_complete.dart';
import 'package:tan_shomiti/src/features/risk_controls/domain/usecases/record_guarantor.dart';
import 'package:tan_shomiti/src/features/risk_controls/domain/usecases/record_security_deposit.dart';
import 'package:tan_shomiti/src/features/risk_controls/domain/usecases/risk_controls_exceptions.dart';

class _FakeRiskControlsRepository implements RiskControlsRepository {
  Guarantor? guarantor;
  SecurityDeposit? deposit;

  @override
  Future<Guarantor?> getGuarantor({
    required String shomitiId,
    required String memberId,
  }) async {
    return guarantor;
  }

  @override
  Future<SecurityDeposit?> getSecurityDeposit({
    required String shomitiId,
    required String memberId,
  }) async {
    return deposit;
  }

  @override
  Future<List<Guarantor>> listGuarantors({required String shomitiId}) async {
    return guarantor == null ? const [] : [guarantor!];
  }

  @override
  Future<List<SecurityDeposit>> listSecurityDeposits({
    required String shomitiId,
  }) async {
    return deposit == null ? const [] : [deposit!];
  }

  @override
  Future<void> upsertGuarantor(Guarantor guarantor) async {
    this.guarantor = guarantor;
  }

  @override
  Future<void> upsertSecurityDeposit(SecurityDeposit deposit) async {
    this.deposit = deposit;
  }

  @override
  Future<void> markSecurityDepositReturned({
    required String shomitiId,
    required String memberId,
    required DateTime returnedAt,
    String? proofRef,
  }) async {
    final existing = deposit;
    if (existing == null) return;
    deposit = SecurityDeposit(
      shomitiId: existing.shomitiId,
      memberId: existing.memberId,
      amountBdt: existing.amountBdt,
      heldBy: existing.heldBy,
      proofRef: proofRef ?? existing.proofRef,
      recordedAt: existing.recordedAt,
      returnedAt: returnedAt,
      updatedAt: returnedAt,
    );
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
  test('RecordSecurityDeposit validates amount and heldBy', () async {
    final repo = _FakeRiskControlsRepository();
    final record = RecordSecurityDeposit(
      riskControlsRepository: repo,
      appendAuditEvent: AppendAuditEvent(_FakeAuditRepository()),
    );

    await expectLater(
      () => record(
        shomitiId: 's1',
        memberId: 'm1',
        amountBdt: 0,
        heldBy: 'Treasurer',
      ),
      throwsA(isA<RiskControlValidationException>()),
    );

    await expectLater(
      () => record(
        shomitiId: 's1',
        memberId: 'm1',
        amountBdt: 100,
        heldBy: '   ',
      ),
      throwsA(isA<RiskControlValidationException>()),
    );
  });

  test('RecordGuarantor validates required fields', () async {
    final repo = _FakeRiskControlsRepository();
    final record = RecordGuarantor(
      riskControlsRepository: repo,
      appendAuditEvent: AppendAuditEvent(_FakeAuditRepository()),
    );

    await expectLater(
      () => record(
        shomitiId: 's1',
        memberId: 'm1',
        name: '',
        phone: '01700000000',
      ),
      throwsA(isA<RiskControlValidationException>()),
    );

    await expectLater(
      () => record(shomitiId: 's1', memberId: 'm1', name: 'A', phone: '   '),
      throwsA(isA<RiskControlValidationException>()),
    );
  });

  test('CheckRiskControlsComplete throws when required and missing', () {
    const check = CheckRiskControlsComplete();

    expect(
      () => check(
        memberIds: const ['m1', 'm2'],
        guarantors: const [],
        deposits: const [],
        required: true,
      ),
      throwsA(
        isA<RiskControlMissingException>().having(
          (e) => e.missingMemberIds,
          'missingMemberIds',
          ['m1', 'm2'],
        ),
      ),
    );
  });

  test('CheckRiskControlsComplete treats returned deposit as missing', () {
    const check = CheckRiskControlsComplete();
    final now = DateTime.utc(2026, 1, 1);

    expect(
      () => check(
        memberIds: const ['m1'],
        guarantors: const [],
        deposits: [
          SecurityDeposit(
            shomitiId: 's1',
            memberId: 'm1',
            amountBdt: 1000,
            heldBy: 'Treasurer',
            proofRef: null,
            recordedAt: now,
            returnedAt: now,
            updatedAt: now,
          ),
        ],
        required: true,
      ),
      throwsA(isA<RiskControlMissingException>()),
    );
  });

  test(
    'CheckRiskControlsComplete passes when guarantor or held deposit exists',
    () {
      const check = CheckRiskControlsComplete();
      final now = DateTime.utc(2026, 1, 1);

      check(
        memberIds: const ['m1', 'm2'],
        guarantors: [
          Guarantor(
            shomitiId: 's1',
            memberId: 'm1',
            name: 'G',
            phone: '01700000000',
            relationship: null,
            proofRef: null,
            recordedAt: now,
            updatedAt: now,
          ),
        ],
        deposits: [
          SecurityDeposit(
            shomitiId: 's1',
            memberId: 'm2',
            amountBdt: 1000,
            heldBy: 'Treasurer',
            proofRef: null,
            recordedAt: now,
            returnedAt: null,
            updatedAt: now,
          ),
        ],
        required: true,
      );
    },
  );
}

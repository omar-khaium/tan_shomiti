import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/audit/data/drift_audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/members/data/drift_members_repository.dart';
import 'package:tan_shomiti/src/features/members/data/drift_roles_repository.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/governance_role.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';
import 'package:tan_shomiti/src/features/statements/data/drift_statement_signoffs_repository.dart';
import 'package:tan_shomiti/src/features/statements/data/drift_statements_repository.dart';
import 'package:tan_shomiti/src/features/statements/domain/entities/monthly_statement.dart';
import 'package:tan_shomiti/src/features/statements/domain/entities/statement_signer_role.dart';
import 'package:tan_shomiti/src/features/statements/domain/entities/statement_signoff.dart';
import 'package:tan_shomiti/src/features/statements/domain/policies/statement_signoff_policy.dart';
import 'package:tan_shomiti/src/features/statements/domain/usecases/delete_statement_signoff.dart';
import 'package:tan_shomiti/src/features/statements/domain/usecases/record_statement_signoff.dart';
import 'package:tan_shomiti/src/features/statements/domain/usecases/statement_signoff_exceptions.dart';

void main() {
  Future<AppDatabase> seededDb({DateTime? now}) async {
    final db = AppDatabase.memory();
    final ts = now ?? DateTime.utc(2026, 2, 5);

    await db
        .into(db.shomitis)
        .insert(
          ShomitisCompanion.insert(
            id: 'active',
            name: 'Demo',
            startDate: ts,
            createdAt: ts,
            activeRuleSetVersionId: 'rsv_1',
          ),
        );

    await db
        .into(db.ruleSetVersions)
        .insert(
          RuleSetVersionsCompanion.insert(
            id: 'rsv_1',
            createdAt: ts,
            json: '{}',
          ),
        );

    return db;
  }

  MonthlyStatement statementFor(BillingMonth month, DateTime now) {
    return MonthlyStatement(
      shomitiId: 'active',
      month: month,
      ruleSetVersionId: 'rsv_1',
      generatedAt: now,
      totalDueBdt: 1000,
      totalCollectedBdt: 1000,
      coveredBdt: 0,
      shortfallBdt: 0,
      winnerLabel: 'Member 1',
      drawProofReference: 'vid-1',
      payoutProofReference: 'trx-1',
    );
  }

  Member member({
    required String id,
    required DateTime now,
    required bool isActive,
    required int position,
  }) {
    return Member(
      shomitiId: 'active',
      id: id,
      position: position,
      fullName: 'Member $id',
      phone: null,
      addressOrWorkplace: null,
      nidOrPassport: null,
      emergencyContactName: null,
      emergencyContactPhone: null,
      notes: null,
      isActive: isActive,
      createdAt: now,
      updatedAt: now,
    );
  }

  group('StatementSignoffPolicy', () {
    const policy = StatementSignoffPolicy();

    test('returns notSigned when empty', () {
      expect(policy.statusOf(const []), StatementSignoffStatus.notSigned);
    });

    test('returns partiallySigned when 1 witness', () {
      final signoffs = [
        StatementSignoff(
          shomitiId: 'active',
          month: const BillingMonth(year: 2026, month: 2),
          signerMemberId: 'w1',
          role: StatementSignerRole.witness,
          proofReference: 'proof',
          note: null,
          signedAt: DateTime.utc(2026, 2, 5, 10),
          createdAt: DateTime.utc(2026, 2, 5, 10),
        ),
      ];

      expect(policy.statusOf(signoffs), StatementSignoffStatus.partiallySigned);
    });

    test('returns signed when 2 distinct witnesses', () {
      final signoffs = [
        StatementSignoff(
          shomitiId: 'active',
          month: const BillingMonth(year: 2026, month: 2),
          signerMemberId: 'w1',
          role: StatementSignerRole.witness,
          proofReference: 'proof',
          note: null,
          signedAt: DateTime.utc(2026, 2, 5, 10),
          createdAt: DateTime.utc(2026, 2, 5, 10),
        ),
        StatementSignoff(
          shomitiId: 'active',
          month: const BillingMonth(year: 2026, month: 2),
          signerMemberId: 'w2',
          role: StatementSignerRole.witness,
          proofReference: 'proof2',
          note: null,
          signedAt: DateTime.utc(2026, 2, 5, 10, 1),
          createdAt: DateTime.utc(2026, 2, 5, 10, 1),
        ),
      ];

      expect(policy.statusOf(signoffs), StatementSignoffStatus.signed);
    });

    test('returns signed when auditor exists', () {
      final signoffs = [
        StatementSignoff(
          shomitiId: 'active',
          month: const BillingMonth(year: 2026, month: 2),
          signerMemberId: 'a1',
          role: StatementSignerRole.auditor,
          proofReference: 'audit-proof',
          note: null,
          signedAt: DateTime.utc(2026, 2, 5, 10),
          createdAt: DateTime.utc(2026, 2, 5, 10),
        ),
      ];

      expect(policy.statusOf(signoffs), StatementSignoffStatus.signed);
    });
  });

  group('RecordStatementSignoff', () {
    test('requires statement exists', () async {
      final db = await seededDb();
      addTearDown(db.close);

      final usecase = RecordStatementSignoff(
        statementsRepository: DriftStatementsRepository(db),
        signoffsRepository: DriftStatementSignoffsRepository(db),
        membersRepository: DriftMembersRepository(db),
        rolesRepository: DriftRolesRepository(db),
        appendAuditEvent: AppendAuditEvent(DriftAuditRepository(db)),
      );

      await expectLater(
        usecase(
          shomitiId: 'active',
          month: const BillingMonth(year: 2026, month: 2),
          signerMemberId: 'w1',
          role: StatementSignerRole.witness,
          proofReference: 'proof',
          note: null,
          now: DateTime.utc(2026, 2, 5, 10),
        ),
        throwsA(isA<StatementSignoffException>()),
      );
    });

    test('rejects inactive member', () async {
      final db = await seededDb();
      addTearDown(db.close);

      final statementsRepo = DriftStatementsRepository(db);
      final signoffsRepo = DriftStatementSignoffsRepository(db);
      final membersRepo = DriftMembersRepository(db);
      final rolesRepo = DriftRolesRepository(db);
      final auditRepo = DriftAuditRepository(db);

      const month = BillingMonth(year: 2026, month: 2);
      final now = DateTime.utc(2026, 2, 5, 10);

      await statementsRepo.upsertStatement(statementFor(month, now));
      await membersRepo.upsert(
        member(id: 'w1', now: now, isActive: false, position: 1),
      );

      final usecase = RecordStatementSignoff(
        statementsRepository: statementsRepo,
        signoffsRepository: signoffsRepo,
        membersRepository: membersRepo,
        rolesRepository: rolesRepo,
        appendAuditEvent: AppendAuditEvent(auditRepo),
      );

      await expectLater(
        usecase(
          shomitiId: 'active',
          month: month,
          signerMemberId: 'w1',
          role: StatementSignerRole.witness,
          proofReference: 'proof',
          note: null,
          now: now,
        ),
        throwsA(isA<StatementSignoffException>()),
      );
    });

    test('prevents duplicate sign-off by same member', () async {
      final db = await seededDb();
      addTearDown(db.close);

      final statementsRepo = DriftStatementsRepository(db);
      final signoffsRepo = DriftStatementSignoffsRepository(db);
      final membersRepo = DriftMembersRepository(db);
      final rolesRepo = DriftRolesRepository(db);
      final auditRepo = DriftAuditRepository(db);

      const month = BillingMonth(year: 2026, month: 2);
      final now = DateTime.utc(2026, 2, 5, 10);

      await statementsRepo.upsertStatement(statementFor(month, now));
      await membersRepo.upsert(
        member(id: 'w1', now: now, isActive: true, position: 1),
      );

      final usecase = RecordStatementSignoff(
        statementsRepository: statementsRepo,
        signoffsRepository: signoffsRepo,
        membersRepository: membersRepo,
        rolesRepository: rolesRepo,
        appendAuditEvent: AppendAuditEvent(auditRepo),
      );

      await usecase(
        shomitiId: 'active',
        month: month,
        signerMemberId: 'w1',
        role: StatementSignerRole.witness,
        proofReference: 'proof',
        note: null,
        now: now,
      );

      await expectLater(
        usecase(
          shomitiId: 'active',
          month: month,
          signerMemberId: 'w1',
          role: StatementSignerRole.witness,
          proofReference: 'proof2',
          note: null,
          now: now.add(const Duration(minutes: 1)),
        ),
        throwsA(isA<StatementSignoffException>()),
      );
    });

    test('auditor sign-off requires assigned auditor', () async {
      final db = await seededDb();
      addTearDown(db.close);

      final statementsRepo = DriftStatementsRepository(db);
      final signoffsRepo = DriftStatementSignoffsRepository(db);
      final membersRepo = DriftMembersRepository(db);
      final rolesRepo = DriftRolesRepository(db);
      final auditRepo = DriftAuditRepository(db);

      const month = BillingMonth(year: 2026, month: 2);
      final now = DateTime.utc(2026, 2, 5, 10);

      await statementsRepo.upsertStatement(statementFor(month, now));
      await membersRepo.upsert(
        member(id: 'a1', now: now, isActive: true, position: 1),
      );
      await membersRepo.upsert(
        member(id: 'a2', now: now, isActive: true, position: 2),
      );

      await rolesRepo.setRoleAssignment(
        shomitiId: 'active',
        role: GovernanceRole.auditor,
        memberId: 'a2',
        assignedAt: now,
      );

      final usecase = RecordStatementSignoff(
        statementsRepository: statementsRepo,
        signoffsRepository: signoffsRepo,
        membersRepository: membersRepo,
        rolesRepository: rolesRepo,
        appendAuditEvent: AppendAuditEvent(auditRepo),
      );

      await expectLater(
        usecase(
          shomitiId: 'active',
          month: month,
          signerMemberId: 'a1',
          role: StatementSignerRole.auditor,
          proofReference: 'audit-proof',
          note: null,
          now: now,
        ),
        throwsA(isA<StatementSignoffException>()),
      );
    });
  });

  test('DeleteStatementSignoff appends audit event', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final signoffsRepo = DriftStatementSignoffsRepository(db);
    final auditRepo = DriftAuditRepository(db);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 10);

    await signoffsRepo.upsert(
      StatementSignoff(
        shomitiId: 'active',
        month: month,
        signerMemberId: 'w1',
        role: StatementSignerRole.witness,
        proofReference: 'proof',
        note: null,
        signedAt: now,
        createdAt: now,
      ),
    );

    final usecase = DeleteStatementSignoff(
      repository: signoffsRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    await usecase(
      shomitiId: 'active',
      month: month,
      signerMemberId: 'w1',
      now: now.add(const Duration(minutes: 1)),
    );

    final events = await auditRepo.watchLatest().first;
    expect(events.first.action, 'statement_signoff_removed');
  });
}

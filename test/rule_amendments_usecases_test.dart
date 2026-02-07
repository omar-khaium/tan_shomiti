import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/audit/data/drift_audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/members/data/drift_member_consents_repository.dart';
import 'package:tan_shomiti/src/features/members/data/drift_members_repository.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member_consent.dart';
import 'package:tan_shomiti/src/features/rules/data/drift_rule_amendments_repository.dart';
import 'package:tan_shomiti/src/features/rules/data/drift_rules_repository.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_amendment.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_snapshot.dart';
import 'package:tan_shomiti/src/features/rules/domain/usecases/apply_rule_amendment.dart';
import 'package:tan_shomiti/src/features/rules/domain/usecases/propose_rule_amendment.dart';
import 'package:tan_shomiti/src/features/rules/domain/usecases/record_rule_amendment_consent.dart';
import 'package:tan_shomiti/src/features/rules/domain/usecases/rule_amendment_exceptions.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/data/drift_shomiti_repository.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/domain/entities/shomiti.dart';

void main() {
  Future<AppDatabase> seededDb({DateTime? now}) async {
    final db = AppDatabase.memory();
    final ts = now ?? DateTime.utc(2026, 2, 5);

    await db
        .into(db.shomitis)
        .insert(
          ShomitisCompanion.insert(
            id: activeShomitiId,
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
            json: jsonEncode(
              RuleSetSnapshot(
                schemaVersion: 1,
                shomitiName: 'Demo',
                startDate: ts,
                groupType: GroupTypePolicy.closed,
                memberCount: 2,
                shareValueBdt: 1000,
                maxSharesPerPerson: 1,
                allowShareTransfers: false,
                cycleLengthMonths: 2,
                meetingSchedule: 'Monthly',
                paymentDeadline: '5th',
                payoutMethod: PayoutMethod.cash,
                groupChannel: null,
                missedPaymentPolicy: MissedPaymentPolicy.postponePayout,
                gracePeriodDays: 3,
                lateFeeBdtPerDay: 0,
                defaultConsecutiveMissedThreshold: 2,
                defaultTotalMissedThreshold: 3,
                feesEnabled: false,
                feeAmountBdt: null,
                feePayerModel: FeePayerModel.everyoneEqually,
                ruleChangeAfterStartRequiresUnanimous: true,
              ).toJson(),
            ),
          ),
        );

    return db;
  }

  RuleSetSnapshot snapshot(DateTime now, {int? shareValueBdt}) {
    return RuleSetSnapshot(
      schemaVersion: 1,
      shomitiName: 'Demo',
      startDate: now,
      groupType: GroupTypePolicy.closed,
      memberCount: 2,
      shareValueBdt: shareValueBdt ?? 1000,
      maxSharesPerPerson: 1,
      allowShareTransfers: false,
      cycleLengthMonths: 2,
      meetingSchedule: 'Monthly',
      paymentDeadline: '5th',
      payoutMethod: PayoutMethod.cash,
      groupChannel: null,
      missedPaymentPolicy: MissedPaymentPolicy.postponePayout,
      gracePeriodDays: 3,
      lateFeeBdtPerDay: 0,
      defaultConsecutiveMissedThreshold: 2,
      defaultTotalMissedThreshold: 3,
      feesEnabled: false,
      feeAmountBdt: null,
      feePayerModel: FeePayerModel.everyoneEqually,
      ruleChangeAfterStartRequiresUnanimous: true,
    );
  }

  Member member(String id, int position, DateTime now) {
    return Member(
      shomitiId: activeShomitiId,
      id: id,
      position: position,
      fullName: 'Member $position',
      phone: null,
      addressOrWorkplace: null,
      nidOrPassport: null,
      emergencyContactName: null,
      emergencyContactPhone: null,
      notes: null,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
  }

  test('ProposeRuleAmendment rejects empty note', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final usecase = ProposeRuleAmendment(
      shomitiRepository: DriftShomitiRepository(db),
      rulesRepository: DriftRulesRepository(db),
      amendmentsRepository: DriftRuleAmendmentsRepository(db),
      membersRepository: DriftMembersRepository(db),
      appendAuditEvent: AppendAuditEvent(DriftAuditRepository(db)),
    );

    await expectLater(
      usecase(
        shomitiId: activeShomitiId,
        proposedSnapshot: snapshot(DateTime.utc(2026, 2, 5)),
        note: '  ',
        sharedReference: null,
        now: DateTime.utc(2026, 2, 5, 10),
      ),
      throwsA(isA<RuleAmendmentException>()),
    );
  });

  test('ProposeRuleAmendment creates pending amendment and ruleset', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final membersRepo = DriftMembersRepository(db);
    final now = DateTime.utc(2026, 2, 5, 10);
    await membersRepo.upsert(member('m1', 1, now));
    await membersRepo.upsert(member('m2', 2, now));

    final rulesRepo = DriftRulesRepository(db);
    final amendmentsRepo = DriftRuleAmendmentsRepository(db);
    final auditRepo = DriftAuditRepository(db);

    final usecase = ProposeRuleAmendment(
      shomitiRepository: DriftShomitiRepository(db),
      rulesRepository: rulesRepo,
      amendmentsRepository: amendmentsRepo,
      membersRepository: membersRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    final amendmentId = await usecase(
      shomitiId: activeShomitiId,
      proposedSnapshot: snapshot(now, shareValueBdt: 1200),
      note: 'Increase share value',
      sharedReference: null,
      now: now,
    );

    final pending = await amendmentsRepo
        .watchPending(shomitiId: activeShomitiId)
        .first;
    expect(pending, isNotNull);
    expect(pending!.id, amendmentId);
    expect(pending.note, 'Increase share value');
    expect(pending.proposedRuleSetVersionId, isNotEmpty);

    final proposedVersion = await rulesRepo.getById(
      pending.proposedRuleSetVersionId,
    );
    expect(proposedVersion, isNotNull);
    expect(proposedVersion!.snapshot.shareValueBdt, 1200);

    final events = await auditRepo.watchLatest().first;
    expect(events.first.action, 'rule_change_proposed');
  });

  test(
    'RecordRuleAmendmentConsent upserts consent and appends audit event',
    () async {
      final db = await seededDb();
      addTearDown(db.close);

      final auditRepo = DriftAuditRepository(db);
      final consentsRepo = DriftMemberConsentsRepository(db);

      const ruleSetVersionId = 'rsv_test';
      final now = DateTime.utc(2026, 2, 5, 10);

      final usecase = RecordRuleAmendmentConsent(
        consentsRepository: consentsRepo,
        appendAuditEvent: AppendAuditEvent(auditRepo),
      );

      await usecase(
        shomitiId: activeShomitiId,
        memberId: 'm1',
        ruleSetVersionId: ruleSetVersionId,
        proofType: ConsentProofType.chatReference,
        proofReference: 'msg-1',
        now: now,
      );

      final consents = await consentsRepo
          .watchConsents(
            shomitiId: activeShomitiId,
            ruleSetVersionId: ruleSetVersionId,
          )
          .first;
      expect(consents, hasLength(1));

      final events = await auditRepo.watchLatest().first;
      expect(events.first.action, 'rule_change_consent_recorded');
    },
  );

  test(
    'ApplyRuleAmendment requires unanimous consent and shared reference',
    () async {
      final db = await seededDb();
      addTearDown(db.close);

      final now = DateTime.utc(2026, 2, 5, 10);
      final membersRepo = DriftMembersRepository(db);
      await membersRepo.upsert(member('m1', 1, now));
      await membersRepo.upsert(member('m2', 2, now));

      final rulesRepo = DriftRulesRepository(db);
      final amendmentsRepo = DriftRuleAmendmentsRepository(db);
      final consentsRepo = DriftMemberConsentsRepository(db);
      final auditRepo = DriftAuditRepository(db);
      final shomitiRepo = DriftShomitiRepository(db);

      final propose = ProposeRuleAmendment(
        shomitiRepository: shomitiRepo,
        rulesRepository: rulesRepo,
        amendmentsRepository: amendmentsRepo,
        membersRepository: membersRepo,
        appendAuditEvent: AppendAuditEvent(auditRepo),
      );

      final amendmentId = await propose(
        shomitiId: activeShomitiId,
        proposedSnapshot: snapshot(now, shareValueBdt: 1300),
        note: 'Increase share value',
        sharedReference: null,
        now: now,
      );

      final pending = await amendmentsRepo
          .watchPending(shomitiId: activeShomitiId)
          .first;
      expect(pending, isNotNull);
      final proposedRuleSetVersionId = pending!.proposedRuleSetVersionId;

      final recordConsent = RecordRuleAmendmentConsent(
        consentsRepository: consentsRepo,
        appendAuditEvent: AppendAuditEvent(auditRepo),
      );

      await recordConsent(
        shomitiId: activeShomitiId,
        memberId: 'm1',
        ruleSetVersionId: proposedRuleSetVersionId,
        proofType: ConsentProofType.signature,
        proofReference: 'sig-1',
        now: now,
      );

      final apply = ApplyRuleAmendment(
        shomitiRepository: shomitiRepo,
        amendmentsRepository: amendmentsRepo,
        membersRepository: membersRepo,
        memberConsentsRepository: consentsRepo,
        appendAuditEvent: AppendAuditEvent(auditRepo),
      );

      await expectLater(
        apply(
          shomitiId: activeShomitiId,
          amendmentId: amendmentId,
          now: now.add(const Duration(minutes: 1)),
        ),
        throwsA(isA<RuleAmendmentException>()),
      );

      // Add missing consent and required shared ref, then apply succeeds.
      await recordConsent(
        shomitiId: activeShomitiId,
        memberId: 'm2',
        ruleSetVersionId: proposedRuleSetVersionId,
        proofType: ConsentProofType.signature,
        proofReference: 'sig-2',
        now: now,
      );

      await amendmentsRepo.upsert(
        RuleAmendment(
          id: pending.id,
          shomitiId: pending.shomitiId,
          baseRuleSetVersionId: pending.baseRuleSetVersionId,
          proposedRuleSetVersionId: pending.proposedRuleSetVersionId,
          status: pending.status,
          note: pending.note,
          sharedReference: 'chat-msg-99',
          createdAt: pending.createdAt,
          appliedAt: pending.appliedAt,
        ),
      );

      await apply(
        shomitiId: activeShomitiId,
        amendmentId: amendmentId,
        now: now.add(const Duration(minutes: 2)),
      );

      final updated = await shomitiRepo.getActive();
      expect(updated!.activeRuleSetVersionId, proposedRuleSetVersionId);
    },
  );
}

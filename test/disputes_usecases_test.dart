import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/audit/data/drift_audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/disputes/data/drift_disputes_repository.dart';
import 'package:tan_shomiti/src/features/disputes/domain/entities/dispute_step.dart';
import 'package:tan_shomiti/src/features/disputes/domain/usecases/complete_dispute_step.dart';
import 'package:tan_shomiti/src/features/disputes/domain/usecases/create_dispute.dart';
import 'package:tan_shomiti/src/features/disputes/domain/usecases/disputes_exceptions.dart';
import 'package:tan_shomiti/src/features/disputes/domain/usecases/reopen_dispute.dart';
import 'package:tan_shomiti/src/features/disputes/domain/usecases/resolve_dispute.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/domain/entities/shomiti.dart';

void main() {
  Future<AppDatabase> seededDb() async {
    final db = AppDatabase.memory();
    final now = DateTime.utc(2026, 2, 7, 12);
    await db.into(db.shomitis).insert(
          ShomitisCompanion.insert(
            id: activeShomitiId,
            name: 'Demo',
            startDate: now,
            createdAt: now,
            activeRuleSetVersionId: 'rsv_1',
          ),
        );
    return db;
  }

  test('CreateDispute validates inputs and appends audit event', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final disputesRepo = DriftDisputesRepository(db);
    final auditRepo = DriftAuditRepository(db);

    final usecase = CreateDispute(
      repository: disputesRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    await expectLater(
      usecase(
        shomitiId: activeShomitiId,
        title: '  ',
        description: 'ok',
        relatedMonthKey: null,
        involvedMembersText: null,
        evidenceReferences: const [],
        now: DateTime.utc(2026, 2, 7, 12, 1),
      ),
      throwsA(isA<DisputesValidationException>()),
    );

    final id = await usecase(
      shomitiId: activeShomitiId,
      title: 'Dispute title',
      description: 'Factual description',
      relatedMonthKey: '2026-02',
      involvedMembersText: null,
      evidenceReferences: const [' msg-1 ', ''],
      now: DateTime.utc(2026, 2, 7, 12, 2),
    );
    expect(id, isNotEmpty);

    final events = await auditRepo.watchLatest().first;
    expect(events.first.action, 'dispute_created');
  });

  test('Dispute steps must be completed in order; resolve requires steps 1–3', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final disputesRepo = DriftDisputesRepository(db);
    final auditRepo = DriftAuditRepository(db);
    final appendAudit = AppendAuditEvent(auditRepo);

    final create = CreateDispute(
      repository: disputesRepo,
      appendAuditEvent: appendAudit,
    );
    final completeStep = CompleteDisputeStep(
      disputesRepository: disputesRepo,
      appendAuditEvent: appendAudit,
    );
    final resolve = ResolveDispute(
      disputesRepository: disputesRepo,
      appendAuditEvent: appendAudit,
    );

    final now = DateTime.utc(2026, 2, 7, 13);
    final id = await create(
      shomitiId: activeShomitiId,
      title: 'D1',
      description: 'Desc',
      relatedMonthKey: null,
      involvedMembersText: null,
      evidenceReferences: const [],
      now: now,
    );

    await expectLater(
      completeStep(
        shomitiId: activeShomitiId,
        disputeId: id,
        step: DisputeStep.meetingDiscussion,
        note: 'Meeting held',
        proofReference: null,
        now: now,
      ),
      throwsA(isA<DisputesValidationException>()),
    );

    await completeStep(
      shomitiId: activeShomitiId,
      disputeId: id,
      step: DisputeStep.privateDiscussion,
      note: 'Private discussion done',
      proofReference: 'msg-2',
      now: now,
    );

    await expectLater(
      resolve(
        shomitiId: activeShomitiId,
        disputeId: id,
        outcomeNote: 'Outcome',
        proofReference: null,
        now: now,
      ),
      throwsA(isA<DisputesValidationException>()),
    );

    await completeStep(
      shomitiId: activeShomitiId,
      disputeId: id,
      step: DisputeStep.meetingDiscussion,
      note: 'Meeting + witnesses',
      proofReference: null,
      now: now,
    );
    await completeStep(
      shomitiId: activeShomitiId,
      disputeId: id,
      step: DisputeStep.mediation,
      note: 'Mediation attempt',
      proofReference: null,
      now: now,
    );

    await resolve(
      shomitiId: activeShomitiId,
      disputeId: id,
      outcomeNote: 'Resolved outcome',
      proofReference: 'doc-1',
      now: now,
    );

    final dispute = await disputesRepo.getById(
      shomitiId: activeShomitiId,
      disputeId: id,
    );
    expect(dispute, isNotNull);
    expect(dispute!.status.name, 'resolved');
  });

  test('Reopen clears final outcome completion and appends audit event', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final disputesRepo = DriftDisputesRepository(db);
    final auditRepo = DriftAuditRepository(db);
    final appendAudit = AppendAuditEvent(auditRepo);

    final create = CreateDispute(
      repository: disputesRepo,
      appendAuditEvent: appendAudit,
    );
    final completeStep = CompleteDisputeStep(
      disputesRepository: disputesRepo,
      appendAuditEvent: appendAudit,
    );
    final resolve = ResolveDispute(
      disputesRepository: disputesRepo,
      appendAuditEvent: appendAudit,
    );
    final reopen = ReopenDispute(
      disputesRepository: disputesRepo,
      appendAuditEvent: appendAudit,
    );

    final now = DateTime.utc(2026, 2, 7, 14);
    final id = await create(
      shomitiId: activeShomitiId,
      title: 'D1',
      description: 'Desc',
      relatedMonthKey: null,
      involvedMembersText: null,
      evidenceReferences: const [],
      now: now,
    );

    await completeStep(
      shomitiId: activeShomitiId,
      disputeId: id,
      step: DisputeStep.privateDiscussion,
      note: 'S1',
      proofReference: null,
      now: now,
    );
    await completeStep(
      shomitiId: activeShomitiId,
      disputeId: id,
      step: DisputeStep.meetingDiscussion,
      note: 'S2',
      proofReference: null,
      now: now,
    );
    await completeStep(
      shomitiId: activeShomitiId,
      disputeId: id,
      step: DisputeStep.mediation,
      note: 'S3',
      proofReference: null,
      now: now,
    );
    await resolve(
      shomitiId: activeShomitiId,
      disputeId: id,
      outcomeNote: 'Outcome',
      proofReference: null,
      now: now,
    );

    await reopen(
      shomitiId: activeShomitiId,
      disputeId: id,
      note: 'New info found',
      now: now,
    );

    final dispute = await disputesRepo.getById(
      shomitiId: activeShomitiId,
      disputeId: id,
    );
    expect(dispute, isNotNull);
    expect(dispute!.status.name, 'open');
    expect(dispute.isStepCompleted(DisputeStep.finalOutcome), isFalse);

    final events = await auditRepo.watchLatest().first;
    expect(events.first.action, 'dispute_reopened');
  });
}


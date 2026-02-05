import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/audit/data/drift_audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/draw/data/drift_draw_records_repository.dart';
import 'package:tan_shomiti/src/features/draw/data/drift_draw_witness_repository.dart';
import 'package:tan_shomiti/src/features/draw/domain/entities/draw_record.dart';
import 'package:tan_shomiti/src/features/draw/domain/usecases/draw_exceptions.dart';
import 'package:tan_shomiti/src/features/draw/domain/usecases/finalize_draw_record.dart';
import 'package:tan_shomiti/src/features/draw/domain/usecases/invalidate_draw_record.dart';
import 'package:tan_shomiti/src/features/draw/domain/usecases/record_draw_result.dart';
import 'package:tan_shomiti/src/features/draw/domain/usecases/record_draw_witness_approval.dart';
import 'package:tan_shomiti/src/features/draw/domain/usecases/witness_exceptions.dart';
import 'package:tan_shomiti/src/features/draw/domain/value_objects/draw_method.dart';

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

  test('FinalizeDrawRecord requires at least 2 witness approvals', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final drawsRepo = DriftDrawRecordsRepository(db);
    final witnessRepo = DriftDrawWitnessRepository(db);
    final auditRepo = DriftAuditRepository(db);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 9);

    await drawsRepo.upsert(
      DrawRecord(
        id: 'draw_1',
        shomitiId: 'active',
        month: month,
        ruleSetVersionId: 'rsv_1',
        method: DrawMethod.physicalSlips,
        proofReference: 'vid-1',
        notes: null,
        winnerMemberId: 'm1',
        winnerShareIndex: 1,
        eligibleShareKeys: const ['m1#1'],
        redoOfDrawId: null,
        invalidatedAt: null,
        invalidatedReason: null,
        finalizedAt: null,
        recordedAt: now,
      ),
    );

    final recordWitness = RecordDrawWitnessApproval(
      repository: witnessRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );
    await recordWitness(
      drawId: 'draw_1',
      witnessMemberId: 'w1',
      ruleSetVersionId: 'rsv_1',
      note: null,
      now: now,
    );

    final finalize = FinalizeDrawRecord(
      drawRecordsRepository: drawsRepo,
      drawWitnessRepository: witnessRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    expect(
      () => finalize(drawId: 'draw_1', now: now.add(const Duration(minutes: 1))),
      throwsA(isA<DrawWitnessException>()),
    );
  });

  test('RecordDrawWitnessApproval blocks duplicate witness sign-off', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final witnessRepo = DriftDrawWitnessRepository(db);
    final auditRepo = DriftAuditRepository(db);
    final usecase = RecordDrawWitnessApproval(
      repository: witnessRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    final now = DateTime.utc(2026, 2, 5, 9);

    await usecase(
      drawId: 'draw_1',
      witnessMemberId: 'w1',
      ruleSetVersionId: 'rsv_1',
      note: 'ok',
      now: now,
    );

    expect(
      () => usecase(
        drawId: 'draw_1',
        witnessMemberId: 'w1',
        ruleSetVersionId: 'rsv_1',
        note: 'again',
        now: now.add(const Duration(minutes: 1)),
      ),
      throwsA(isA<DrawWitnessException>()),
    );
  });

  test('Witness approvals allow finalization and persist finalizedAt', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final drawsRepo = DriftDrawRecordsRepository(db);
    final witnessRepo = DriftDrawWitnessRepository(db);
    final auditRepo = DriftAuditRepository(db);

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 9);

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
        winnerShareIndex: 1,
        eligibleShareKeys: const ['m1#1'],
        redoOfDrawId: null,
        invalidatedAt: null,
        invalidatedReason: null,
        finalizedAt: null,
        recordedAt: now,
      ),
    );

    final recordWitness = RecordDrawWitnessApproval(
      repository: witnessRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );
    await recordWitness(
      drawId: 'draw_1',
      witnessMemberId: 'w1',
      ruleSetVersionId: 'rsv_1',
      note: null,
      now: now,
    );
    await recordWitness(
      drawId: 'draw_1',
      witnessMemberId: 'w2',
      ruleSetVersionId: 'rsv_1',
      note: 'present',
      now: now.add(const Duration(seconds: 5)),
    );

    final finalize = FinalizeDrawRecord(
      drawRecordsRepository: drawsRepo,
      drawWitnessRepository: witnessRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );
    await finalize(drawId: 'draw_1', now: now.add(const Duration(minutes: 1)));

    final loaded = await drawsRepo.getById(id: 'draw_1');
    expect(loaded, isNotNull);
    expect(loaded!.finalizedAt, isNotNull);

    final events = await auditRepo.watchLatest(limit: 20).first;
    expect(events.any((e) => e.action == 'draw_finalized'), isTrue);
  });

  test('Redo flow: invalidate original then record new draw linked by redoOfDrawId', () async {
    final db = await seededDb();
    addTearDown(db.close);

    final drawsRepo = DriftDrawRecordsRepository(db);
    final auditRepo = DriftAuditRepository(db);

    final recordDraw = RecordDrawResult(
      drawRecordsRepository: drawsRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );
    final invalidate = InvalidateDrawRecord(
      drawRecordsRepository: drawsRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5, 9);

    final original = await recordDraw(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      method: DrawMethod.physicalSlips,
      proofReference: 'vid-1',
      notes: null,
      winnerMemberId: 'm1',
      winnerShareIndex: 1,
      eligibleShareKeys: const ['m1#1'],
      now: now,
    );

    expect(
      () => recordDraw(
        shomitiId: 'active',
        ruleSetVersionId: 'rsv_1',
        month: month,
        method: DrawMethod.physicalSlips,
        proofReference: 'vid-2',
        notes: null,
        winnerMemberId: 'm1',
        winnerShareIndex: 1,
        eligibleShareKeys: const ['m1#1'],
        redoOfDrawId: original.id,
        now: now.add(const Duration(minutes: 1)),
      ),
      throwsA(isA<DrawRecordingException>()),
    );

    await invalidate(
      drawId: original.id,
      reason: 'Wrong witness',
      now: now.add(const Duration(minutes: 2)),
    );

    final replacement = await recordDraw(
      shomitiId: 'active',
      ruleSetVersionId: 'rsv_1',
      month: month,
      method: DrawMethod.physicalSlips,
      proofReference: 'vid-2',
      notes: 'redo ok',
      winnerMemberId: 'm1',
      winnerShareIndex: 1,
      eligibleShareKeys: const ['m1#1'],
      redoOfDrawId: original.id,
      now: now.add(const Duration(minutes: 3)),
    );

    expect(replacement.redoOfDrawId, original.id);
    final loadedOriginal = await drawsRepo.getById(id: original.id);
    expect(loadedOriginal!.isInvalidated, isTrue);

    final events = await auditRepo.watchLatest(limit: 50).first;
    expect(events.any((e) => e.action == 'draw_invalidated'), isTrue);
    expect(events.any((e) => e.action == 'draw_recorded'), isTrue);
  });
}


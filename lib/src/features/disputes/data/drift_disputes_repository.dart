import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/dispute.dart';
import '../domain/entities/dispute_step.dart';
import '../domain/repositories/disputes_repository.dart';

final class DriftDisputesRepository implements DisputesRepository {
  DriftDisputesRepository(this._db, {Random? random})
      : _random = random ?? Random();

  final AppDatabase _db;
  final Random _random;

  @override
  Stream<List<Dispute>> watchAll({required String shomitiId}) {
    final disputesQuery = (_db.select(_db.disputes)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();

    return disputesQuery.asyncMap((rows) async {
      if (rows.isEmpty) return const [];
      final ids = rows.map((r) => r.id).toList(growable: false);

      final completions = await (_db.select(_db.disputeStepCompletions)
            ..where(
              (t) =>
                  t.shomitiId.equals(shomitiId) & t.disputeId.isIn(ids),
            ))
          .get();

      final byDisputeId = <String, List<DisputeStepCompletionRow>>{};
      for (final c in completions) {
        (byDisputeId[c.disputeId] ??= []).add(c);
      }

      return rows
          .map(
            (r) => _toDomain(
              row: r,
              completions: byDisputeId[r.id] ?? const [],
            ),
          )
          .toList(growable: false);
    });
  }

  @override
  Future<Dispute?> getById({
    required String shomitiId,
    required String disputeId,
  }) async {
    final row = await (_db.select(_db.disputes)
          ..where(
            (t) => t.shomitiId.equals(shomitiId) & t.id.equals(disputeId),
          ))
        .getSingleOrNull();
    if (row == null) return null;

    final completions = await (_db.select(_db.disputeStepCompletions)
          ..where(
            (t) => t.shomitiId.equals(shomitiId) & t.disputeId.equals(disputeId),
          ))
        .get();

    return _toDomain(row: row, completions: completions);
  }

  @override
  Future<String> createDispute({
    required String shomitiId,
    required String title,
    required String description,
    required DateTime now,
    required String? relatedMonthKey,
    required String? involvedMembersText,
    required List<String> evidenceReferences,
  }) async {
    final id = _newDisputeId(now);
    final evidence = evidenceReferences
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);

    await _db.into(_db.disputes).insert(
          DisputeRow(
            id: id,
            shomitiId: shomitiId,
            title: title.trim(),
            description: description.trim(),
            relatedMonthKey: relatedMonthKey?.trim().isEmpty == true
                ? null
                : relatedMonthKey?.trim(),
            involvedMembersText: involvedMembersText?.trim().isEmpty == true
                ? null
                : involvedMembersText?.trim(),
            evidenceReferencesJson: jsonEncode(evidence),
            status: 'open',
            createdAt: now,
            resolvedAt: null,
          ),
        );

    return id;
  }

  @override
  Future<void> completeStep({
    required String shomitiId,
    required String disputeId,
    required DisputeStep step,
    required String note,
    required String? proofReference,
    required DateTime now,
  }) async {
    await _db.into(_db.disputeStepCompletions).insert(
          DisputeStepCompletionRow(
            id: 0,
            shomitiId: shomitiId,
            disputeId: disputeId,
            stepType: _stepType(step),
            note: note.trim(),
            proofReference: proofReference?.trim().isEmpty == true
                ? null
                : proofReference?.trim(),
            completedAt: now,
          ),
        );
  }

  @override
  Future<void> resolve({
    required String shomitiId,
    required String disputeId,
    required String outcomeNote,
    required String? proofReference,
    required DateTime now,
  }) async {
    await _db.transaction(() async {
      await completeStep(
        shomitiId: shomitiId,
        disputeId: disputeId,
        step: DisputeStep.finalOutcome,
        note: outcomeNote,
        proofReference: proofReference,
        now: now,
      );

      await (_db.update(_db.disputes)
            ..where(
              (t) => t.shomitiId.equals(shomitiId) & t.id.equals(disputeId),
            ))
          .write(
        DisputesCompanion(
          status: const Value('resolved'),
          resolvedAt: Value(now),
        ),
      );
    });
  }

  @override
  Future<void> reopen({
    required String shomitiId,
    required String disputeId,
    required String note,
    required DateTime now,
  }) async {
    await _db.transaction(() async {
      await (_db.delete(_db.disputeStepCompletions)
            ..where(
              (t) =>
                  t.shomitiId.equals(shomitiId) &
                  t.disputeId.equals(disputeId) &
                  t.stepType.equals(_stepType(DisputeStep.finalOutcome)),
            ))
          .go();

      await (_db.update(_db.disputes)
            ..where(
              (t) => t.shomitiId.equals(shomitiId) & t.id.equals(disputeId),
            ))
          .write(
        const DisputesCompanion(
          status: Value('open'),
          resolvedAt: Value(null),
        ),
      );
    });
  }

  Dispute _toDomain({
    required DisputeRow row,
    required List<DisputeStepCompletionRow> completions,
  }) {
    final status = row.status == 'resolved'
        ? DisputeStatus.resolved
        : DisputeStatus.open;

    final evidence = _decodeEvidence(row.evidenceReferencesJson);

    final completionsByType = {
      for (final c in completions) c.stepType: c,
    };

    final steps = <DisputeStepRecord>[
      for (final step in DisputeStep.values)
        () {
          final c = completionsByType[_stepType(step)];
          return DisputeStepRecord(
            step: step,
            note: c?.note,
            proofReference: c?.proofReference,
            completedAt: c?.completedAt,
          );
        }(),
    ];

    return Dispute(
      id: row.id,
      shomitiId: row.shomitiId,
      title: row.title,
      description: row.description,
      createdAt: row.createdAt,
      status: status,
      steps: List.unmodifiable(steps),
      relatedMonthKey: row.relatedMonthKey,
      involvedMembersText: row.involvedMembersText,
      evidenceReferences: List.unmodifiable(evidence),
      resolvedAt: row.resolvedAt,
    );
  }

  static List<String> _decodeEvidence(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is! List) return const [];
      return decoded.whereType<String>().toList(growable: false);
    } catch (_) {
      return const [];
    }
  }

  static String _stepType(DisputeStep step) => switch (step) {
        DisputeStep.privateDiscussion => 'private_discussion',
        DisputeStep.meetingDiscussion => 'meeting_discussion',
        DisputeStep.mediation => 'mediation',
        DisputeStep.finalOutcome => 'final_outcome',
      };

  String _newDisputeId(DateTime now) {
    final ts = now.microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36).padLeft(7, '0');
    return 'dsp_${ts}_$rand';
  }
}


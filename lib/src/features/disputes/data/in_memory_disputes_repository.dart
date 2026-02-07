import 'dart:async';
import 'dart:math';

import '../domain/entities/dispute.dart';
import '../domain/entities/dispute_step.dart';
import '../domain/repositories/disputes_repository.dart';

final class InMemoryDisputesRepository implements DisputesRepository {
  InMemoryDisputesRepository({Random? random}) : _random = random ?? Random();

  final Random _random;
  final _controller = StreamController<List<Dispute>>.broadcast();
  final Map<String, Dispute> _byId = {};

  @override
  Stream<List<Dispute>> watchAll({required String shomitiId}) async* {
    yield _currentFor(shomitiId);
    yield* _controller.stream.map((_) => _currentFor(shomitiId));
  }

  List<Dispute> _currentFor(String shomitiId) {
    final disputes = _byId.values
        .where((d) => d.shomitiId == shomitiId)
        .toList(growable: false);
    disputes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return disputes;
  }

  @override
  Future<Dispute?> getById({
    required String shomitiId,
    required String disputeId,
  }) async {
    final dispute = _byId[disputeId];
    if (dispute == null || dispute.shomitiId != shomitiId) return null;
    return dispute;
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
    _byId[id] = Dispute(
      id: id,
      shomitiId: shomitiId,
      title: title.trim(),
      description: description.trim(),
      createdAt: now,
      status: DisputeStatus.open,
      steps: List.unmodifiable([
        for (final s in DisputeStep.values)
          DisputeStepRecord(
            step: s,
            note: null,
            proofReference: null,
            completedAt: null,
          ),
      ]),
      relatedMonthKey: relatedMonthKey?.trim().isEmpty == true
          ? null
          : relatedMonthKey?.trim(),
      involvedMembersText: involvedMembersText?.trim().isEmpty == true
          ? null
          : involvedMembersText?.trim(),
      evidenceReferences: List.unmodifiable(
        evidenceReferences
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(growable: false),
      ),
      resolvedAt: null,
    );

    _controller.add(const []);
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
    final dispute = await getById(shomitiId: shomitiId, disputeId: disputeId);
    if (dispute == null) return;
    if (!dispute.canCompleteStep(step)) {
      throw StateError('Step cannot be completed out of order.');
    }
    final trimmed = note.trim();
    if (trimmed.isEmpty) throw StateError('Note is required.');

    final nextSteps = [
      for (final record in dispute.steps)
        if (record.step != step)
          record
        else
          record.copyWith(
            note: trimmed,
            proofReference: proofReference?.trim().isEmpty == true
                ? null
                : proofReference?.trim(),
            completedAt: now,
          ),
    ];

    _byId[disputeId] = dispute.copyWith(steps: List.unmodifiable(nextSteps));
    _controller.add(const []);
  }

  @override
  Future<void> resolve({
    required String shomitiId,
    required String disputeId,
    required String outcomeNote,
    required String? proofReference,
    required DateTime now,
  }) async {
    final dispute = await getById(shomitiId: shomitiId, disputeId: disputeId);
    if (dispute == null) return;
    if (!dispute.canResolve) throw StateError('Dispute is not ready to resolve.');
    final trimmed = outcomeNote.trim();
    if (trimmed.isEmpty) throw StateError('Outcome note is required.');

    final step = DisputeStep.finalOutcome;
    final nextSteps = [
      for (final record in dispute.steps)
        if (record.step != step)
          record
        else
          record.copyWith(
            note: trimmed,
            proofReference: proofReference?.trim().isEmpty == true
                ? null
                : proofReference?.trim(),
            completedAt: now,
          ),
    ];

    _byId[disputeId] = dispute.copyWith(
      status: DisputeStatus.resolved,
      steps: List.unmodifiable(nextSteps),
      resolvedAt: now,
    );
    _controller.add(const []);
  }

  @override
  Future<void> reopen({
    required String shomitiId,
    required String disputeId,
    required String note,
    required DateTime now,
  }) async {
    final dispute = await getById(shomitiId: shomitiId, disputeId: disputeId);
    if (dispute == null) return;
    if (dispute.status != DisputeStatus.resolved) return;
    if (note.trim().isEmpty) throw StateError('Reopen note is required.');

    _byId[disputeId] = dispute.copyWith(
      status: DisputeStatus.open,
      resolvedAt: null,
    );
    _controller.add(const []);
  }

  String _newDisputeId(DateTime now) {
    final ts = now.microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36).padLeft(7, '0');
    return 'dsp_${ts}_$rand';
  }
}


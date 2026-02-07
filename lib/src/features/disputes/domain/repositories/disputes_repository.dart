import '../entities/dispute.dart';
import '../entities/dispute_step.dart';

abstract interface class DisputesRepository {
  Stream<List<Dispute>> watchAll({required String shomitiId});

  Future<Dispute?> getById({
    required String shomitiId,
    required String disputeId,
  });

  Future<String> createDispute({
    required String shomitiId,
    required String title,
    required String description,
    required DateTime now,
    required String? relatedMonthKey,
    required String? involvedMembersText,
    required List<String> evidenceReferences,
  });

  Future<void> completeStep({
    required String shomitiId,
    required String disputeId,
    required DisputeStep step,
    required String note,
    required String? proofReference,
    required DateTime now,
  });

  Future<void> resolve({
    required String shomitiId,
    required String disputeId,
    required String outcomeNote,
    required String? proofReference,
    required DateTime now,
  });

  Future<void> reopen({
    required String shomitiId,
    required String disputeId,
    required String note,
    required DateTime now,
  });
}


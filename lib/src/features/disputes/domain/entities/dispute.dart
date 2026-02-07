import 'dispute_step.dart';

enum DisputeStatus {
  open,
  resolved,
}

final class Dispute {
  const Dispute({
    required this.id,
    required this.shomitiId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
    required this.steps,
    required this.relatedMonthKey,
    required this.involvedMembersText,
    required this.evidenceReferences,
    required this.resolvedAt,
  });

  final String id;
  final String shomitiId;
  final String title;
  final String description;
  final DateTime createdAt;
  final DisputeStatus status;
  final List<DisputeStepRecord> steps;
  final String? relatedMonthKey;
  final String? involvedMembersText;
  final List<String> evidenceReferences;
  final DateTime? resolvedAt;

  DisputeStep get currentStep {
    if (status == DisputeStatus.resolved) return DisputeStep.finalOutcome;

    for (final step in DisputeStep.values) {
      final record = stepRecord(step);
      if (record?.completedAt == null) return step;
    }
    return DisputeStep.finalOutcome;
  }

  DisputeStepRecord? stepRecord(DisputeStep step) {
    for (final r in steps) {
      if (r.step == step) return r;
    }
    return null;
  }

  bool isStepCompleted(DisputeStep step) =>
      stepRecord(step)?.completedAt != null;

  bool canCompleteStep(DisputeStep step) {
    if (status == DisputeStatus.resolved) return false;
    if (isStepCompleted(step)) return false;

    final previous = step.previous;
    if (previous == null) return true;
    return isStepCompleted(previous);
  }

  bool get canResolve {
    if (status == DisputeStatus.resolved) return false;
    return DisputeStep.privateDiscussion.through(DisputeStep.mediation).every(
      isStepCompleted,
    );
  }

  Dispute copyWith({
    String? title,
    String? description,
    DisputeStatus? status,
    List<DisputeStepRecord>? steps,
    String? relatedMonthKey,
    String? involvedMembersText,
    List<String>? evidenceReferences,
    DateTime? resolvedAt,
  }) {
    return Dispute(
      id: id,
      shomitiId: shomitiId,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      status: status ?? this.status,
      steps: steps ?? this.steps,
      relatedMonthKey: relatedMonthKey ?? this.relatedMonthKey,
      involvedMembersText: involvedMembersText ?? this.involvedMembersText,
      evidenceReferences: evidenceReferences ?? this.evidenceReferences,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }
}


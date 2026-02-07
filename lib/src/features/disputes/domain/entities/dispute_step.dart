enum DisputeStep {
  privateDiscussion,
  meetingDiscussion,
  mediation,
  finalOutcome,
}

extension DisputeStepX on DisputeStep {
  String get title => switch (this) {
        DisputeStep.privateDiscussion => 'Step 1 — Private discussion',
        DisputeStep.meetingDiscussion => 'Step 2 — Meeting + witnesses',
        DisputeStep.mediation => 'Step 3 — Mediation',
        DisputeStep.finalOutcome => 'Step 4 — Final outcome',
      };

  String get description => switch (this) {
        DisputeStep.privateDiscussion =>
          'Discuss privately with Coordinator + Treasurer.',
        DisputeStep.meetingDiscussion =>
          'Discuss in meeting with witnesses and ledger review.',
        DisputeStep.mediation => 'Mediation by agreed neutral member(s).',
        DisputeStep.finalOutcome =>
          'Record the outcome. If unresolved and amounts are significant, parties may seek formal/legal remedies under local law.',
      };

  DisputeStep? get previous => switch (this) {
        DisputeStep.privateDiscussion => null,
        DisputeStep.meetingDiscussion => DisputeStep.privateDiscussion,
        DisputeStep.mediation => DisputeStep.meetingDiscussion,
        DisputeStep.finalOutcome => DisputeStep.mediation,
      };

  List<DisputeStep> through(DisputeStep other) {
    final startIndex = DisputeStep.values.indexOf(this);
    final endIndex = DisputeStep.values.indexOf(other);
    if (startIndex > endIndex) return const [];
    return DisputeStep.values.sublist(startIndex, endIndex + 1);
  }
}

final class DisputeStepRecord {
  const DisputeStepRecord({
    required this.step,
    required this.note,
    required this.proofReference,
    required this.completedAt,
  });

  final DisputeStep step;
  final String? note;
  final String? proofReference;
  final DateTime? completedAt;

  DisputeStepRecord copyWith({
    String? note,
    String? proofReference,
    DateTime? completedAt,
  }) {
    return DisputeStepRecord(
      step: step,
      note: note ?? this.note,
      proofReference: proofReference ?? this.proofReference,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}


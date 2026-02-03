class AuditEvent {
  const AuditEvent({
    required this.id,
    required this.action,
    required this.occurredAt,
    this.message,
    this.actor,
  });

  final int id;
  final String action;
  final DateTime occurredAt;
  final String? message;
  final String? actor;
}

class NewAuditEvent {
  const NewAuditEvent({
    required this.action,
    required this.occurredAt,
    this.message,
    this.actor,
    this.metadataJson,
  });

  final String action;
  final DateTime occurredAt;
  final String? message;
  final String? actor;
  final String? metadataJson;
}


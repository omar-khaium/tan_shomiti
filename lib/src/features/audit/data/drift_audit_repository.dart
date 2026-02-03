import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/audit_event.dart';
import '../domain/repositories/audit_repository.dart';

class DriftAuditRepository implements AuditRepository {
  DriftAuditRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) {
    final query = _db.select(_db.auditEvents)
      ..orderBy([
        (t) => OrderingTerm.desc(t.occurredAt),
        (t) => OrderingTerm.desc(t.id),
      ])
      ..limit(limit);

    return query.watch().map(
          (rows) => rows.map(_mapRow).toList(growable: false),
        );
  }

  @override
  Future<void> append(NewAuditEvent event) {
    return _db.into(_db.auditEvents).insert(
          AuditEventsCompanion.insert(
            action: event.action,
            occurredAt: event.occurredAt,
            message: Value(event.message),
            actor: Value(event.actor),
            metadataJson: Value(event.metadataJson),
          ),
        );
  }

  static AuditEvent _mapRow(AuditEventRow row) {
    return AuditEvent(
      id: row.id,
      action: row.action,
      occurredAt: row.occurredAt,
      message: row.message,
      actor: row.actor,
    );
  }
}


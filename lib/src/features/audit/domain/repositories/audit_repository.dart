import '../entities/audit_event.dart';

abstract class AuditRepository {
  Stream<List<AuditEvent>> watchLatest({int limit = 50});

  Future<void> append(NewAuditEvent event);
}


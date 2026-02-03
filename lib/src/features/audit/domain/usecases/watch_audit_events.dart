import '../entities/audit_event.dart';
import '../repositories/audit_repository.dart';

class WatchAuditEvents {
  const WatchAuditEvents(this._repository);

  final AuditRepository _repository;

  Stream<List<AuditEvent>> call({int limit = 50}) =>
      _repository.watchLatest(limit: limit);
}


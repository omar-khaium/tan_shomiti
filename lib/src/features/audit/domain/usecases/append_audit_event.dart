import '../entities/audit_event.dart';
import '../repositories/audit_repository.dart';

class AppendAuditEvent {
  const AppendAuditEvent(this._repository);

  final AuditRepository _repository;

  Future<void> call(NewAuditEvent event) => _repository.append(event);
}


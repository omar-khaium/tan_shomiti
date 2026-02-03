import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../data/drift_audit_repository.dart';
import '../../domain/entities/audit_event.dart';
import '../../domain/repositories/audit_repository.dart';
import '../../domain/usecases/append_audit_event.dart';
import '../../domain/usecases/watch_audit_events.dart';

final auditRepositoryProvider = Provider<AuditRepository>((ref) {
  return DriftAuditRepository(ref.watch(appDatabaseProvider));
});

final watchAuditEventsProvider = Provider<WatchAuditEvents>((ref) {
  return WatchAuditEvents(ref.watch(auditRepositoryProvider));
});

final appendAuditEventProvider = Provider<AppendAuditEvent>((ref) {
  return AppendAuditEvent(ref.watch(auditRepositoryProvider));
});

final auditLogProvider = StreamProvider.autoDispose<List<AuditEvent>>((ref) {
  return ref.watch(watchAuditEventsProvider)();
});


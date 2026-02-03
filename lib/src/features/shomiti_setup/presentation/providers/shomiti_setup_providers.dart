import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../rules/presentation/providers/rules_providers.dart';
import '../../data/drift_shomiti_repository.dart';
import '../../domain/entities/shomiti.dart';
import '../../domain/repositories/shomiti_repository.dart';
import '../../domain/usecases/create_shomiti.dart';

final shomitiRepositoryProvider = Provider<ShomitiRepository>((ref) {
  return DriftShomitiRepository(ref.watch(appDatabaseProvider));
});

final activeShomitiProvider = StreamProvider<Shomiti?>((ref) {
  return ref.watch(shomitiRepositoryProvider).watchActive();
});

final createShomitiProvider = Provider<CreateShomiti>((ref) {
  return CreateShomiti(
    shomitiRepository: ref.watch(shomitiRepositoryProvider),
    rulesRepository: ref.watch(rulesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});


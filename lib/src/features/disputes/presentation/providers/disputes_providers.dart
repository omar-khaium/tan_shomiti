import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import '../../data/drift_disputes_repository.dart';
import '../../domain/entities/dispute.dart';
import '../../domain/repositories/disputes_repository.dart';
import '../../domain/usecases/complete_dispute_step.dart';
import '../../domain/usecases/create_dispute.dart';
import '../../domain/usecases/reopen_dispute.dart';
import '../../domain/usecases/resolve_dispute.dart';

final disputesRepositoryProvider = Provider<DisputesRepository>((ref) {
  return DriftDisputesRepository(ref.watch(appDatabaseProvider));
});

final createDisputeProvider = Provider<CreateDispute>((ref) {
  return CreateDispute(
    repository: ref.watch(disputesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final completeDisputeStepProvider = Provider<CompleteDisputeStep>((ref) {
  return CompleteDisputeStep(
    disputesRepository: ref.watch(disputesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final resolveDisputeProvider = Provider<ResolveDispute>((ref) {
  return ResolveDispute(
    disputesRepository: ref.watch(disputesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final reopenDisputeProvider = Provider<ReopenDispute>((ref) {
  return ReopenDispute(
    disputesRepository: ref.watch(disputesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final disputesProvider = StreamProvider.autoDispose<List<Dispute>>((ref) async* {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) {
    yield const [];
    return;
  }

  yield* ref.watch(disputesRepositoryProvider).watchAll(shomitiId: shomiti.id);
});

final disputeByIdProvider =
    FutureProvider.autoDispose.family<Dispute?, String>((ref, id) async {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) return null;

  return ref
      .watch(disputesRepositoryProvider)
      .getById(shomitiId: shomiti.id, disputeId: id);
});

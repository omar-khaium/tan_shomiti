import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import '../../data/in_memory_disputes_repository.dart';
import '../../domain/entities/dispute.dart';
import '../../domain/repositories/disputes_repository.dart';

final disputesRepositoryProvider = Provider<DisputesRepository>((ref) {
  return InMemoryDisputesRepository();
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


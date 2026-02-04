import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../data/drift_shares_repository.dart';
import '../../domain/repositories/shares_repository.dart';
import '../../domain/usecases/adjust_member_shares.dart';
import '../../domain/usecases/seed_share_allocations.dart';

final sharesRepositoryProvider = Provider<SharesRepository>((ref) {
  return DriftSharesRepository(ref.watch(appDatabaseProvider));
});

final seedShareAllocationsProvider = Provider<SeedShareAllocations>((ref) {
  return SeedShareAllocations(
    sharesRepository: ref.watch(sharesRepositoryProvider),
  );
});

final adjustMemberSharesProvider = Provider<AdjustMemberShares>((ref) {
  return AdjustMemberShares(
    sharesRepository: ref.watch(sharesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

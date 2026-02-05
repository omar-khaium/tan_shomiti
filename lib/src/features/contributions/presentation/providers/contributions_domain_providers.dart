import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../ledger/presentation/providers/ledger_providers.dart';
import '../../data/drift_monthly_dues_repository.dart';
import '../../data/drift_monthly_collection_repository.dart';
import '../../domain/repositories/monthly_dues_repository.dart';
import '../../domain/repositories/monthly_collection_repository.dart';
import '../../domain/usecases/generate_monthly_dues.dart';
import '../../domain/usecases/resolve_shortfall.dart';
import '../../domain/usecases/watch_monthly_dues.dart';

final monthlyDuesRepositoryProvider = Provider<MonthlyDuesRepository>((ref) {
  return DriftMonthlyDuesRepository(ref.watch(appDatabaseProvider));
});

final monthlyCollectionRepositoryProvider =
    Provider<MonthlyCollectionRepository>((ref) {
      return DriftMonthlyCollectionRepository(ref.watch(appDatabaseProvider));
    });

final generateMonthlyDuesProvider = Provider<GenerateMonthlyDues>((ref) {
  return GenerateMonthlyDues(
    monthlyDuesRepository: ref.watch(monthlyDuesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final watchMonthlyDuesProvider = Provider<WatchMonthlyDues>((ref) {
  return WatchMonthlyDues(ref.watch(monthlyDuesRepositoryProvider));
});

final resolveShortfallProvider = Provider<ResolveShortfall>((ref) {
  return ResolveShortfall(
    repository: ref.watch(monthlyCollectionRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
    appendLedgerEntry: ref.watch(appendLedgerEntryProvider),
  );
});

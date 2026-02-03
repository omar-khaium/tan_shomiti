import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../data/drift_ledger_repository.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/repositories/ledger_repository.dart';
import '../../domain/usecases/append_ledger_entry.dart';
import '../../domain/usecases/watch_ledger_entries.dart';

final ledgerRepositoryProvider = Provider<LedgerRepository>((ref) {
  return DriftLedgerRepository(ref.watch(appDatabaseProvider));
});

final watchLedgerEntriesProvider = Provider<WatchLedgerEntries>((ref) {
  return WatchLedgerEntries(ref.watch(ledgerRepositoryProvider));
});

final appendLedgerEntryProvider = Provider<AppendLedgerEntry>((ref) {
  return AppendLedgerEntry(ref.watch(ledgerRepositoryProvider));
});

final ledgerProvider = StreamProvider.autoDispose<List<LedgerEntry>>((ref) {
  return ref.watch(watchLedgerEntriesProvider)();
});


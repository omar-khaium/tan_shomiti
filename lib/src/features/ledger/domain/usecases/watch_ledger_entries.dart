import '../entities/ledger_entry.dart';
import '../repositories/ledger_repository.dart';

class WatchLedgerEntries {
  const WatchLedgerEntries(this._repository);

  final LedgerRepository _repository;

  Stream<List<LedgerEntry>> call({int limit = 100}) =>
      _repository.watchLatest(limit: limit);
}


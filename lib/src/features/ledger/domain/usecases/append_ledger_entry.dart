import '../entities/ledger_entry.dart';
import '../repositories/ledger_repository.dart';

class AppendLedgerEntry {
  const AppendLedgerEntry(this._repository);

  final LedgerRepository _repository;

  Future<void> call(NewLedgerEntry entry) => _repository.append(entry);
}


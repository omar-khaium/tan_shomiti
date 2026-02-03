import '../entities/ledger_entry.dart';

abstract class LedgerRepository {
  Stream<List<LedgerEntry>> watchLatest({int limit = 100});

  /// Append-only.
  Future<void> append(NewLedgerEntry entry);
}


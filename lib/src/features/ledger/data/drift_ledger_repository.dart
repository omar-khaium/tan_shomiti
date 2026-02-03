import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../../../core/domain/money_bdt.dart';
import '../domain/entities/ledger_entry.dart';
import '../domain/repositories/ledger_repository.dart';

class DriftLedgerRepository implements LedgerRepository {
  DriftLedgerRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<LedgerEntry>> watchLatest({int limit = 100}) {
    final query = _db.select(_db.ledgerEntries)
      ..orderBy([
        (t) => OrderingTerm.desc(t.occurredAt),
        (t) => OrderingTerm.desc(t.id),
      ])
      ..limit(limit);

    return query.watch().map(
          (rows) => rows.map(_mapRow).toList(growable: false),
        );
  }

  @override
  Future<void> append(NewLedgerEntry entry) {
    return _db.into(_db.ledgerEntries).insert(
          LedgerEntriesCompanion.insert(
            amountMinor: entry.amount.minorUnits,
            direction: _directionToDb(entry.direction),
            category: Value(entry.category),
            note: Value(entry.note),
            occurredAt: entry.occurredAt,
          ),
        );
  }

  static LedgerEntry _mapRow(LedgerEntryRow row) {
    return LedgerEntry(
      id: row.id,
      amount: MoneyBdt.fromMinorUnits(row.amountMinor),
      direction: _directionFromDb(row.direction),
      occurredAt: row.occurredAt,
      category: row.category,
      note: row.note,
    );
  }

  static String _directionToDb(LedgerDirection direction) {
    return switch (direction) {
      LedgerDirection.incoming => 'in',
      LedgerDirection.outgoing => 'out',
    };
  }

  static LedgerDirection _directionFromDb(String value) {
    return switch (value) {
      'out' => LedgerDirection.outgoing,
      _ => LedgerDirection.incoming,
    };
  }
}


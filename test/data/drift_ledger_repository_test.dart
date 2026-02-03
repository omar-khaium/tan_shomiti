import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/core/domain/money_bdt.dart';
import 'package:tan_shomiti/src/features/ledger/data/drift_ledger_repository.dart';
import 'package:tan_shomiti/src/features/ledger/domain/entities/ledger_entry.dart';

void main() {
  test('DriftLedgerRepository is append-only and orders newest first', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);

    final repo = DriftLedgerRepository(db);

    await repo.append(
      NewLedgerEntry(
        amount: MoneyBdt.fromTaka(2000),
        direction: LedgerDirection.incoming,
        occurredAt: DateTime.utc(2026, 1, 1, 9),
        category: 'contribution',
        note: 'Member 1',
      ),
    );
    await repo.append(
      NewLedgerEntry(
        amount: MoneyBdt.fromTaka(2000),
        direction: LedgerDirection.incoming,
        occurredAt: DateTime.utc(2026, 1, 2, 9),
        category: 'contribution',
        note: 'Member 2',
      ),
    );

    final entries = await repo.watchLatest().first;
    expect(entries, hasLength(2));
    expect(entries.first.note, 'Member 2');
    expect(entries.last.note, 'Member 1');
  });
}


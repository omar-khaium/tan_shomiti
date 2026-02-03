import 'package:drift/drift.dart';

@DataClassName('LedgerEntryRow')
class LedgerEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Amount in BDT minor units (poisha).
  IntColumn get amountMinor => integer()();

  /// 'in' or 'out' (kept as text for forward compatibility).
  TextColumn get direction => text()();

  /// Optional category label, e.g. "contribution", "payout".
  TextColumn get category => text().nullable()();

  /// Optional note (avoid PII).
  TextColumn get note => text().nullable()();

  DateTimeColumn get occurredAt => dateTime()();
}


import 'package:drift/drift.dart';

class MonthlyChecklistItems extends Table {
  TextColumn get id => text()();

  TextColumn get shomitiId => text()();

  /// Stored as `YYYY-MM` (see `BillingMonth.key`).
  TextColumn get billingMonthKey => text()();

  /// Stored as the domain enum key (e.g. `attendance`).
  TextColumn get itemKey => text()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {shomitiId, billingMonthKey, itemKey},
      ];
}


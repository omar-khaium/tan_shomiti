import 'package:drift/drift.dart';

import 'shomitis.dart';

@DataClassName('CollectionResolutionRow')
class CollectionResolutions extends Table {
  TextColumn get shomitiId => text().references(Shomitis, #id)();
  TextColumn get monthKey => text()();

  /// reserve | guarantor
  TextColumn get method => text()();

  /// Amount covered (BDT, taka).
  IntColumn get amountBdt => integer()();

  /// Optional note (avoid PII).
  TextColumn get note => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {shomitiId, monthKey};
}


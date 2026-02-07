import 'package:drift/drift.dart';

import 'shomitis.dart';

@DataClassName('DisputeRow')
class Disputes extends Table {
  TextColumn get id => text()();

  TextColumn get shomitiId => text().references(Shomitis, #id)();

  TextColumn get title => text()();
  TextColumn get description => text()();

  /// Optional free-form month key, e.g. "2026-02" (MVP).
  TextColumn get relatedMonthKey => text().nullable()();

  /// Optional free-form notes about involved members (avoid sensitive data).
  TextColumn get involvedMembersText => text().nullable()();

  /// JSON array of string references (links/ids). MVP stores references only.
  TextColumn get evidenceReferencesJson => text()();

  /// open | resolved
  TextColumn get status => text()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}


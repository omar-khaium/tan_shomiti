import 'package:drift/drift.dart';

@DataClassName('RuleSetVersionRow')
class RuleSetVersions extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();

  /// JSON snapshot of rules/policies (placeholder until TS-101+).
  TextColumn get json => text()();

  @override
  Set<Column> get primaryKey => {id};
}


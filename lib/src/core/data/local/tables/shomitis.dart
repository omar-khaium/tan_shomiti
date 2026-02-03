import 'package:drift/drift.dart';

@DataClassName('ShomitiRow')
class Shomitis extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get activeRuleSetVersionId => text()();

  @override
  Set<Column> get primaryKey => {id};
}


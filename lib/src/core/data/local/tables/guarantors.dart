import 'package:drift/drift.dart';

@DataClassName('GuarantorRow')
class Guarantors extends Table {
  TextColumn get shomitiId => text()();
  TextColumn get memberId => text()();

  TextColumn get name => text()();
  TextColumn get phone => text()();
  TextColumn get relationship => text().nullable()();
  TextColumn get proofRef => text().nullable()();

  DateTimeColumn get recordedAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {shomitiId, memberId};
}

import 'package:drift/drift.dart';

@DataClassName('SecurityDepositRow')
class SecurityDeposits extends Table {
  TextColumn get shomitiId => text()();
  TextColumn get memberId => text()();

  IntColumn get amountBdt => integer()();
  TextColumn get heldBy => text()();
  TextColumn get proofRef => text().nullable()();

  DateTimeColumn get recordedAt => dateTime()();
  DateTimeColumn get returnedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {shomitiId, memberId};
}

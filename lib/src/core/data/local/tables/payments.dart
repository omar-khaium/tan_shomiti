import 'package:drift/drift.dart';

import 'members.dart';
import 'shomitis.dart';

@DataClassName('PaymentRow')
class Payments extends Table {
  TextColumn get id => text()();
  TextColumn get shomitiId => text().references(Shomitis, #id)();
  TextColumn get monthKey => text()();
  TextColumn get memberId => text().references(Members, #id)();

  IntColumn get amountBdt => integer()();
  TextColumn get method => text()();
  TextColumn get reference => text()();
  TextColumn get proofNote => text().nullable()();

  DateTimeColumn get recordedAt => dateTime()();
  DateTimeColumn get confirmedAt => dateTime()();

  TextColumn get receiptNumber => text().nullable()();
  DateTimeColumn get receiptIssuedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {shomitiId, monthKey, memberId},
  ];
}

import 'package:drift/drift.dart';

import 'members.dart';
import 'shomitis.dart';

@DataClassName('MonthlyDueRow')
class MonthlyDues extends Table {
  TextColumn get shomitiId => text().references(Shomitis, #id)();

  /// YYYY-MM (e.g. 2026-02)
  TextColumn get monthKey => text()();

  TextColumn get memberId => text().references(Members, #id)();

  IntColumn get shares => integer()();
  IntColumn get shareValueBdt => integer()();
  IntColumn get dueAmountBdt => integer()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {shomitiId, monthKey, memberId};
}

import 'package:drift/drift.dart';

class MemberShares extends Table {
  TextColumn get shomitiId => text()();
  TextColumn get memberId => text()();

  /// Number of shares held by the member.
  IntColumn get shares => integer()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {shomitiId, memberId};
}

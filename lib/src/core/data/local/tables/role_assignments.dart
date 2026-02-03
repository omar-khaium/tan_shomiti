import 'package:drift/drift.dart';

import 'members.dart';
import 'shomitis.dart';

@DataClassName('RoleAssignmentRow')
class RoleAssignments extends Table {
  TextColumn get shomitiId => text().references(Shomitis, #id)();

  /// Stored as the enum name for forward compatibility.
  TextColumn get role => text()();

  TextColumn get memberId => text().references(Members, #id)();

  DateTimeColumn get assignedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {shomitiId, role};
}


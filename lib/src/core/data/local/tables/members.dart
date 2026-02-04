import 'package:drift/drift.dart';

import 'shomitis.dart';

@DataClassName('MemberRow')
class Members extends Table {
  TextColumn get id => text()();

  TextColumn get shomitiId => text().references(Shomitis, #id)();

  /// 1-based ordering for predictable UI lists.
  IntColumn get position => integer()();

  TextColumn get displayName => text()();

  /// `rules.md` Section 3 identity/contact fields.
  TextColumn get phone => text().nullable()();
  TextColumn get addressOrWorkplace => text().nullable()();
  TextColumn get nidOrPassport => text().nullable()();
  TextColumn get emergencyContactName => text().nullable()();
  TextColumn get emergencyContactPhone => text().nullable()();

  /// Optional notes. Avoid storing highly sensitive content.
  TextColumn get notes => text().nullable()();

  /// Soft-delete/deactivation (keep history + audit).
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE(shomiti_id, position)'];
}

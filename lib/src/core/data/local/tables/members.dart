import 'package:drift/drift.dart';

import 'shomitis.dart';

@DataClassName('MemberRow')
class Members extends Table {
  TextColumn get id => text()();

  TextColumn get shomitiId => text().references(Shomitis, #id)();

  /// 1-based ordering for predictable UI lists.
  IntColumn get position => integer()();

  TextColumn get displayName => text()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
        'UNIQUE(shomiti_id, position)',
      ];
}


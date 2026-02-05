import 'package:drift/drift.dart';

import 'rule_set_versions.dart';
import 'shomitis.dart';

@DataClassName('DueMonthRow')
class DueMonths extends Table {
  TextColumn get shomitiId => text().references(Shomitis, #id)();

  /// YYYY-MM (e.g. 2026-02)
  TextColumn get monthKey => text()();

  TextColumn get ruleSetVersionId =>
      text().references(RuleSetVersions, #id)();

  DateTimeColumn get generatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {shomitiId, monthKey};
}


import 'package:drift/drift.dart';

import 'rule_set_versions.dart';
import 'shomitis.dart';

@DataClassName('MonthlyStatementRow')
class MonthlyStatements extends Table {
  TextColumn get shomitiId => text().references(Shomitis, #id)();

  TextColumn get monthKey => text()();

  TextColumn get ruleSetVersionId =>
      text().references(RuleSetVersions, #id)();

  /// Statement snapshot JSON (avoid PII).
  TextColumn get json => text()();

  DateTimeColumn get generatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {shomitiId, monthKey};
}


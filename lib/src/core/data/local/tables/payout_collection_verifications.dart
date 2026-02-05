import 'package:drift/drift.dart';

import 'rule_set_versions.dart';
import 'shomitis.dart';

@DataClassName('PayoutCollectionVerificationRow')
class PayoutCollectionVerifications extends Table {
  TextColumn get shomitiId => text().references(Shomitis, #id)();

  TextColumn get monthKey => text()();

  TextColumn get ruleSetVersionId =>
      text().references(RuleSetVersions, #id)();

  TextColumn get verifiedByMemberId => text()();

  TextColumn get note => text().nullable()();

  DateTimeColumn get verifiedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {shomitiId, monthKey};
}


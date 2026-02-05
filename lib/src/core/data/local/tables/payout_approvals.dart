import 'package:drift/drift.dart';

import 'rule_set_versions.dart';
import 'shomitis.dart';

@DataClassName('PayoutApprovalRow')
class PayoutApprovals extends Table {
  TextColumn get shomitiId => text().references(Shomitis, #id)();

  TextColumn get monthKey => text()();

  /// 'treasurer' or 'auditor'
  TextColumn get role => text()();

  TextColumn get approverMemberId => text()();

  TextColumn get ruleSetVersionId =>
      text().references(RuleSetVersions, #id)();

  TextColumn get note => text().nullable()();

  DateTimeColumn get approvedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {shomitiId, monthKey, role, approverMemberId};
}


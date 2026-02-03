import 'package:drift/drift.dart';

import 'members.dart';
import 'rule_set_versions.dart';
import 'shomitis.dart';

@DataClassName('MemberConsentRow')
class MemberConsents extends Table {
  TextColumn get memberId => text().references(Members, #id)();

  TextColumn get ruleSetVersionId => text().references(RuleSetVersions, #id)();

  TextColumn get shomitiId => text().references(Shomitis, #id)();

  /// Stored as the enum name for forward compatibility.
  TextColumn get proofType => text()();

  /// Free-text proof reference (avoid storing sensitive content).
  TextColumn get proofReference => text()();

  DateTimeColumn get signedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {memberId, ruleSetVersionId};
}


import 'package:drift/drift.dart';

import 'rule_set_versions.dart';
import 'shomitis.dart';

@DataClassName('RuleAmendmentRow')
class RuleAmendments extends Table {
  TextColumn get id => text()();

  TextColumn get shomitiId => text().references(Shomitis, #id)();

  /// The currently active rule set version when the amendment was proposed.
  TextColumn get baseRuleSetVersionId => text()();

  /// The proposed rule set version id (new immutable snapshot).
  TextColumn get proposedRuleSetVersionId =>
      text().references(RuleSetVersions, #id)();

  /// `draft` | `pendingConsent` | `applied`
  TextColumn get status => text()();

  /// Written summary of the amendment (required at apply-time).
  TextColumn get note => text().nullable()();

  /// Reference where it was shared (required at apply-time).
  TextColumn get sharedReference => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get appliedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

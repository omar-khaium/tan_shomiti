import 'package:drift/drift.dart';

import 'members.dart';
import 'rule_set_versions.dart';
import 'shomitis.dart';

@DataClassName('DefaultEnforcementStepRow')
class DefaultEnforcementSteps extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get shomitiId => text().references(Shomitis, #id)();
  TextColumn get memberId => text().references(Members, #id)();

  /// Identifier for the current default episode (BillingMonth key of the
  /// earliest missed payment in the current consecutive streak).
  TextColumn get episodeKey => text()();

  /// Enforcement step type (reminder/notice/guarantor_or_deposit/dispute).
  TextColumn get stepType => text()();

  TextColumn get ruleSetVersionId =>
      text().references(RuleSetVersions, #id)();

  DateTimeColumn get recordedAt => dateTime()();
  TextColumn get note => text().nullable()();

  /// Optional: amount covered when applying guarantor/deposit (BDT).
  IntColumn get amountBdt => integer().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {shomitiId, memberId, episodeKey, stepType},
  ];
}


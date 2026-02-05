import 'package:drift/drift.dart';

import 'draw_records.dart';
import 'rule_set_versions.dart';

@DataClassName('DrawWitnessApprovalRow')
class DrawWitnessApprovals extends Table {
  TextColumn get drawId => text().references(DrawRecords, #id)();

  TextColumn get witnessMemberId => text()();

  TextColumn get ruleSetVersionId =>
      text().references(RuleSetVersions, #id)();

  TextColumn get note => text().nullable()();

  DateTimeColumn get approvedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {drawId, witnessMemberId};
}


import 'package:drift/drift.dart';

import 'draw_records.dart';
import 'rule_set_versions.dart';
import 'shomitis.dart';

@DataClassName('PayoutRecordRow')
class PayoutRecords extends Table {
  TextColumn get shomitiId => text().references(Shomitis, #id)();

  TextColumn get monthKey => text()();

  TextColumn get drawId => text().references(DrawRecords, #id)();

  TextColumn get ruleSetVersionId =>
      text().references(RuleSetVersions, #id)();

  TextColumn get winnerMemberId => text()();

  IntColumn get winnerShareIndex => integer()();

  /// Amount to pay in BDT.
  IntColumn get amountBdt => integer()();

  /// Required to mark paid.
  TextColumn get proofReference => text().nullable()();

  /// Who marked this payout as paid (member id), if available.
  TextColumn get markedPaidByMemberId => text().nullable()();

  DateTimeColumn get paidAt => dateTime().nullable()();

  DateTimeColumn get recordedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {shomitiId, monthKey};
}


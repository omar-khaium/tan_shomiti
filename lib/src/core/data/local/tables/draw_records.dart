import 'package:drift/drift.dart';

import 'rule_set_versions.dart';
import 'shomitis.dart';

@DataClassName('DrawRecordRow')
class DrawRecords extends Table {
  TextColumn get id => text()();

  TextColumn get shomitiId => text().references(Shomitis, #id)();

  /// YYYY-MM (e.g. 2026-02)
  TextColumn get monthKey => text()();

  TextColumn get ruleSetVersionId =>
      text().references(RuleSetVersions, #id)();

  /// Storage value for draw method (see DrawMethodStorage).
  TextColumn get method => text()();

  /// Video/screenshot/link id.
  TextColumn get proofReference => text()();

  TextColumn get notes => text().nullable()();

  TextColumn get winnerMemberId => text()();

  /// 1-based share index within the winner member's shares for this month.
  IntColumn get winnerShareIndex => integer()();

  /// JSON array of eligible share entry keys at record time.
  TextColumn get eligibleShareKeysJson => text()();

  /// Optional linkage when this record is a redo of a previous record.
  TextColumn get redoOfDrawId => text().nullable()();

  /// Set when the draw is invalidated (redo flow). Invalidated draws are not
  /// effective for eligibility/winner exclusion.
  DateTimeColumn get invalidatedAt => dateTime().nullable()();

  /// Required when invalidating a draw.
  TextColumn get invalidatedReason => text().nullable()();

  /// Set when witness approvals are complete and the draw is finalized.
  DateTimeColumn get finalizedAt => dateTime().nullable()();

  DateTimeColumn get recordedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

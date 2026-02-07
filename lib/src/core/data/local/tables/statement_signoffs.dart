import 'package:drift/drift.dart';

import 'members.dart';
import 'shomitis.dart';

@DataClassName('StatementSignoffRow')
class StatementSignoffs extends Table {
  TextColumn get shomitiId => text().references(Shomitis, #id)();

  /// `BillingMonth.key` (e.g. "2026-02").
  TextColumn get monthKey => text()();

  TextColumn get signerMemberId => text().references(Members, #id)();

  /// "auditor" | "witness"
  TextColumn get signerRole => text()();

  TextColumn get proofReference => text()();

  TextColumn get note => text().nullable()();

  DateTimeColumn get signedAt => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {shomitiId, monthKey, signerMemberId};
}

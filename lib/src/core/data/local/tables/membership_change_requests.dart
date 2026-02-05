import 'package:drift/drift.dart';

import 'members.dart';
import 'shomitis.dart';

@DataClassName('MembershipChangeRequestRow')
class MembershipChangeRequests extends Table {
  TextColumn get id => text()();

  TextColumn get shomitiId => text().references(Shomitis, #id)();
  TextColumn get outgoingMemberId => text().references(Members, #id)();

  /// exit | replacement | removal
  TextColumn get type => text()();

  /// `rules.md` Section 14 recommends requiring replacement by default.
  BoolColumn get requiresReplacement =>
      boolean().withDefault(const Constant(true))();

  TextColumn get replacementCandidateName => text().nullable()();
  TextColumn get replacementCandidatePhone => text().nullable()();

  /// removal reason codes (non-accusatory). Optional details allowed.
  TextColumn get removalReasonCode => text().nullable()();
  TextColumn get removalReasonDetails => text().nullable()();

  DateTimeColumn get requestedAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get finalizedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

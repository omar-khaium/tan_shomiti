import 'package:drift/drift.dart';

import 'membership_change_requests.dart';
import 'shomitis.dart';

@DataClassName('MembershipChangeApprovalRow')
class MembershipChangeApprovals extends Table {
  TextColumn get shomitiId => text().references(Shomitis, #id)();
  TextColumn get requestId =>
      text().references(MembershipChangeRequests, #id)();
  TextColumn get approverMemberId => text()();

  DateTimeColumn get approvedAt => dateTime()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {shomitiId, requestId, approverMemberId};
}


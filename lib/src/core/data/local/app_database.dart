import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/audit_events.dart';
import 'tables/ledger_entries.dart';
import 'tables/member_consents.dart';
import 'tables/members.dart';
import 'tables/member_shares.dart';
import 'tables/guarantors.dart';
import 'tables/security_deposits.dart';
import 'tables/role_assignments.dart';
import 'tables/rule_set_versions.dart';
import 'tables/membership_change_requests.dart';
import 'tables/membership_change_approvals.dart';
import 'tables/due_months.dart';
import 'tables/monthly_dues.dart';
import 'tables/shomitis.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AuditEvents,
    LedgerEntries,
    Members,
    MemberShares,
    Guarantors,
    SecurityDeposits,
    RoleAssignments,
    MemberConsents,
    RuleSetVersions,
    MembershipChangeRequests,
    MembershipChangeApprovals,
    DueMonths,
    MonthlyDues,
    Shomitis,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  factory AppDatabase.open() => AppDatabase(_openConnection());

  factory AppDatabase.memory() => AppDatabase(NativeDatabase.memory());

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(shomitis);
      }
      if (from < 3) {
        await m.createTable(members);
        await m.createTable(roleAssignments);
        await m.createTable(memberConsents);
      }
      if (from < 4) {
        await m.addColumn(members, members.phone);
        await m.addColumn(members, members.addressOrWorkplace);
        await m.addColumn(members, members.nidOrPassport);
        await m.addColumn(members, members.emergencyContactName);
        await m.addColumn(members, members.emergencyContactPhone);
        await m.addColumn(members, members.notes);
        await m.addColumn(members, members.isActive);
        await m.addColumn(members, members.updatedAt);
      }
      if (from < 5) {
        await m.createTable(memberShares);
      }
      if (from < 6) {
        await m.createTable(guarantors);
        await m.createTable(securityDeposits);
      }
      if (from < 7) {
        await m.createTable(membershipChangeRequests);
        await m.createTable(membershipChangeApprovals);
      }
      if (from < 8) {
        await m.createTable(dueMonths);
        await m.createTable(monthlyDues);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'tan_shomiti.sqlite'));
    return NativeDatabase(file);
  });
}

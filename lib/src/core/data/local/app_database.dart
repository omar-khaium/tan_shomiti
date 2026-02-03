import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/audit_events.dart';
import 'tables/ledger_entries.dart';
import 'tables/rule_set_versions.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AuditEvents,
    LedgerEntries,
    RuleSetVersions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  factory AppDatabase.open() => AppDatabase(_openConnection());

  factory AppDatabase.memory() => AppDatabase(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'tan_shomiti.sqlite'));
    return NativeDatabase(file);
  });
}


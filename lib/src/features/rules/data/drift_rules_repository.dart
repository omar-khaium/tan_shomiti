import 'dart:convert';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/rule_set_snapshot.dart';
import '../domain/entities/rule_set_version.dart';
import '../domain/repositories/rules_repository.dart';

class DriftRulesRepository implements RulesRepository {
  DriftRulesRepository(this._db);

  final AppDatabase _db;

  @override
  Future<void> upsert(RuleSetVersion version) async {
    await _db.into(_db.ruleSetVersions).insertOnConflictUpdate(
          RuleSetVersionsCompanion.insert(
            id: version.id,
            createdAt: version.createdAt,
            json: jsonEncode(version.snapshot.toJson()),
          ),
        );
  }

  @override
  Future<RuleSetVersion?> getById(String id) async {
    final row = await (_db.select(_db.ruleSetVersions)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();

    if (row == null) return null;

    final snapshot = RuleSetSnapshot.fromJson(
      jsonDecode(row.json) as Map<String, Object?>,
    );

    return RuleSetVersion(
      id: row.id,
      createdAt: row.createdAt,
      snapshot: snapshot,
    );
  }
}

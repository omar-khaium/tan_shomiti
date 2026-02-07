import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/rule_amendment.dart';
import '../domain/repositories/rule_amendments_repository.dart';

class DriftRuleAmendmentsRepository implements RuleAmendmentsRepository {
  DriftRuleAmendmentsRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<RuleAmendment>> watchAll({required String shomitiId}) {
    final query = _db.select(_db.ruleAmendments)
      ..where((t) => t.shomitiId.equals(shomitiId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    return query.watch().map(
          (rows) => rows.map(_mapRow).toList(growable: false),
        );
  }

  @override
  Stream<RuleAmendment?> watchPending({required String shomitiId}) {
    final query = _db.select(_db.ruleAmendments)
      ..where((t) => t.shomitiId.equals(shomitiId))
      ..where((t) => t.status.equals(RuleAmendmentStatus.pendingConsent.name));

    return query.watchSingleOrNull().map((row) => row == null ? null : _mapRow(row));
  }

  @override
  Future<RuleAmendment?> getById({
    required String shomitiId,
    required String amendmentId,
  }) async {
    final row = await (_db.select(_db.ruleAmendments)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..where((t) => t.id.equals(amendmentId)))
        .getSingleOrNull();

    return row == null ? null : _mapRow(row);
  }

  @override
  Future<void> upsert(RuleAmendment amendment) async {
    await _db.into(_db.ruleAmendments).insertOnConflictUpdate(
          RuleAmendmentsCompanion.insert(
            id: amendment.id,
            shomitiId: amendment.shomitiId,
            baseRuleSetVersionId: amendment.baseRuleSetVersionId,
            proposedRuleSetVersionId: amendment.proposedRuleSetVersionId,
            status: amendment.status.name,
            note: Value(amendment.note),
            sharedReference: Value(amendment.sharedReference),
            createdAt: amendment.createdAt,
            appliedAt: Value(amendment.appliedAt),
          ),
        );
  }

  static RuleAmendment _mapRow(RuleAmendmentRow row) {
    final status = RuleAmendmentStatus.values.firstWhere(
      (s) => s.name == row.status,
      orElse: () => RuleAmendmentStatus.draft,
    );

    return RuleAmendment(
      id: row.id,
      shomitiId: row.shomitiId,
      baseRuleSetVersionId: row.baseRuleSetVersionId,
      proposedRuleSetVersionId: row.proposedRuleSetVersionId,
      status: status,
      note: row.note,
      sharedReference: row.sharedReference,
      createdAt: row.createdAt,
      appliedAt: row.appliedAt,
    );
  }
}

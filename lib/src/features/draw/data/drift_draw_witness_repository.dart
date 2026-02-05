import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/draw_witness_approval.dart';
import '../domain/repositories/draw_witness_repository.dart';

class DriftDrawWitnessRepository implements DrawWitnessRepository {
  DriftDrawWitnessRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<DrawWitnessApproval>> watchApprovals({required String drawId}) {
    final query = _db.select(_db.drawWitnessApprovals)
      ..where((t) => t.drawId.equals(drawId))
      ..orderBy([
        (t) => OrderingTerm.asc(t.approvedAt),
        (t) => OrderingTerm.asc(t.witnessMemberId),
      ]);

    return query.watch().map(
          (rows) => rows.map(_mapRow).toList(growable: false),
        );
  }

  @override
  Future<List<DrawWitnessApproval>> listApprovals({required String drawId}) async {
    final rows = await (_db.select(_db.drawWitnessApprovals)
          ..where((t) => t.drawId.equals(drawId))
          ..orderBy([
            (t) => OrderingTerm.asc(t.approvedAt),
            (t) => OrderingTerm.asc(t.witnessMemberId),
          ]))
        .get();

    return rows.map(_mapRow).toList(growable: false);
  }

  @override
  Future<void> upsertApproval(DrawWitnessApproval approval) async {
    await _db.into(_db.drawWitnessApprovals).insertOnConflictUpdate(
          DrawWitnessApprovalsCompanion.insert(
            drawId: approval.drawId,
            witnessMemberId: approval.witnessMemberId,
            ruleSetVersionId: approval.ruleSetVersionId,
            note: Value(approval.note),
            approvedAt: approval.approvedAt,
          ),
        );
  }

  static DrawWitnessApproval _mapRow(DrawWitnessApprovalRow row) {
    return DrawWitnessApproval(
      drawId: row.drawId,
      witnessMemberId: row.witnessMemberId,
      ruleSetVersionId: row.ruleSetVersionId,
      note: row.note,
      approvedAt: row.approvedAt,
    );
  }
}


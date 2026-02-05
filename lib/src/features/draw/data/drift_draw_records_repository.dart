import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../domain/entities/draw_record.dart';
import '../domain/repositories/draw_records_repository.dart';
import '../domain/value_objects/draw_method.dart';

class DriftDrawRecordsRepository implements DrawRecordsRepository {
  DriftDrawRecordsRepository(this._db);

  final AppDatabase _db;

  @override
  Future<DrawRecord?> getById({required String id}) async {
    final row =
        await (_db.select(_db.drawRecords)..where((r) => r.id.equals(id)))
            .getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  @override
  Future<DrawRecord?> getEffectiveForMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final rows = await (_db.select(_db.drawRecords)
          ..where((r) => r.shomitiId.equals(shomitiId))
          ..where((r) => r.monthKey.equals(month.key))
          ..where((r) => r.invalidatedAt.isNull())
          ..orderBy([
            (r) => OrderingTerm.desc(r.recordedAt),
            (r) => OrderingTerm.desc(r.id),
          ])
          ..limit(1))
        .get();
    return rows.isEmpty ? null : _mapRow(rows.single);
  }

  @override
  Future<List<DrawRecord>> listForMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final rows = await (_db.select(_db.drawRecords)
          ..where((r) => r.shomitiId.equals(shomitiId))
          ..where((r) => r.monthKey.equals(month.key))
          ..orderBy([
            (r) => OrderingTerm.desc(r.recordedAt),
            (r) => OrderingTerm.desc(r.id),
          ]))
        .get();
    return rows.map(_mapRow).toList(growable: false);
  }

  @override
  Future<List<DrawRecord>> listAll({required String shomitiId}) async {
    final rows =
        await (_db.select(_db.drawRecords)
              ..where((r) => r.shomitiId.equals(shomitiId))
              ..orderBy([
                (r) => OrderingTerm.desc(r.monthKey),
                (r) => OrderingTerm.desc(r.recordedAt),
                (r) => OrderingTerm.desc(r.id),
              ]))
            .get();
    return rows.map(_mapRow).toList(growable: false);
  }

  @override
  Future<void> upsert(DrawRecord record) async {
    await _db.into(_db.drawRecords).insertOnConflictUpdate(
          DrawRecordsCompanion.insert(
            id: record.id,
            shomitiId: record.shomitiId,
            monthKey: record.month.key,
            ruleSetVersionId: record.ruleSetVersionId,
            method: record.method.value,
            proofReference: record.proofReference,
            notes: Value(record.notes),
            winnerMemberId: record.winnerMemberId,
            winnerShareIndex: record.winnerShareIndex,
            eligibleShareKeysJson: jsonEncode(record.eligibleShareKeys),
            redoOfDrawId: Value(record.redoOfDrawId),
            invalidatedAt: Value(record.invalidatedAt),
            invalidatedReason: Value(record.invalidatedReason),
            finalizedAt: Value(record.finalizedAt),
            recordedAt: record.recordedAt,
          ),
        );
  }

  static DrawRecord _mapRow(DrawRecordRow row) {
    final eligibleKeys = (jsonDecode(row.eligibleShareKeysJson) as List<dynamic>)
        .whereType<String>()
        .toList(growable: false);

    return DrawRecord(
      id: row.id,
      shomitiId: row.shomitiId,
      month: BillingMonth.fromKey(row.monthKey),
      ruleSetVersionId: row.ruleSetVersionId,
      method: DrawMethodStorage.fromValue(row.method),
      proofReference: row.proofReference,
      notes: row.notes,
      winnerMemberId: row.winnerMemberId,
      winnerShareIndex: row.winnerShareIndex,
      eligibleShareKeys: eligibleKeys,
      redoOfDrawId: row.redoOfDrawId,
      invalidatedAt: row.invalidatedAt,
      invalidatedReason: row.invalidatedReason,
      finalizedAt: row.finalizedAt,
      recordedAt: row.recordedAt,
    );
  }
}

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
  Future<DrawRecord?> getForMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final row =
        await (_db.select(_db.drawRecords)
              ..where((r) => r.shomitiId.equals(shomitiId))
              ..where((r) => r.monthKey.equals(month.key)))
            .getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  @override
  Future<List<DrawRecord>> listAll({required String shomitiId}) async {
    final rows =
        await (_db.select(_db.drawRecords)
              ..where((r) => r.shomitiId.equals(shomitiId))
              ..orderBy([(r) => OrderingTerm(expression: r.monthKey)]))
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
      recordedAt: row.recordedAt,
    );
  }
}


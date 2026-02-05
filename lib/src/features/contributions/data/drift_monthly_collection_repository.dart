import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/collection_resolution.dart';
import '../domain/repositories/monthly_collection_repository.dart';
import '../domain/value_objects/billing_month.dart';

class DriftMonthlyCollectionRepository implements MonthlyCollectionRepository {
  DriftMonthlyCollectionRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<CollectionResolution?> watchResolution({
    required String shomitiId,
    required BillingMonth month,
  }) {
    final query = _db.select(_db.collectionResolutions)
      ..where((t) => t.shomitiId.equals(shomitiId))
      ..where((t) => t.monthKey.equals(month.key));

    return query.watchSingleOrNull().map(
          (row) => row == null ? null : _mapRow(row),
        );
  }

  @override
  Future<CollectionResolution?> getResolution({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final row = await (_db.select(_db.collectionResolutions)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..where((t) => t.monthKey.equals(month.key)))
        .getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  @override
  Future<void> upsertResolution(CollectionResolution resolution) async {
    await _db.into(_db.collectionResolutions).insertOnConflictUpdate(
          CollectionResolutionsCompanion.insert(
            shomitiId: resolution.shomitiId,
            monthKey: resolution.month.key,
            method: _methodToDb(resolution.method),
            amountBdt: resolution.amountBdt,
            note: Value(resolution.note),
            createdAt: resolution.createdAt,
          ),
        );
  }

  static CollectionResolution _mapRow(CollectionResolutionRow row) {
    return CollectionResolution(
      shomitiId: row.shomitiId,
      month: BillingMonth.fromKey(row.monthKey),
      method: _methodFromDb(row.method),
      amountBdt: row.amountBdt,
      note: row.note,
      createdAt: row.createdAt,
    );
  }

  static String _methodToDb(CollectionResolutionMethod method) {
    return switch (method) {
      CollectionResolutionMethod.reserve => 'reserve',
      CollectionResolutionMethod.guarantor => 'guarantor',
    };
  }

  static CollectionResolutionMethod _methodFromDb(String value) {
    return switch (value) {
      'guarantor' => CollectionResolutionMethod.guarantor,
      _ => CollectionResolutionMethod.reserve,
    };
  }
}


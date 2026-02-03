import '../../../core/data/local/app_database.dart';
import '../domain/entities/shomiti.dart';
import '../domain/repositories/shomiti_repository.dart';

class DriftShomitiRepository implements ShomitiRepository {
  DriftShomitiRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<Shomiti?> watchActive() {
    final query = _db.select(_db.shomitis)
      ..where((t) => t.id.equals(activeShomitiId));

    return query.watchSingleOrNull().map((row) => row == null ? null : _mapRow(row));
  }

  @override
  Future<Shomiti?> getActive() async {
    final row = await (_db.select(_db.shomitis)
          ..where((t) => t.id.equals(activeShomitiId)))
        .getSingleOrNull();

    if (row == null) return null;
    return _mapRow(row);
  }

  @override
  Future<void> upsert(Shomiti shomiti) async {
    await _db.into(_db.shomitis).insertOnConflictUpdate(
          ShomitisCompanion.insert(
            id: shomiti.id,
            name: shomiti.name,
            startDate: shomiti.startDate,
            createdAt: shomiti.createdAt,
            activeRuleSetVersionId: shomiti.activeRuleSetVersionId,
          ),
        );
  }

  Shomiti _mapRow(ShomitiRow row) {
    return Shomiti(
      id: row.id,
      name: row.name,
      startDate: row.startDate,
      createdAt: row.createdAt,
      activeRuleSetVersionId: row.activeRuleSetVersionId,
    );
  }
}

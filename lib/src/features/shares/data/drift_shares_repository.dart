import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/member_share_allocation.dart';
import '../domain/repositories/shares_repository.dart';

class DriftSharesRepository implements SharesRepository {
  DriftSharesRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<MemberShareAllocation>> watchAllocations({
    required String shomitiId,
  }) {
    final query =
        (_db.select(_db.memberShares)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..orderBy([(t) => OrderingTerm.asc(t.memberId)]))
            .watch();

    return query.map((rows) => rows.map(_mapRow).toList(growable: false));
  }

  @override
  Future<List<MemberShareAllocation>> listAllocations({
    required String shomitiId,
  }) async {
    final query = _db.select(_db.memberShares)
      ..where((t) => t.shomitiId.equals(shomitiId))
      ..orderBy([(t) => OrderingTerm.asc(t.memberId)]);

    final rows = await query.get();
    return rows.map(_mapRow).toList(growable: false);
  }

  @override
  Future<void> upsertAllocation(MemberShareAllocation allocation) {
    return _db
        .into(_db.memberShares)
        .insertOnConflictUpdate(
          MemberSharesCompanion.insert(
            shomitiId: allocation.shomitiId,
            memberId: allocation.memberId,
            shares: allocation.shares,
            createdAt: allocation.createdAt,
            updatedAt: Value(allocation.updatedAt),
          ),
        );
  }

  @override
  Future<void> upsertAllocations(
    List<MemberShareAllocation> allocations,
  ) async {
    if (allocations.isEmpty) return;

    await _db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _db.memberShares,
        allocations
            .map(
              (a) => MemberSharesCompanion.insert(
                shomitiId: a.shomitiId,
                memberId: a.memberId,
                shares: a.shares,
                createdAt: a.createdAt,
                updatedAt: Value(a.updatedAt),
              ),
            )
            .toList(growable: false),
      );
    });
  }

  static MemberShareAllocation _mapRow(MemberShare row) {
    return MemberShareAllocation(
      shomitiId: row.shomitiId,
      memberId: row.memberId,
      shares: row.shares,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}

import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/member.dart';
import '../domain/repositories/members_repository.dart';

class DriftMembersRepository implements MembersRepository {
  DriftMembersRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Member>> watchMembers({required String shomitiId}) {
    final query = (_db.select(_db.members)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..orderBy([(t) => OrderingTerm.asc(t.position)]))
        .watch();

    return query.map(
      (rows) => rows
          .map(
            (row) => Member(
              id: row.id,
              shomitiId: row.shomitiId,
              position: row.position,
              displayName: row.displayName,
              createdAt: row.createdAt,
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<void> seedPlaceholders({
    required String shomitiId,
    required int memberCount,
  }) async {
    if (memberCount <= 0) return;

    await _db.transaction(() async {
      final existingCount = await (_db.selectOnly(_db.members)
            ..addColumns([_db.members.id])
            ..where(_db.members.shomitiId.equals(shomitiId)))
          .get()
          .then((rows) => rows.length);

      if (existingCount >= memberCount) return;

      final now = DateTime.now();

      final companions = [
        for (var i = existingCount + 1; i <= memberCount; i++)
          MembersCompanion.insert(
            id: 'm_${shomitiId}_$i',
            shomitiId: shomitiId,
            position: i,
            displayName: 'Member $i',
            createdAt: now,
          ),
      ];

      await _db.batch((batch) {
        batch.insertAll(_db.members, companions);
      });
    });
  }
}


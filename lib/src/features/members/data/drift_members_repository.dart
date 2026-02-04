import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/member.dart';
import '../domain/repositories/members_repository.dart';

class DriftMembersRepository implements MembersRepository {
  DriftMembersRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Member>> watchMembers({required String shomitiId}) {
    final query =
        (_db.select(_db.members)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .watch();

    return query.map((rows) => rows.map(_mapRow).toList(growable: false));
  }

  @override
  Future<List<Member>> listMembers({required String shomitiId}) async {
    final query = _db.select(_db.members)
      ..where((t) => t.shomitiId.equals(shomitiId))
      ..orderBy([(t) => OrderingTerm.asc(t.position)]);

    final rows = await query.get();
    return rows.map(_mapRow).toList(growable: false);
  }

  @override
  Future<Member?> getById({
    required String shomitiId,
    required String memberId,
  }) async {
    final row =
        await (_db.select(_db.members)..where(
              (t) => t.shomitiId.equals(shomitiId) & t.id.equals(memberId),
            ))
            .getSingleOrNull();

    return row == null ? null : _mapRow(row);
  }

  @override
  Future<void> upsert(Member member) {
    return _db
        .into(_db.members)
        .insertOnConflictUpdate(
          MembersCompanion.insert(
            id: member.id,
            shomitiId: member.shomitiId,
            position: member.position,
            displayName: member.fullName,
            phone: Value(member.phone),
            addressOrWorkplace: Value(member.addressOrWorkplace),
            nidOrPassport: Value(member.nidOrPassport),
            emergencyContactName: Value(member.emergencyContactName),
            emergencyContactPhone: Value(member.emergencyContactPhone),
            notes: Value(member.notes),
            isActive: Value(member.isActive),
            createdAt: member.createdAt,
            updatedAt: Value(member.updatedAt),
          ),
        );
  }

  @override
  Future<void> seedPlaceholders({
    required String shomitiId,
    required int memberCount,
  }) async {
    if (memberCount <= 0) return;

    await _db.transaction(() async {
      final existingCount =
          await (_db.selectOnly(_db.members)
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

  static Member _mapRow(MemberRow row) {
    return Member(
      id: row.id,
      shomitiId: row.shomitiId,
      position: row.position,
      fullName: row.displayName,
      phone: row.phone,
      addressOrWorkplace: row.addressOrWorkplace,
      emergencyContactName: row.emergencyContactName,
      emergencyContactPhone: row.emergencyContactPhone,
      nidOrPassport: row.nidOrPassport,
      notes: row.notes,
      isActive: row.isActive,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}

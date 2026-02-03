import '../../../core/data/local/app_database.dart';
import '../domain/entities/governance_role.dart';
import '../domain/entities/role_assignment.dart';
import '../domain/repositories/roles_repository.dart';

class DriftRolesRepository implements RolesRepository {
  DriftRolesRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<RoleAssignment>> watchRoleAssignments({required String shomitiId}) {
    final query = (_db.select(_db.roleAssignments)
          ..where((t) => t.shomitiId.equals(shomitiId)))
        .watch();

    return query.map(
      (rows) => rows
          .map(
            (row) => RoleAssignment(
              shomitiId: row.shomitiId,
              role: GovernanceRole.values.byName(row.role),
              memberId: row.memberId,
              assignedAt: row.assignedAt,
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<void> setRoleAssignment({
    required String shomitiId,
    required GovernanceRole role,
    required String? memberId,
    required DateTime assignedAt,
  }) async {
    if (memberId == null) {
      await (_db.delete(_db.roleAssignments)
            ..where((t) => t.shomitiId.equals(shomitiId))
            ..where((t) => t.role.equals(role.name)))
          .go();
      return;
    }

    await _db.into(_db.roleAssignments).insertOnConflictUpdate(
          RoleAssignmentsCompanion.insert(
            shomitiId: shomitiId,
            role: role.name,
            memberId: memberId,
            assignedAt: assignedAt,
          ),
        );
  }
}

import '../entities/role_assignment.dart';
import '../repositories/roles_repository.dart';

class WatchRoleAssignments {
  const WatchRoleAssignments(this._rolesRepository);

  final RolesRepository _rolesRepository;

  Stream<List<RoleAssignment>> call({required String shomitiId}) {
    return _rolesRepository.watchRoleAssignments(shomitiId: shomitiId);
  }
}


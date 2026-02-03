import '../repositories/members_repository.dart';

class SeedMembers {
  const SeedMembers(this._membersRepository);

  final MembersRepository _membersRepository;

  Future<void> call({
    required String shomitiId,
    required int memberCount,
  }) {
    return _membersRepository.seedPlaceholders(
      shomitiId: shomitiId,
      memberCount: memberCount,
    );
  }
}


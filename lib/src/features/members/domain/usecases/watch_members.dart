import '../entities/member.dart';
import '../repositories/members_repository.dart';

class WatchMembers {
  const WatchMembers(this._membersRepository);

  final MembersRepository _membersRepository;

  Stream<List<Member>> call({required String shomitiId}) {
    return _membersRepository.watchMembers(shomitiId: shomitiId);
  }
}


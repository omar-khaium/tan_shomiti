import '../entities/member.dart';

abstract class MembersRepository {
  Stream<List<Member>> watchMembers({required String shomitiId});

  Future<List<Member>> listMembers({required String shomitiId});

  Future<Member?> getById({
    required String shomitiId,
    required String memberId,
  });

  Future<void> upsert(Member member);

  /// Creates missing placeholder members if the list is empty.
  Future<void> seedPlaceholders({
    required String shomitiId,
    required int memberCount,
  });
}

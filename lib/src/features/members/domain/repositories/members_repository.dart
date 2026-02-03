import '../entities/member.dart';

abstract class MembersRepository {
  Stream<List<Member>> watchMembers({required String shomitiId});

  /// Creates missing placeholder members if the list is empty.
  Future<void> seedPlaceholders({
    required String shomitiId,
    required int memberCount,
  });
}


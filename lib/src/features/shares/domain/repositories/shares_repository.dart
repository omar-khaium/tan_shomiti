import '../entities/member_share_allocation.dart';

abstract class SharesRepository {
  Stream<List<MemberShareAllocation>> watchAllocations({
    required String shomitiId,
  });

  Future<List<MemberShareAllocation>> listAllocations({
    required String shomitiId,
  });

  Future<void> upsertAllocation(MemberShareAllocation allocation);

  Future<void> upsertAllocations(List<MemberShareAllocation> allocations);
}

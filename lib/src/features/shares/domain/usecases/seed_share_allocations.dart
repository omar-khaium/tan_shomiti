import '../entities/member_share_allocation.dart';
import '../repositories/shares_repository.dart';
import 'shares_exceptions.dart';

class SeedShareAllocations {
  const SeedShareAllocations({required SharesRepository sharesRepository})
    : _sharesRepository = sharesRepository;

  final SharesRepository _sharesRepository;

  /// Ensures allocations exist for every member and the total shares equal
  /// the fixed `totalShares` for the cycle.
  ///
  /// Policy:
  /// - Every member must have at least 1 share.
  /// - No member can exceed `maxSharesPerPerson`.
  /// - Extra shares are distributed in member order.
  Future<Map<String, int>> call({
    required String shomitiId,
    required List<String> memberIds,
    required int totalShares,
    required int maxSharesPerPerson,
    required DateTime now,
  }) async {
    if (memberIds.isEmpty) return const {};

    final minimumShares = memberIds.length;
    final maximumShares = memberIds.length * maxSharesPerPerson;

    if (totalShares < minimumShares || totalShares > maximumShares) {
      throw SharesInvalidConfigurationException(
        'Total shares ($totalShares) must be between $minimumShares and $maximumShares for ${memberIds.length} member(s) with cap $maxSharesPerPerson.',
      );
    }

    final existing = await _sharesRepository.listAllocations(
      shomitiId: shomitiId,
    );
    final sharesByMemberId = <String, int>{
      for (final allocation in existing) allocation.memberId: allocation.shares,
    };

    for (final memberId in memberIds) {
      sharesByMemberId.putIfAbsent(memberId, () => 1);
    }

    final initialSum = memberIds.fold<int>(
      0,
      (sum, id) => sum + (sharesByMemberId[id] ?? 1),
    );
    var remaining = totalShares - initialSum;

    if (remaining < 0) {
      throw SharesTotalExceededException(
        'Too many shares already allocated ($initialSum). Reduce allocations to reach $totalShares total.',
      );
    }

    // Distribute extras in member order.
    for (final memberId in memberIds) {
      if (remaining <= 0) break;
      final current = sharesByMemberId[memberId] ?? 1;
      final canAdd = maxSharesPerPerson - current;
      if (canAdd <= 0) continue;
      final add = remaining < canAdd ? remaining : canAdd;
      sharesByMemberId[memberId] = current + add;
      remaining -= add;
    }

    if (remaining != 0) {
      throw SharesCapExceededException(
        'Cannot distribute remaining shares due to per-person cap ($maxSharesPerPerson).',
      );
    }

    final allocations = [
      for (final memberId in memberIds)
        MemberShareAllocation(
          shomitiId: shomitiId,
          memberId: memberId,
          shares: sharesByMemberId[memberId] ?? 1,
          createdAt: now,
          updatedAt: null,
        ),
    ];
    await _sharesRepository.upsertAllocations(allocations);

    return Map.unmodifiable(sharesByMemberId);
  }
}

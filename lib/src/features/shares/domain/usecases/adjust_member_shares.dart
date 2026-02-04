import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/member_share_allocation.dart';
import '../repositories/shares_repository.dart';
import 'shares_exceptions.dart';

class AdjustMemberShares {
  const AdjustMemberShares({
    required SharesRepository sharesRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _sharesRepository = sharesRepository,
       _appendAuditEvent = appendAuditEvent;

  final SharesRepository _sharesRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<Map<String, int>> call({
    required String shomitiId,
    required String memberId,
    required int delta,
    required int totalShares,
    required int maxSharesPerPerson,
    required DateTime now,
  }) async {
    final allocations = await _sharesRepository.listAllocations(
      shomitiId: shomitiId,
    );
    final sharesByMemberId = <String, int>{
      for (final allocation in allocations)
        allocation.memberId: allocation.shares,
    };

    final existing = sharesByMemberId[memberId] ?? 1;
    final next = existing + delta;

    if (next < 1 || next > maxSharesPerPerson) {
      throw SharesCapExceededException(
        'Shares must be between 1 and $maxSharesPerPerson.',
      );
    }

    final allocated = sharesByMemberId.values.fold<int>(0, (sum, v) => sum + v);
    final nextAllocated = allocated - existing + next;
    if (nextAllocated > totalShares) {
      throw SharesTotalExceededException(
        'No shares remaining. Reduce someone else first.',
      );
    }

    sharesByMemberId[memberId] = next;

    await _sharesRepository.upsertAllocation(
      MemberShareAllocation(
        shomitiId: shomitiId,
        memberId: memberId,
        shares: next,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'shares_allocation_updated',
        occurredAt: now,
        message: 'Updated shares for member $memberId to $next.',
      ),
    );

    return Map.unmodifiable(sharesByMemberId);
  }
}

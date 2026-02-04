import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/shares/domain/entities/member_share_allocation.dart';
import 'package:tan_shomiti/src/features/shares/domain/repositories/shares_repository.dart';
import 'package:tan_shomiti/src/features/shares/domain/usecases/adjust_member_shares.dart';
import 'package:tan_shomiti/src/features/shares/domain/usecases/seed_share_allocations.dart';
import 'package:tan_shomiti/src/features/shares/domain/usecases/shares_exceptions.dart';

class _FakeSharesRepository implements SharesRepository {
  final Map<String, MemberShareAllocation> _store = {};

  @override
  Future<List<MemberShareAllocation>> listAllocations({
    required String shomitiId,
  }) async {
    return _store.values
        .where((a) => a.shomitiId == shomitiId)
        .toList(growable: false);
  }

  @override
  Future<void> upsertAllocation(MemberShareAllocation allocation) async {
    _store['${allocation.shomitiId}:${allocation.memberId}'] = allocation;
  }

  @override
  Future<void> upsertAllocations(
    List<MemberShareAllocation> allocations,
  ) async {
    for (final allocation in allocations) {
      await upsertAllocation(allocation);
    }
  }

  @override
  Stream<List<MemberShareAllocation>> watchAllocations({
    required String shomitiId,
  }) async* {
    yield await listAllocations(shomitiId: shomitiId);
  }
}

class _FakeAuditRepository implements AuditRepository {
  final List<NewAuditEvent> appended = [];

  @override
  Future<void> append(NewAuditEvent event) async {
    appended.add(event);
  }

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) async* {
    yield const [];
  }
}

void main() {
  test('SeedShareAllocations rejects impossible total shares', () async {
    final repo = _FakeSharesRepository();
    final seed = SeedShareAllocations(sharesRepository: repo);

    await expectLater(
      () => seed(
        shomitiId: 's1',
        memberIds: const ['m1', 'm2', 'm3'],
        totalShares: 2,
        maxSharesPerPerson: 2,
        now: DateTime.utc(2026, 1, 1),
      ),
      throwsA(isA<SharesInvalidConfigurationException>()),
    );
  });

  test('SeedShareAllocations distributes extra shares within cap', () async {
    final repo = _FakeSharesRepository();
    final seed = SeedShareAllocations(sharesRepository: repo);

    final map = await seed(
      shomitiId: 's1',
      memberIds: const ['m1', 'm2', 'm3'],
      totalShares: 4,
      maxSharesPerPerson: 2,
      now: DateTime.utc(2026, 1, 1),
    );

    expect(map['m1'], 2);
    expect(map['m2'], 1);
    expect(map['m3'], 1);
  });

  test('AdjustMemberShares prevents exceeding total shares', () async {
    final sharesRepo = _FakeSharesRepository();
    final auditRepo = _FakeAuditRepository();
    final adjust = AdjustMemberShares(
      sharesRepository: sharesRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    final now = DateTime.utc(2026, 1, 1);

    await sharesRepo.upsertAllocations([
      MemberShareAllocation(
        shomitiId: 's1',
        memberId: 'm1',
        shares: 2,
        createdAt: now,
        updatedAt: null,
      ),
      MemberShareAllocation(
        shomitiId: 's1',
        memberId: 'm2',
        shares: 1,
        createdAt: now,
        updatedAt: null,
      ),
      MemberShareAllocation(
        shomitiId: 's1',
        memberId: 'm3',
        shares: 1,
        createdAt: now,
        updatedAt: null,
      ),
    ]);

    await expectLater(
      () => adjust(
        shomitiId: 's1',
        memberId: 'm2',
        delta: 1,
        totalShares: 4,
        maxSharesPerPerson: 2,
        now: now,
      ),
      throwsA(isA<SharesTotalExceededException>()),
    );
  });

  test('AdjustMemberShares appends audit event on success', () async {
    final sharesRepo = _FakeSharesRepository();
    final auditRepo = _FakeAuditRepository();
    final adjust = AdjustMemberShares(
      sharesRepository: sharesRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    final now = DateTime.utc(2026, 1, 1);

    await sharesRepo.upsertAllocations([
      MemberShareAllocation(
        shomitiId: 's1',
        memberId: 'm1',
        shares: 1,
        createdAt: now,
        updatedAt: null,
      ),
      MemberShareAllocation(
        shomitiId: 's1',
        memberId: 'm2',
        shares: 1,
        createdAt: now,
        updatedAt: null,
      ),
    ]);

    final updated = await adjust(
      shomitiId: 's1',
      memberId: 'm2',
      delta: 1,
      totalShares: 3,
      maxSharesPerPerson: 2,
      now: now,
    );

    expect(updated['m2'], 2);
    expect(auditRepo.appended.single.action, 'shares_allocation_updated');
  });
}

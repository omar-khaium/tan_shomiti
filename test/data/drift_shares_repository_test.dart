import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/shares/data/drift_shares_repository.dart';
import 'package:tan_shomiti/src/features/shares/domain/entities/member_share_allocation.dart';

void main() {
  test('DriftSharesRepository upserts and lists allocations', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);

    final repo = DriftSharesRepository(db);

    final now = DateTime.utc(2026, 1, 1, 10);
    await repo.upsertAllocation(
      MemberShareAllocation(
        shomitiId: 's1',
        memberId: 'm1',
        shares: 2,
        createdAt: now,
        updatedAt: now,
      ),
    );

    await repo.upsertAllocation(
      MemberShareAllocation(
        shomitiId: 's1',
        memberId: 'm2',
        shares: 1,
        createdAt: now,
        updatedAt: null,
      ),
    );

    final list = await repo.listAllocations(shomitiId: 's1');
    expect(list, hasLength(2));
    expect(list.first.memberId, 'm1');
    expect(list.first.shares, 2);
    expect(list.last.memberId, 'm2');
    expect(list.last.shares, 1);
  });
}

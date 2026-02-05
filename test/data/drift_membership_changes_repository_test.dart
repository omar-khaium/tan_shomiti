import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/membership_changes/data/drift_membership_changes_repository.dart';
import 'package:tan_shomiti/src/features/membership_changes/domain/entities/membership_change_request.dart';
import 'package:tan_shomiti/src/features/membership_changes/domain/usecases/propose_replacement.dart';
import 'package:tan_shomiti/src/features/membership_changes/domain/usecases/request_exit.dart';

class _FakeAuditRepository implements AuditRepository {
  @override
  Future<void> append(NewAuditEvent event) async {}

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) async* {
    yield const [];
  }
}

void main() {
  test('DriftMembershipChangesRepository persists replacement proposal', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);

    final now = DateTime.utc(2026, 1, 1);

    await db.into(db.shomitis).insert(
      ShomitisCompanion.insert(
        id: 'active',
        name: 'Demo',
        startDate: now,
        createdAt: now,
        activeRuleSetVersionId: 'rsv_1',
      ),
    );

    await db.batch((b) {
      b.insertAll(db.members, [
        MembersCompanion.insert(
          id: 'm_active_1',
          shomitiId: 'active',
          position: 1,
          displayName: 'Member 1',
          createdAt: now,
        ),
        MembersCompanion.insert(
          id: 'm_active_2',
          shomitiId: 'active',
          position: 2,
          displayName: 'Member 2',
          createdAt: now,
        ),
      ]);
    });

    final repo = DriftMembershipChangesRepository(db);
    final audit = AppendAuditEvent(_FakeAuditRepository());

    final requestExit = RequestExit(
      membershipChangesRepository: repo,
      appendAuditEvent: audit,
    );
    final proposeReplacement = ProposeReplacement(
      membershipChangesRepository: repo,
      appendAuditEvent: audit,
    );

    final request = await requestExit(
      shomitiId: 'active',
      memberId: 'm_active_1',
      now: now,
    );

    await proposeReplacement(
      shomitiId: 'active',
      outgoingMemberId: 'm_active_1',
      replacementName: 'Replacement',
      replacementPhone: '01800000000',
      now: now,
    );

    final loaded = await repo.getById(shomitiId: 'active', requestId: request.id);
    expect(loaded, isNotNull);
    expect(loaded!.type, MembershipChangeType.replacement);
    expect(loaded.replacementCandidateName, 'Replacement');
  });
}


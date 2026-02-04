import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/members/data/drift_members_repository.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';

void main() {
  test(
    'DriftMembersRepository upserts and retrieves full member profile',
    () async {
      final db = AppDatabase.memory();
      addTearDown(db.close);

      final repo = DriftMembersRepository(db);

      final createdAt = DateTime.utc(2026, 1, 1, 10);
      final member = Member(
        id: 'm1',
        shomitiId: 's1',
        position: 1,
        fullName: 'Alice',
        phone: '01700000000',
        addressOrWorkplace: 'Dhaka',
        emergencyContactName: 'Bob',
        emergencyContactPhone: '01800000000',
        nidOrPassport: 'NID123',
        notes: 'Test',
        isActive: true,
        createdAt: createdAt,
        updatedAt: createdAt,
      );

      await repo.upsert(member);

      final fetched = await repo.getById(shomitiId: 's1', memberId: 'm1');
      expect(fetched, isNotNull);
      expect(fetched!.fullName, 'Alice');
      expect(fetched.phone, '01700000000');
      expect(fetched.addressOrWorkplace, 'Dhaka');
      expect(fetched.emergencyContactName, 'Bob');
      expect(fetched.emergencyContactPhone, '01800000000');
      expect(fetched.nidOrPassport, 'NID123');
      expect(fetched.notes, 'Test');
      expect(fetched.isActive, isTrue);

      final list = await repo.listMembers(shomitiId: 's1');
      expect(list, hasLength(1));
      expect(list.single.id, 'm1');
    },
  );

  test(
    'DriftMembersRepository seedPlaceholders fills positions sequentially',
    () async {
      final db = AppDatabase.memory();
      addTearDown(db.close);

      final repo = DriftMembersRepository(db);

      await repo.seedPlaceholders(shomitiId: 's1', memberCount: 2);

      final members = await repo.listMembers(shomitiId: 's1');
      expect(members, hasLength(2));
      expect(members.first.position, 1);
      expect(members.last.position, 2);
      expect(members.first.fullName, 'Member 1');
      expect(members.first.phone, isNull);
      expect(members.first.isActive, isTrue);
    },
  );
}

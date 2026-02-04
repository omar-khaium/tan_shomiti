import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member_profile_input.dart';
import 'package:tan_shomiti/src/features/members/domain/repositories/members_repository.dart';
import 'package:tan_shomiti/src/features/members/domain/usecases/add_member.dart';
import 'package:tan_shomiti/src/features/members/domain/usecases/deactivate_member.dart';
import 'package:tan_shomiti/src/features/members/domain/usecases/member_write_exceptions.dart';
import 'package:tan_shomiti/src/features/members/domain/usecases/update_member.dart';

void main() {
  const shomitiId = 's1';

  MemberProfileInput profile({
    String fullName = 'Alice',
    String phone = '01700000000',
    String addressOrWorkplace = 'Dhaka',
    String emergencyContactName = 'Bob',
    String emergencyContactPhone = '01800000000',
    String? nidOrPassport,
    String? notes,
  }) {
    return MemberProfileInput(
      fullName: fullName,
      phone: phone,
      addressOrWorkplace: addressOrWorkplace,
      emergencyContactName: emergencyContactName,
      emergencyContactPhone: emergencyContactPhone,
      nidOrPassport: nidOrPassport,
      notes: notes,
    );
  }

  test('AddMember throws when joining is closed', () async {
    final membersRepository = _FakeMembersRepository();
    final auditRepository = _FakeAuditRepository();

    final usecase = AddMember(
      membersRepository: membersRepository,
      appendAuditEvent: AppendAuditEvent(auditRepository),
    );

    await expectLater(
      usecase(shomitiId: shomitiId, profile: profile(), isJoiningClosed: true),
      throwsA(isA<MemberJoiningClosedException>()),
    );
    expect(auditRepository.appended, isEmpty);
  });

  test('AddMember validates required fields', () async {
    final membersRepository = _FakeMembersRepository();
    final auditRepository = _FakeAuditRepository();

    final usecase = AddMember(
      membersRepository: membersRepository,
      appendAuditEvent: AppendAuditEvent(auditRepository),
    );

    await expectLater(
      usecase(
        shomitiId: shomitiId,
        profile: profile(fullName: ''),
        isJoiningClosed: false,
      ),
      throwsA(isA<MemberValidationException>()),
    );
    expect(auditRepository.appended, isEmpty);
  });

  test('AddMember rejects duplicate phone number', () async {
    final membersRepository = _FakeMembersRepository();
    final auditRepository = _FakeAuditRepository();

    await membersRepository.upsert(
      _member(
        id: 'm_existing',
        shomitiId: shomitiId,
        position: 1,
        fullName: 'Existing',
        phone: '017 0000 0000',
      ),
    );

    final usecase = AddMember(
      membersRepository: membersRepository,
      appendAuditEvent: AppendAuditEvent(auditRepository),
    );

    await expectLater(
      usecase(
        shomitiId: shomitiId,
        profile: profile(phone: '+8801700000000'),
        isJoiningClosed: false,
      ),
      throwsA(
        isA<MemberDuplicateException>().having(
          (e) => e.field,
          'field',
          MemberDuplicateField.phone,
        ),
      ),
    );
  });

  test('AddMember rejects duplicate NID/passport', () async {
    final membersRepository = _FakeMembersRepository();
    final auditRepository = _FakeAuditRepository();

    await membersRepository.upsert(
      _member(
        id: 'm_existing',
        shomitiId: shomitiId,
        position: 1,
        fullName: 'Existing',
        phone: '01700000001',
        nidOrPassport: 'A-123-456',
      ),
    );

    final usecase = AddMember(
      membersRepository: membersRepository,
      appendAuditEvent: AppendAuditEvent(auditRepository),
    );

    await expectLater(
      usecase(
        shomitiId: shomitiId,
        profile: profile(phone: '01700000000', nidOrPassport: 'a123456'),
        isJoiningClosed: false,
      ),
      throwsA(
        isA<MemberDuplicateException>().having(
          (e) => e.field,
          'field',
          MemberDuplicateField.nidOrPassport,
        ),
      ),
    );
  });

  test('UpdateMember rejects duplicates against other members', () async {
    final membersRepository = _FakeMembersRepository();
    final auditRepository = _FakeAuditRepository();

    await membersRepository.upsert(
      _member(
        id: 'm1',
        shomitiId: shomitiId,
        position: 1,
        fullName: 'Alice',
        phone: '01700000000',
      ),
    );
    await membersRepository.upsert(
      _member(
        id: 'm2',
        shomitiId: shomitiId,
        position: 2,
        fullName: 'Bob',
        phone: '01800000000',
      ),
    );

    final usecase = UpdateMember(
      membersRepository: membersRepository,
      appendAuditEvent: AppendAuditEvent(auditRepository),
    );

    await expectLater(
      usecase(
        shomitiId: shomitiId,
        memberId: 'm1',
        profile: profile(fullName: 'Alice', phone: '01800000000'),
      ),
      throwsA(
        isA<MemberDuplicateException>().having(
          (e) => e.field,
          'field',
          MemberDuplicateField.phone,
        ),
      ),
    );
  });

  test('DeactivateMember marks member inactive', () async {
    final membersRepository = _FakeMembersRepository();
    final auditRepository = _FakeAuditRepository();

    await membersRepository.upsert(
      _member(
        id: 'm1',
        shomitiId: shomitiId,
        position: 1,
        fullName: 'Alice',
        phone: '01700000000',
        isActive: true,
      ),
    );

    final usecase = DeactivateMember(
      membersRepository: membersRepository,
      appendAuditEvent: AppendAuditEvent(auditRepository),
    );

    await usecase(shomitiId: shomitiId, memberId: 'm1');

    final updated = await membersRepository.getById(
      shomitiId: shomitiId,
      memberId: 'm1',
    );
    expect(updated, isNotNull);
    expect(updated!.isActive, isFalse);

    expect(auditRepository.appended, hasLength(1));
    expect(auditRepository.appended.single.action, 'deactivated_member');
  });
}

Member _member({
  required String id,
  required String shomitiId,
  required int position,
  required String fullName,
  required String phone,
  String? nidOrPassport,
  bool isActive = true,
}) {
  return Member(
    id: id,
    shomitiId: shomitiId,
    position: position,
    fullName: fullName,
    phone: phone,
    addressOrWorkplace: 'Dhaka',
    emergencyContactName: 'Emergency',
    emergencyContactPhone: '01900000000',
    nidOrPassport: nidOrPassport,
    notes: null,
    isActive: isActive,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: null,
  );
}

class _FakeMembersRepository implements MembersRepository {
  final List<Member> _members = [];

  @override
  Future<Member?> getById({
    required String shomitiId,
    required String memberId,
  }) async {
    for (final member in _members) {
      if (member.shomitiId == shomitiId && member.id == memberId) {
        return member;
      }
    }
    return null;
  }

  @override
  Future<List<Member>> listMembers({required String shomitiId}) async {
    final filtered = _members
        .where((m) => m.shomitiId == shomitiId)
        .toList(growable: false);
    filtered.sort((a, b) => a.position.compareTo(b.position));
    return filtered;
  }

  @override
  Future<void> seedPlaceholders({
    required String shomitiId,
    required int memberCount,
  }) async {}

  @override
  Future<void> upsert(Member member) async {
    _members.removeWhere((m) => m.id == member.id);
    _members.add(member);
  }

  @override
  Stream<List<Member>> watchMembers({required String shomitiId}) {
    return Stream.fromFuture(listMembers(shomitiId: shomitiId));
  }
}

class _FakeAuditRepository implements AuditRepository {
  final List<NewAuditEvent> appended = [];

  @override
  Future<void> append(NewAuditEvent event) async {
    appended.add(event);
  }

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) {
    return const Stream.empty();
  }
}

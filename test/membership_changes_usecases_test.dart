import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';
import 'package:tan_shomiti/src/features/members/domain/repositories/members_repository.dart';
import 'package:tan_shomiti/src/features/membership_changes/domain/entities/membership_change_approval.dart';
import 'package:tan_shomiti/src/features/membership_changes/domain/entities/membership_change_request.dart';
import 'package:tan_shomiti/src/features/membership_changes/domain/repositories/membership_changes_repository.dart';
import 'package:tan_shomiti/src/features/membership_changes/domain/usecases/approve_membership_change.dart';
import 'package:tan_shomiti/src/features/membership_changes/domain/usecases/propose_replacement.dart';
import 'package:tan_shomiti/src/features/membership_changes/domain/usecases/remove_for_misconduct.dart';
import 'package:tan_shomiti/src/features/membership_changes/domain/usecases/request_exit.dart';

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

class _FakeMembershipChangesRepository implements MembershipChangesRepository {
  final Map<String, MembershipChangeRequest> _requests = {};
  final Map<String, List<MembershipChangeApproval>> _approvalsByRequest = {};

  @override
  Future<List<MembershipChangeRequest>> listRequests({
    required String shomitiId,
  }) async {
    return _requests.values
        .where((r) => r.shomitiId == shomitiId)
        .toList(growable: false);
  }

  @override
  Future<MembershipChangeRequest?> getById({
    required String shomitiId,
    required String requestId,
  }) async {
    final request = _requests[requestId];
    if (request == null || request.shomitiId != shomitiId) return null;
    return request;
  }

  @override
  Future<MembershipChangeRequest?> getOpenRequestForMember({
    required String shomitiId,
    required String outgoingMemberId,
  }) async {
    return _requests.values
        .where((r) => r.shomitiId == shomitiId)
        .where((r) => r.outgoingMemberId == outgoingMemberId)
        .where((r) => r.finalizedAt == null)
        .cast<MembershipChangeRequest?>()
        .firstOrNull;
  }

  @override
  Future<void> upsertRequest(MembershipChangeRequest request) async {
    _requests[request.id] = request;
  }

  @override
  Future<List<MembershipChangeApproval>> listApprovals({
    required String shomitiId,
    required String requestId,
  }) async {
    return _approvalsByRequest[requestId] ?? const [];
  }

  @override
  Future<void> upsertApproval(MembershipChangeApproval approval) async {
    final list = (_approvalsByRequest[approval.requestId] ??= []);
    list.removeWhere((a) => a.approverMemberId == approval.approverMemberId);
    list.add(approval);
  }
}

class _FakeMembersRepository implements MembersRepository {
  _FakeMembersRepository(this._members);

  final Map<String, Member> _members;

  @override
  Stream<List<Member>> watchMembers({required String shomitiId}) async* {
    yield await listMembers(shomitiId: shomitiId);
  }

  @override
  Future<List<Member>> listMembers({required String shomitiId}) async {
    return _members.values
        .where((m) => m.shomitiId == shomitiId)
        .toList(growable: false);
  }

  @override
  Future<Member?> getById({
    required String shomitiId,
    required String memberId,
  }) async {
    final member = _members[memberId];
    if (member == null || member.shomitiId != shomitiId) return null;
    return member;
  }

  @override
  Future<void> upsert(Member member) async {
    _members[member.id] = member;
  }

  @override
  Future<void> seedPlaceholders({
    required String shomitiId,
    required int memberCount,
  }) async {}
}

extension<T> on Iterable<T> {
  // ignore: unnecessary_this
  T? get firstOrNull => this.isEmpty ? null : this.first;
}

void main() {
  test('RequestExit defaults to requiring replacement', () async {
    final repo = _FakeMembershipChangesRepository();
    final audit = _FakeAuditRepository();
    final requestExit = RequestExit(
      membershipChangesRepository: repo,
      appendAuditEvent: AppendAuditEvent(audit),
    );

    final now = DateTime.utc(2026, 1, 1);
    final request = await requestExit(
      shomitiId: 's1',
      memberId: 'm1',
      now: now,
    );

    expect(request.requiresReplacement, isTrue);
    expect(audit.appended.single.action, 'exit_requested');
  });

  test('ApproveMembershipChange requires unanimous approvals to finalize', () async {
    final membershipRepo = _FakeMembershipChangesRepository();
    final audit = _FakeAuditRepository();
    final now = DateTime.utc(2026, 1, 1);

    final membersRepo = _FakeMembersRepository({
      'm1': Member(
        id: 'm1',
        shomitiId: 's1',
        position: 1,
        fullName: 'Outgoing',
        phone: '01700000000',
        addressOrWorkplace: 'Addr',
        emergencyContactName: 'EC',
        emergencyContactPhone: '01700000001',
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      ),
      'm2': Member(
        id: 'm2',
        shomitiId: 's1',
        position: 2,
        fullName: 'Approver 2',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      ),
      'm3': Member(
        id: 'm3',
        shomitiId: 's1',
        position: 3,
        fullName: 'Approver 3',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      ),
    });

    final requestExit = RequestExit(
      membershipChangesRepository: membershipRepo,
      appendAuditEvent: AppendAuditEvent(audit),
    );
    final proposeReplacement = ProposeReplacement(
      membershipChangesRepository: membershipRepo,
      appendAuditEvent: AppendAuditEvent(audit),
    );
    final approve = ApproveMembershipChange(
      membershipChangesRepository: membershipRepo,
      membersRepository: membersRepo,
      appendAuditEvent: AppendAuditEvent(audit),
    );

    final request = await requestExit(
      shomitiId: 's1',
      memberId: 'm1',
      now: now,
    );
    await proposeReplacement(
      shomitiId: 's1',
      outgoingMemberId: 'm1',
      replacementName: 'Replacement',
      replacementPhone: '01800000000',
      now: now,
    );

    await approve(
      shomitiId: 's1',
      requestId: request.id,
      outgoingMemberId: 'm1',
      approverMemberId: 'm2',
      now: now,
    );

    expect((await membershipRepo.getById(shomitiId: 's1', requestId: request.id))!.finalizedAt, isNull);
    expect((await membersRepo.getById(shomitiId: 's1', memberId: 'm1'))!.fullName, 'Outgoing');

    await approve(
      shomitiId: 's1',
      requestId: request.id,
      outgoingMemberId: 'm1',
      approverMemberId: 'm3',
      now: now,
    );

    final finalized = await membershipRepo.getById(
      shomitiId: 's1',
      requestId: request.id,
    );
    expect(finalized!.finalizedAt, isNotNull);
    expect(
      (await membersRepo.getById(shomitiId: 's1', memberId: 'm1'))!.fullName,
      'Replacement',
    );
  });

  test('Removal finalization deactivates member after unanimous approval', () async {
    final membershipRepo = _FakeMembershipChangesRepository();
    final audit = _FakeAuditRepository();
    final now = DateTime.utc(2026, 1, 1);

    final membersRepo = _FakeMembersRepository({
      'm1': Member(
        id: 'm1',
        shomitiId: 's1',
        position: 1,
        fullName: 'Target',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      ),
      'm2': Member(
        id: 'm2',
        shomitiId: 's1',
        position: 2,
        fullName: 'Approver 2',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      ),
      'm3': Member(
        id: 'm3',
        shomitiId: 's1',
        position: 3,
        fullName: 'Approver 3',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      ),
    });

    final removeForMisconduct = RemoveForMisconduct(
      membershipChangesRepository: membershipRepo,
      appendAuditEvent: AppendAuditEvent(audit),
    );
    final approve = ApproveMembershipChange(
      membershipChangesRepository: membershipRepo,
      membersRepository: membersRepo,
      appendAuditEvent: AppendAuditEvent(audit),
    );

    final request = await removeForMisconduct(
      shomitiId: 's1',
      memberId: 'm1',
      reasonCode: 'repeated_default',
      now: now,
    );

    await approve(
      shomitiId: 's1',
      requestId: request.id,
      outgoingMemberId: 'm1',
      approverMemberId: 'm2',
      now: now,
    );
    expect((await membersRepo.getById(shomitiId: 's1', memberId: 'm1'))!.isActive, isTrue);

    await approve(
      shomitiId: 's1',
      requestId: request.id,
      outgoingMemberId: 'm1',
      approverMemberId: 'm3',
      now: now,
    );
    expect((await membersRepo.getById(shomitiId: 's1', memberId: 'm1'))!.isActive, isFalse);
  });
}

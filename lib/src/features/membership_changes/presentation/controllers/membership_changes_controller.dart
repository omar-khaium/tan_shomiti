import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../members/domain/entities/member.dart';
import '../../../members/presentation/providers/members_providers.dart';
import '../../domain/entities/membership_change_request.dart';
import '../models/membership_change_ui_models.dart';
import '../providers/membership_changes_domain_providers.dart';

class MembershipChangesController
    extends AutoDisposeAsyncNotifier<MembershipChangesUiState?> {
  String? _shomitiId;
  List<Member> _members = const [];

  @override
  Future<MembershipChangesUiState?> build() => _load();

  Future<MembershipChangesUiState?> _load() async {
    final context = await ref.watch(membersContextProvider.future);
    if (context == null) return null;

    await ref.watch(seedMembersProvider)(
      shomitiId: context.shomitiId,
      memberCount: context.rules.memberCount,
    );

    _shomitiId = context.shomitiId;
    _members = await ref
        .watch(membersRepositoryProvider)
        .listMembers(shomitiId: context.shomitiId);

    final repo = ref.watch(membershipChangesRepositoryProvider);
    final allRequests = await repo.listRequests(shomitiId: context.shomitiId);

    final openByMemberId = <String, MembershipChangeRequest>{
      for (final r in allRequests.where((r) => r.isOpen))
        r.outgoingMemberId: r,
    };

    final latestByMemberId = <String, MembershipChangeRequest>{};
    for (final r in allRequests) {
      latestByMemberId.putIfAbsent(r.outgoingMemberId, () => r);
    }

    final approvalsByRequestId = <String, List<String>>{};
    for (final request in openByMemberId.values) {
      final approvals = await repo.listApprovals(
        shomitiId: context.shomitiId,
        requestId: request.id,
      );
      approvalsByRequestId[request.id] = approvals
          .map((a) => a.approverMemberId)
          .toList(growable: false);
    }

    final activeMemberCount = _members.where((m) => m.isActive).length;

    final approverOptions = [
      for (final m in _members)
        ApproverOption(
          memberId: m.id,
          position: m.position,
          displayName: m.fullName,
          isActive: m.isActive,
        ),
    ];

    final rows = [
      for (final m in _members)
        _rowForMember(
          member: m,
          openRequest: openByMemberId[m.id],
          latestRequest: latestByMemberId[m.id],
          approvalsByRequestId: approvalsByRequestId,
          activeMemberCount: activeMemberCount,
        ),
    ];

    return MembershipChangesUiState(
      rows: List.unmodifiable(rows),
      members: List.unmodifiable(approverOptions),
    );
  }

  MemberChangeRow _rowForMember({
    required Member member,
    required MembershipChangeRequest? openRequest,
    required MembershipChangeRequest? latestRequest,
    required Map<String, List<String>> approvalsByRequestId,
    required int activeMemberCount,
  }) {
    if (!member.isActive &&
        latestRequest != null &&
        latestRequest.type == MembershipChangeType.removal &&
        latestRequest.finalizedAt != null) {
      return MemberChangeRow(
        memberId: member.id,
        position: member.position,
        displayName: member.fullName,
        status: MemberChangeStatus.removedForMisconduct,
        activeRequestId: null,
        approvalsCount: 0,
        approvalsRequired: 0,
        approvedByMemberIds: const [],
        replacementCandidateName: null,
        replacementCandidatePhone: null,
      );
    }

    if (openRequest == null) {
      return MemberChangeRow(
        memberId: member.id,
        position: member.position,
        displayName: member.fullName,
        status: MemberChangeStatus.active,
        activeRequestId: null,
        approvalsCount: 0,
        approvalsRequired: 0,
        approvedByMemberIds: const [],
        replacementCandidateName: null,
        replacementCandidatePhone: null,
      );
    }

    final approvedBy = approvalsByRequestId[openRequest.id] ?? const [];
    final approvalsRequired = activeMemberCount > 0 ? activeMemberCount - 1 : 0;

    return MemberChangeRow(
      memberId: member.id,
      position: member.position,
      displayName: member.fullName,
      status: switch (openRequest.type) {
        MembershipChangeType.exit => MemberChangeStatus.exitRequested,
        MembershipChangeType.replacement =>
          MemberChangeStatus.replacementProposed,
        MembershipChangeType.removal => MemberChangeStatus.removalProposed,
      },
      activeRequestId: openRequest.id,
      approvalsCount: approvedBy.length,
      approvalsRequired: approvalsRequired,
      approvedByMemberIds: List.unmodifiable(approvedBy),
      replacementCandidateName: openRequest.replacementCandidateName,
      replacementCandidatePhone: openRequest.replacementCandidatePhone,
    );
  }

  Future<void> requestExit(String memberId) async {
    final shomitiId =
        _shomitiId ??
        (await ref.watch(membersContextProvider.future))?.shomitiId;
    if (shomitiId == null) return;

    await ref.watch(requestExitProvider)(
      shomitiId: shomitiId,
      memberId: memberId,
      requiresReplacement: true,
    );

    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }

  Future<void> proposeReplacement({
    required String memberId,
    required String replacementName,
    required String replacementPhone,
  }) async {
    final shomitiId =
        _shomitiId ??
        (await ref.watch(membersContextProvider.future))?.shomitiId;
    if (shomitiId == null) return;

    await ref.watch(proposeReplacementProvider)(
      shomitiId: shomitiId,
      outgoingMemberId: memberId,
      replacementName: replacementName,
      replacementPhone: replacementPhone,
    );

    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }

  Future<void> removeForMisconduct({
    required String memberId,
    required String reasonCode,
    required String? details,
  }) async {
    final shomitiId =
        _shomitiId ??
        (await ref.watch(membersContextProvider.future))?.shomitiId;
    if (shomitiId == null) return;

    await ref.watch(removeForMisconductProvider)(
      shomitiId: shomitiId,
      memberId: memberId,
      reasonCode: reasonCode,
      details: details,
    );

    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }

  Future<void> approve({
    required String requestId,
    required String outgoingMemberId,
    required String approverMemberId,
  }) async {
    final shomitiId =
        _shomitiId ??
        (await ref.watch(membersContextProvider.future))?.shomitiId;
    if (shomitiId == null) return;

    await ref.watch(approveMembershipChangeProvider)(
      shomitiId: shomitiId,
      requestId: requestId,
      outgoingMemberId: outgoingMemberId,
      approverMemberId: approverMemberId,
    );

    state = const AsyncValue.loading();
    state = AsyncValue.data(await _load());
  }
}

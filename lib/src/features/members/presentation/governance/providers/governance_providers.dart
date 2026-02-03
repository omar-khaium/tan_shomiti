import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/local/app_database_provider.dart';
import '../../../../audit/presentation/providers/audit_providers.dart';
import '../../../../rules/presentation/providers/rules_providers.dart';
import '../../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import '../../../data/drift_member_consents_repository.dart';
import '../../../data/drift_members_repository.dart';
import '../../../data/drift_roles_repository.dart';
import '../../../domain/entities/governance_role.dart';
import '../../../domain/entities/member.dart';
import '../../../domain/entities/member_consent.dart';
import '../../../domain/entities/role_assignment.dart';
import '../../../domain/policies/governance_readiness.dart';
import '../../../domain/repositories/member_consents_repository.dart';
import '../../../domain/repositories/members_repository.dart';
import '../../../domain/repositories/roles_repository.dart';
import '../../../domain/usecases/assign_role.dart';
import '../../../domain/usecases/record_member_consent.dart';
import '../../../domain/usecases/seed_members.dart';
import '../../../domain/usecases/watch_member_consents.dart';
import '../../../domain/usecases/watch_members.dart';
import '../../../domain/usecases/watch_role_assignments.dart';
import '../models/governance_ui_state.dart';

final membersRepositoryProvider = Provider<MembersRepository>((ref) {
  return DriftMembersRepository(ref.watch(appDatabaseProvider));
});

final rolesRepositoryProvider = Provider<RolesRepository>((ref) {
  return DriftRolesRepository(ref.watch(appDatabaseProvider));
});

final memberConsentsRepositoryProvider = Provider<MemberConsentsRepository>((
  ref,
) {
  return DriftMemberConsentsRepository(ref.watch(appDatabaseProvider));
});

final seedMembersProvider = Provider<SeedMembers>((ref) {
  return SeedMembers(ref.watch(membersRepositoryProvider));
});

final watchMembersProvider = Provider<WatchMembers>((ref) {
  return WatchMembers(ref.watch(membersRepositoryProvider));
});

final watchRoleAssignmentsProvider = Provider<WatchRoleAssignments>((ref) {
  return WatchRoleAssignments(ref.watch(rolesRepositoryProvider));
});

final watchMemberConsentsProvider = Provider<WatchMemberConsents>((ref) {
  return WatchMemberConsents(ref.watch(memberConsentsRepositoryProvider));
});

final assignRoleProvider = Provider<AssignRole>((ref) {
  return AssignRole(
    rolesRepository: ref.watch(rolesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final recordMemberConsentProvider = Provider<RecordMemberConsent>((ref) {
  return RecordMemberConsent(
    consentsRepository: ref.watch(memberConsentsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

class GovernanceContext {
  const GovernanceContext({
    required this.shomitiId,
    required this.ruleSetVersionId,
    required this.requiredMemberCount,
  });

  final String shomitiId;
  final String ruleSetVersionId;
  final int requiredMemberCount;
}

final governanceContextProvider =
    FutureProvider.autoDispose<GovernanceContext?>((ref) async {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) return null;

  final version = await ref
      .watch(rulesRepositoryProvider)
      .getById(shomiti.activeRuleSetVersionId);
  if (version == null) return null;

  final requiredMemberCount = version.snapshot.memberCount;
  await ref.watch(seedMembersProvider)(
        shomitiId: shomiti.id,
        memberCount: requiredMemberCount,
      );

  return GovernanceContext(
    shomitiId: shomiti.id,
    ruleSetVersionId: version.id,
    requiredMemberCount: requiredMemberCount,
  );
});

final governanceMembersProvider =
    StreamProvider.autoDispose<List<Member>>((ref) async* {
  final context = await ref.watch(governanceContextProvider.future);
  if (context == null) {
    yield const [];
    return;
  }

  yield* ref.watch(watchMembersProvider)(shomitiId: context.shomitiId);
});

final governanceRoleAssignmentsProvider =
    StreamProvider.autoDispose<List<RoleAssignment>>((ref) async* {
  final context = await ref.watch(governanceContextProvider.future);
  if (context == null) {
    yield const [];
    return;
  }

  yield* ref.watch(watchRoleAssignmentsProvider)(shomitiId: context.shomitiId);
});

final governanceMemberConsentsProvider =
    StreamProvider.autoDispose<List<MemberConsent>>((ref) async* {
  final context = await ref.watch(governanceContextProvider.future);
  if (context == null) {
    yield const [];
    return;
  }

  yield* ref.watch(watchMemberConsentsProvider)(
        shomitiId: context.shomitiId,
        ruleSetVersionId: context.ruleSetVersionId,
      );
});

final governanceUiStateProvider =
    Provider.autoDispose<AsyncValue<GovernanceUiState?>>((ref) {
  final context = ref.watch(governanceContextProvider);
  final members = ref.watch(governanceMembersProvider);
  final roles = ref.watch(governanceRoleAssignmentsProvider);
  final consents = ref.watch(governanceMemberConsentsProvider);

  if (context.isLoading || members.isLoading || roles.isLoading || consents.isLoading) {
    return const AsyncValue.loading();
  }
  if (context.hasError) {
    return AsyncValue.error(context.error!, context.stackTrace ?? StackTrace.current);
  }
  if (members.hasError) {
    return AsyncValue.error(members.error!, members.stackTrace ?? StackTrace.current);
  }
  if (roles.hasError) {
    return AsyncValue.error(roles.error!, roles.stackTrace ?? StackTrace.current);
  }
  if (consents.hasError) {
    return AsyncValue.error(consents.error!, consents.stackTrace ?? StackTrace.current);
  }

  final ctx = context.value;
  if (ctx == null) return const AsyncValue.data(null);

  final roleAssignments = <GovernanceRole, String?>{
    GovernanceRole.coordinator: null,
    GovernanceRole.treasurer: null,
    GovernanceRole.auditor: null,
  };

  for (final assignment in roles.value ?? const <RoleAssignment>[]) {
    roleAssignments[assignment.role] = assignment.memberId;
  }

  final consentsByMemberId = <String, MemberConsent>{};
  for (final consent in consents.value ?? const <MemberConsent>[]) {
    consentsByMemberId[consent.memberId] = consent;
  }

  final readiness = GovernanceReadiness(
    requiredMemberCount: ctx.requiredMemberCount,
  );

  final isReady = readiness.isReady(
    roleAssignments: roleAssignments,
    signedMemberIds: consentsByMemberId.keys.toSet(),
  );

  final state = GovernanceUiState(
    shomitiId: ctx.shomitiId,
    ruleSetVersionId: ctx.ruleSetVersionId,
    requiredMemberCount: ctx.requiredMemberCount,
    members: members.value ?? const <Member>[],
    roleAssignments: roleAssignments,
    consentsByMemberId: consentsByMemberId,
    isGovernanceReady: isReady,
  );

  return AsyncValue.data(state);
});

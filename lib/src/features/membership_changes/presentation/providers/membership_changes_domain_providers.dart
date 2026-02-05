import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../members/presentation/providers/members_providers.dart';
import '../../data/drift_membership_changes_repository.dart';
import '../../domain/repositories/membership_changes_repository.dart';
import '../../domain/usecases/approve_membership_change.dart';
import '../../domain/usecases/propose_replacement.dart';
import '../../domain/usecases/remove_for_misconduct.dart';
import '../../domain/usecases/request_exit.dart';

final membershipChangesRepositoryProvider = Provider<MembershipChangesRepository>(
  (ref) => DriftMembershipChangesRepository(ref.watch(appDatabaseProvider)),
);

final requestExitProvider = Provider<RequestExit>((ref) {
  return RequestExit(
    membershipChangesRepository: ref.watch(membershipChangesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final proposeReplacementProvider = Provider<ProposeReplacement>((ref) {
  return ProposeReplacement(
    membershipChangesRepository: ref.watch(membershipChangesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final removeForMisconductProvider = Provider<RemoveForMisconduct>((ref) {
  return RemoveForMisconduct(
    membershipChangesRepository: ref.watch(membershipChangesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final approveMembershipChangeProvider = Provider<ApproveMembershipChange>((ref) {
  return ApproveMembershipChange(
    membershipChangesRepository: ref.watch(membershipChangesRepositoryProvider),
    membersRepository: ref.watch(membersRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});


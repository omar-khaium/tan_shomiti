import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../rules/domain/entities/rule_set_snapshot.dart';
import '../../../rules/presentation/providers/rules_providers.dart';
import '../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import '../../data/drift_members_repository.dart';
import '../../domain/repositories/members_repository.dart';
import '../../domain/usecases/add_member.dart';
import '../../domain/usecases/deactivate_member.dart';
import '../../domain/usecases/seed_members.dart';
import '../../domain/usecases/update_member.dart';
import '../../domain/usecases/watch_members.dart';
import '../models/members_ui_state.dart';

final membersRepositoryProvider = Provider<MembersRepository>((ref) {
  return DriftMembersRepository(ref.watch(appDatabaseProvider));
});

final watchMembersProvider = Provider<WatchMembers>((ref) {
  return WatchMembers(ref.watch(membersRepositoryProvider));
});

final seedMembersProvider = Provider<SeedMembers>((ref) {
  return SeedMembers(ref.watch(membersRepositoryProvider));
});

final addMemberProvider = Provider<AddMember>((ref) {
  return AddMember(
    membersRepository: ref.watch(membersRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final updateMemberProvider = Provider<UpdateMember>((ref) {
  return UpdateMember(
    membersRepository: ref.watch(membersRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final deactivateMemberProvider = Provider<DeactivateMember>((ref) {
  return DeactivateMember(
    membersRepository: ref.watch(membersRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

@immutable
class MembersContext {
  const MembersContext({
    required this.shomitiId,
    required this.rules,
    required this.isJoiningClosed,
    required this.closedJoiningReason,
  });

  final String shomitiId;
  final RuleSetSnapshot rules;
  final bool isJoiningClosed;
  final String? closedJoiningReason;
}

final membersContextProvider = FutureProvider.autoDispose<MembersContext?>((
  ref,
) async {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) return null;

  final version = await ref
      .watch(rulesRepositoryProvider)
      .getById(shomiti.activeRuleSetVersionId);
  if (version == null) return null;

  final now = DateTime.now();
  final isJoiningClosed =
      version.snapshot.groupType == GroupTypePolicy.closed &&
      !now.isBefore(version.snapshot.startDate);

  return MembersContext(
    shomitiId: shomiti.id,
    rules: version.snapshot,
    isJoiningClosed: isJoiningClosed,
    closedJoiningReason: isJoiningClosed
        ? 'Joining is closed after the start date. Add new members only if everyone unanimously agrees.'
        : null,
  );
});

final membersUiStateProvider = StreamProvider.autoDispose<MembersUiState?>((
  ref,
) async* {
  final context = await ref.watch(membersContextProvider.future);
  if (context == null) {
    yield null;
    return;
  }

  yield* ref
      .watch(watchMembersProvider)(shomitiId: context.shomitiId)
      .map(
        (members) => MembersUiState(
          shomitiId: context.shomitiId,
          isJoiningClosed: context.isJoiningClosed,
          closedJoiningReason: context.closedJoiningReason,
          members: members,
        ),
      );
});

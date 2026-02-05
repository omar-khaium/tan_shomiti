import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../members/domain/entities/member.dart';
import '../../../members/domain/entities/role_assignment.dart';
import '../../../members/presentation/governance/providers/governance_providers.dart';
import '../../../members/presentation/providers/members_providers.dart';
import '../controllers/payout_controller.dart';
import '../models/payout_ui_state.dart';

final payoutControllerProvider =
    AsyncNotifierProvider.autoDispose<PayoutController, PayoutUiState>(
      PayoutController.new,
    );

final payoutUiStateProvider = Provider.autoDispose<AsyncValue<PayoutUiState>>(
  (ref) => ref.watch(payoutControllerProvider),
);

final payoutMembersProvider =
    FutureProvider.autoDispose.family<List<Member>, String>((ref, shomitiId) {
      return ref.watch(membersRepositoryProvider).listMembers(
            shomitiId: shomitiId,
          );
    });

final payoutRoleAssignmentsProvider =
    StreamProvider.autoDispose.family<List<RoleAssignment>, String>((
  ref,
  shomitiId,
) {
  return ref.watch(rolesRepositoryProvider).watchRoleAssignments(
        shomitiId: shomitiId,
      );
});

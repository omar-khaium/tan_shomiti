import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../members/presentation/providers/members_providers.dart';
import '../models/membership_change_ui_models.dart';
import '../providers/demo_membership_changes_store.dart';

class MembershipChangesController
    extends AutoDisposeAsyncNotifier<MembershipChangesUiState?> {
  @override
  Future<MembershipChangesUiState?> build() async {
    final statuses = ref.watch(demoMembershipChangesStoreProvider);
    final context = await ref.watch(membersContextProvider.future);
    if (context == null) return null;

    await ref.watch(seedMembersProvider)(
      shomitiId: context.shomitiId,
      memberCount: context.rules.memberCount,
    );

    final members = await ref
        .watch(membersRepositoryProvider)
        .listMembers(shomitiId: context.shomitiId);

    final rows = [
      for (final m in members)
        MemberChangeRow(
          memberId: m.id,
          position: m.position,
          displayName: m.fullName,
          status: statuses[m.id] ?? MemberChangeStatus.active,
        ),
    ];

    return MembershipChangesUiState(rows: List.unmodifiable(rows));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/ui/components/app_card.dart';
import '../../../../core/ui/components/app_empty_state.dart';
import '../../../../core/ui/components/app_error_state.dart';
import '../../../../core/ui/components/app_list_row.dart';
import '../../../../core/ui/components/app_loading_state.dart';
import '../../../../core/ui/components/app_status_chip.dart';
import '../../../../core/ui/tokens/app_spacing.dart';
import '../../domain/entities/governance_role.dart';
import 'models/governance_ui_state.dart';
import 'providers/governance_providers.dart';

class GovernancePage extends ConsumerWidget {
  const GovernancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final governance = ref.watch(governanceUiStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(governanceTitle)),
      body: governance.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load governance.'),
        ),
        data: (data) {
          if (data == null) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No governance setup yet',
                message:
                    'Create a Shomiti first, then assign roles and collect member sign-off.',
                icon: Icons.verified_user_outlined,
              ),
            );
          }

          final status = data.isGovernanceReady
              ? const AppStatusChip(
                  label: 'Governance ready',
                  kind: AppStatusKind.success,
                )
              : const AppStatusChip(
                  label: 'Not ready',
                  kind: AppStatusKind.warning,
                );

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.s16),
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Readiness',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        status,
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    Text(
                      'Sign-off: ${data.signedCount}/${data.members.length} members',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    Text(
                      'Required roles: Treasurer + Auditor',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.s16),
              AppListRow(
                key: const Key('governance_roles_tile'),
                title: governanceRolesTitle,
                value: _rolesSummary(data),
                onTap: () => context.push(governanceRolesLocation),
              ),
              AppListRow(
                key: const Key('governance_signoff_tile'),
                title: governanceSignoffTitle,
                value: '${data.signedCount}/${data.members.length} signed',
                onTap: () => context.push(governanceSignoffLocation),
              ),
            ],
          );
        },
      ),
    );
  }

  String _rolesSummary(GovernanceUiState state) {
    final treasurerId = state.roleAssignments[GovernanceRole.treasurer];
    final auditorId = state.roleAssignments[GovernanceRole.auditor];

    final treasurer = _memberName(state, treasurerId);
    final auditor = _memberName(state, auditorId);

    return 'Treasurer: $treasurer · Auditor: $auditor';
  }

  String _memberName(GovernanceUiState state, String? memberId) {
    if (memberId == null) return 'Unassigned';
    for (final member in state.members) {
      if (member.id == memberId) return member.displayName;
    }
    return 'Unknown';
  }
}

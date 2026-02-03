import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/ui/components/app_button.dart';
import '../../../../core/ui/components/app_empty_state.dart';
import '../../../../core/ui/components/app_error_state.dart';
import '../../../../core/ui/components/app_loading_state.dart';
import '../../../../core/ui/tokens/app_spacing.dart';
import 'providers/governance_demo_providers.dart';

class RolesAssignmentPage extends ConsumerWidget {
  const RolesAssignmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final governance = ref.watch(governanceDemoControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(governanceRolesTitle)),
      body: governance.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load roles.'),
        ),
        data: (data) {
          if (data == null) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No Shomiti found',
                message: 'Create a Shomiti first, then assign roles.',
                icon: Icons.group_outlined,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(AppSpacing.s16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'At minimum, assign a Treasurer and an Auditor for two-person verification.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.s16),
                _RoleDropdown(
                  fieldKey: const Key('role_coordinator_dropdown'),
                  label: 'Coordinator (optional)',
                  members: data.members,
                  value: data.roleAssignments[GovernanceRole.coordinator],
                  onChanged: (memberIndex) => ref
                      .read(governanceDemoControllerProvider.notifier)
                      .assignRole(
                        role: GovernanceRole.coordinator,
                        memberIndex: memberIndex,
                      ),
                ),
                const SizedBox(height: AppSpacing.s12),
                _RoleDropdown(
                  fieldKey: const Key('role_treasurer_dropdown'),
                  label: 'Treasurer (required)',
                  members: data.members,
                  value: data.roleAssignments[GovernanceRole.treasurer],
                  onChanged: (memberIndex) => ref
                      .read(governanceDemoControllerProvider.notifier)
                      .assignRole(
                        role: GovernanceRole.treasurer,
                        memberIndex: memberIndex,
                      ),
                ),
                const SizedBox(height: AppSpacing.s12),
                _RoleDropdown(
                  fieldKey: const Key('role_auditor_dropdown'),
                  label: 'Auditor (required)',
                  members: data.members,
                  value: data.roleAssignments[GovernanceRole.auditor],
                  onChanged: (memberIndex) => ref
                      .read(governanceDemoControllerProvider.notifier)
                      .assignRole(
                        role: GovernanceRole.auditor,
                        memberIndex: memberIndex,
                      ),
                ),
                const Spacer(),
                AppButton.primary(
                  key: const Key('roles_done'),
                  label: 'Done',
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RoleDropdown extends StatelessWidget {
  const _RoleDropdown({
    required this.fieldKey,
    required this.label,
    required this.members,
    required this.value,
    required this.onChanged,
  });

  final Key fieldKey;
  final String label;
  final List<GovernanceDemoMember> members;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      key: fieldKey,
      initialValue: value,
      items: [
        const DropdownMenuItem<int?>(
          value: null,
          child: Text('Unassigned'),
        ),
        ...members.indexed.map(
          (entry) => DropdownMenuItem<int?>(
            value: entry.$1,
            child: Text(entry.$2.name),
          ),
        ),
      ],
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label),
    );
  }
}

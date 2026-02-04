import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_confirm_dialog.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_status_chip.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'models/membership_change_ui_models.dart';
import 'providers/demo_membership_changes_store.dart';
import 'providers/membership_changes_providers.dart';

class MembershipChangesPage extends ConsumerWidget {
  const MembershipChangesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(membershipChangesUiStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Membership changes')),
      body: state.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stackTrace) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load members.'),
        ),
        data: (ui) {
          if (ui == null || ui.rows.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No members found',
                message: 'Add members first, then manage exits/replacements.',
                icon: Icons.group_outlined,
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.s16),
            children: [
              AppCard(
                child: Text(
                  'Recommended: no exit without replacement. Changes should be unanimous and recorded.',
                ),
              ),
              const SizedBox(height: AppSpacing.s16),
              for (final row in ui.rows)
                _MemberRow(
                  row: row,
                  onRequestExit: () async {
                    final confirmed = await showAppConfirmDialog(
                      context: context,
                      title: 'Request exit?',
                      message:
                          'This records an exit request. By default, exit requires an approved replacement.',
                      confirmLabel: 'Request exit',
                    );
                    if (confirmed != true) return;
                    ref
                        .read(demoMembershipChangesStoreProvider.notifier)
                        .requestExit(row.memberId);
                  },
                  onProposeReplacement: () async {
                    final confirmed = await showAppConfirmDialog(
                      context: context,
                      title: 'Propose replacement?',
                      message:
                          'This is a demo flow. Stage 3 will add approvals + proof + settlement checks.',
                      confirmLabel: 'Propose',
                    );
                    if (confirmed != true) return;
                    ref
                        .read(demoMembershipChangesStoreProvider.notifier)
                        .proposeReplacement(row.memberId);
                  },
                  onRemoveForMisconduct: () async {
                    final confirmed = await showAppConfirmDialog(
                      context: context,
                      title: 'Remove for misconduct?',
                      message:
                          'This is a serious action. Use respectful language and require unanimous approval.',
                      confirmLabel: 'Remove',
                    );
                    if (confirmed != true) return;
                    ref
                        .read(demoMembershipChangesStoreProvider.notifier)
                        .removeForMisconduct(row.memberId);
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({
    required this.row,
    required this.onRequestExit,
    required this.onProposeReplacement,
    required this.onRemoveForMisconduct,
  });

  final MemberChangeRow row;
  final VoidCallback onRequestExit;
  final VoidCallback onProposeReplacement;
  final VoidCallback onRemoveForMisconduct;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: Key('membership_row_${row.position}'),
      padding: const EdgeInsets.all(AppSpacing.s12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  row.displayName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              AppStatusChip(
                label: _statusLabel(row.status),
                kind: _statusKind(row.status),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s12),
          Wrap(
            spacing: AppSpacing.s8,
            runSpacing: AppSpacing.s8,
            children: [
              TextButton(
                key: Key('membership_request_exit_${row.position}'),
                onPressed: onRequestExit,
                child: const Text('Request exit'),
              ),
              TextButton(
                key: Key('membership_propose_replacement_${row.position}'),
                onPressed: onProposeReplacement,
                child: const Text('Propose replacement'),
              ),
              TextButton(
                key: Key('membership_remove_${row.position}'),
                onPressed: onRemoveForMisconduct,
                child: const Text('Remove'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _statusLabel(MemberChangeStatus status) {
    return switch (status) {
      MemberChangeStatus.active => 'Active',
      MemberChangeStatus.exitRequested => 'Exit requested',
      MemberChangeStatus.replacementProposed => 'Replacement proposed',
      MemberChangeStatus.removedForMisconduct => 'Removed',
    };
  }

  static AppStatusKind _statusKind(MemberChangeStatus status) {
    return switch (status) {
      MemberChangeStatus.active => AppStatusKind.success,
      MemberChangeStatus.exitRequested => AppStatusKind.warning,
      MemberChangeStatus.replacementProposed => AppStatusKind.warning,
      MemberChangeStatus.removedForMisconduct => AppStatusKind.error,
    };
  }
}

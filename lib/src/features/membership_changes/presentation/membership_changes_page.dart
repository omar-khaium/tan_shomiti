import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_confirm_dialog.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_status_chip.dart';
import '../../../core/ui/components/app_text_field.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'models/membership_change_ui_models.dart';
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
                  'Recommended: no exit without replacement. Changes should be unanimous and recorded as approvals (rules.md Section 14).',
                ),
              ),
              const SizedBox(height: AppSpacing.s16),
              for (final row in ui.rows)
                _MemberRow(
                  row: row,
                  onRequestExit: row.activeRequestId == null
                      ? () {
                    () async {
                    final confirmed = await showAppConfirmDialog(
                      context: context,
                      title: 'Request exit?',
                      message:
                          'This records an exit request. By default, exit requires an approved replacement.',
                      confirmLabel: 'Request exit',
                    );
                    if (confirmed != true) return;
                    try {
                      await ref
                          .read(membershipChangesControllerProvider.notifier)
                          .requestExit(row.memberId);
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                    }();
                  }
                      : null,
                  onProposeReplacement:
                      row.status == MemberChangeStatus.exitRequested ||
                              row.status ==
                                  MemberChangeStatus.replacementProposed
                          ? () {
                    () async {
                    final result = await _showProposeReplacementDialog(
                      context: context,
                      position: row.position,
                    );
                    if (result == null) return;
                    try {
                      await ref
                          .read(membershipChangesControllerProvider.notifier)
                          .proposeReplacement(
                            memberId: row.memberId,
                            replacementName: result.name,
                            replacementPhone: result.phone,
                          );
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                    }();
                  }
                          : null,
                  onRemoveForMisconduct: row.activeRequestId == null
                      ? () {
                    () async {
                    final result = await _showRemoveForMisconductDialog(
                      context: context,
                      position: row.position,
                    );
                    if (result == null) return;
                    try {
                      await ref
                          .read(membershipChangesControllerProvider.notifier)
                          .removeForMisconduct(
                            memberId: row.memberId,
                            reasonCode: result.reasonCode,
                            details: result.details,
                          );
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                    }();
                  }
                      : null,
                  onApprove: row.activeRequestId != null &&
                          row.status != MemberChangeStatus.exitRequested &&
                          row.approvalsRequired > 0 &&
                          row.approvalsCount < row.approvalsRequired
                      ? () {
                    () async {
                    final approverId = await _showApprovalDialog(
                      context: context,
                      outgoingMemberId: row.memberId,
                      alreadyApprovedMemberIds: row.approvedByMemberIds,
                      members: ui.members,
                      position: row.position,
                    );
                    if (approverId == null) return;
                    try {
                      await ref
                          .read(membershipChangesControllerProvider.notifier)
                          .approve(
                            requestId: row.activeRequestId!,
                            outgoingMemberId: row.memberId,
                            approverMemberId: approverId,
                          );
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                    }();
                  }
                      : null,
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
    required this.onApprove,
  });

  final MemberChangeRow row;
  final VoidCallback? onRequestExit;
  final VoidCallback? onProposeReplacement;
  final VoidCallback? onRemoveForMisconduct;
  final VoidCallback? onApprove;

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
          if (row.activeRequestId != null) ...[
            const SizedBox(height: AppSpacing.s8),
            Text(
              'Approvals: ${row.approvalsCount}/${row.approvalsRequired} (unanimous)',
              key: Key('membership_approvals_${row.position}'),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          if (row.replacementCandidateName?.trim().isNotEmpty == true) ...[
            const SizedBox(height: AppSpacing.s4),
            Text(
              'Proposed: ${row.replacementCandidateName}',
              key: Key('membership_replacement_${row.position}'),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
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
              if (onApprove != null)
                TextButton(
                  key: Key('membership_approve_${row.position}'),
                  onPressed: onApprove,
                  child: const Text('Approve'),
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
      MemberChangeStatus.removalProposed => 'Removal proposed',
      MemberChangeStatus.removedForMisconduct => 'Removed',
    };
  }

  static AppStatusKind _statusKind(MemberChangeStatus status) {
    return switch (status) {
      MemberChangeStatus.active => AppStatusKind.success,
      MemberChangeStatus.exitRequested => AppStatusKind.warning,
      MemberChangeStatus.replacementProposed => AppStatusKind.warning,
      MemberChangeStatus.removalProposed => AppStatusKind.warning,
      MemberChangeStatus.removedForMisconduct => AppStatusKind.error,
    };
  }
}

class _ReplacementInput {
  const _ReplacementInput({required this.name, required this.phone});

  final String name;
  final String phone;
}

Future<_ReplacementInput?> _showProposeReplacementDialog({
  required BuildContext context,
  required int position,
}) async {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final result = await showDialog<_ReplacementInput>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Replacement for member #$position'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                label: 'Replacement name',
                fieldKey: const Key('membership_replacement_name'),
                controller: nameController,
                textInputAction: TextInputAction.next,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: AppSpacing.s12),
              AppTextField(
                label: 'Replacement phone',
                fieldKey: const Key('membership_replacement_phone'),
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            key: const Key('membership_replacement_cancel'),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const Key('membership_replacement_confirm'),
            onPressed: () {
              if (formKey.currentState?.validate() != true) return;
              Navigator.of(context).pop(
                _ReplacementInput(
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                ),
              );
            },
            child: const Text('Propose'),
          ),
        ],
      );
    },
  );

  nameController.dispose();
  phoneController.dispose();
  return result;
}

class _RemovalInput {
  const _RemovalInput({required this.reasonCode, required this.details});

  final String reasonCode;
  final String? details;
}

Future<_RemovalInput?> _showRemoveForMisconductDialog({
  required BuildContext context,
  required int position,
}) async {
  final formKey = GlobalKey<FormState>();
  String reason = 'fraud_or_manipulation';
  final detailsController = TextEditingController();

  final result = await showDialog<_RemovalInput>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Remove member #$position?'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                key: const Key('membership_removal_reason'),
                initialValue: reason,
                items: const [
                  DropdownMenuItem(
                    value: 'fraud_or_manipulation',
                    child: Text('Fraud or manipulation'),
                  ),
                  DropdownMenuItem(
                    value: 'repeated_default',
                    child: Text('Repeated default'),
                  ),
                  DropdownMenuItem(
                    value: 'abusive_behavior',
                    child: Text('Abusive behavior'),
                  ),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (v) => reason = v ?? reason,
                decoration: const InputDecoration(labelText: 'Reason'),
              ),
              const SizedBox(height: AppSpacing.s12),
              AppTextField(
                label: 'Details (optional)',
                fieldKey: const Key('membership_removal_details'),
                controller: detailsController,
              ),
              const SizedBox(height: AppSpacing.s8),
              Text(
                'Unanimous approval is required. Keep language respectful and avoid public shaming.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            key: const Key('membership_removal_cancel'),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const Key('membership_removal_confirm'),
            onPressed: () {
              if (formKey.currentState?.validate() != true) return;
              Navigator.of(context).pop(
                _RemovalInput(
                  reasonCode: reason,
                  details: detailsController.text.trim().isEmpty
                      ? null
                      : detailsController.text.trim(),
                ),
              );
            },
            child: const Text('Propose removal'),
          ),
        ],
      );
    },
  );

  detailsController.dispose();
  return result;
}

Future<String?> _showApprovalDialog({
  required BuildContext context,
  required String outgoingMemberId,
  required List<String> alreadyApprovedMemberIds,
  required List<ApproverOption> members,
  required int position,
}) async {
  final eligible = members
      .where((m) => m.isActive)
      .where((m) => m.memberId != outgoingMemberId)
      .where((m) => !alreadyApprovedMemberIds.contains(m.memberId))
      .toList(growable: false)
    ..sort((a, b) => a.position.compareTo(b.position));

  if (eligible.isEmpty) return null;

  var selected = eligible.first.memberId;

  final result = await showDialog<String>(
    context: context,
    builder: (context) {
              return AlertDialog(
        title: Text('Approve change for member #$position'),
        content: DropdownButtonFormField<String>(
          key: const Key('membership_approval_approver'),
          initialValue: selected,
          items: [
            for (final m in eligible)
              DropdownMenuItem(
                value: m.memberId,
                child: Text('#${m.position} — ${m.displayName}'),
              ),
          ],
          onChanged: (v) => selected = v ?? selected,
          decoration: const InputDecoration(labelText: 'Approver'),
        ),
        actions: [
          TextButton(
            key: const Key('membership_approval_cancel'),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const Key('membership_approval_confirm'),
            onPressed: () => Navigator.of(context).pop(selected),
            child: const Text('Approve'),
          ),
        ],
      );
    },
  );

  return result;
}

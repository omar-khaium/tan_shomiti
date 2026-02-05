import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../../members/domain/entities/governance_role.dart';
import 'providers/payout_domain_providers.dart';
import 'providers/payout_providers.dart';
import '../domain/entities/payout_approval_role.dart';

class PayoutApprovalsPage extends ConsumerStatefulWidget {
  const PayoutApprovalsPage({super.key});

  @override
  ConsumerState<PayoutApprovalsPage> createState() => _PayoutApprovalsPageState();
}

class _PayoutApprovalsPageState extends ConsumerState<PayoutApprovalsPage> {
  final _treasurerNoteController = TextEditingController();
  final _auditorNoteController = TextEditingController();

  String? _selectedTreasurerId;
  String? _selectedAuditorId;

  @override
  void dispose() {
    _treasurerNoteController.dispose();
    _auditorNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ui = ref.watch(payoutUiStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Approvals')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: ui.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Failed to load payout: $error'),
          ),
          data: (state) {
            String? assignedTreasurerId;
            String? assignedAuditorId;

            final needsAssignments =
                !state.treasurerApproval.hasApproval ||
                !state.auditorApproval.hasApproval;
            if (needsAssignments) {
              final assignmentsAsync =
                  ref.watch(payoutRoleAssignmentsProvider(state.shomitiId));
              final assignments = assignmentsAsync.valueOrNull;
              if (assignments != null) {
                for (final a in assignments) {
                  if (a.role == GovernanceRole.treasurer) {
                    assignedTreasurerId ??= a.memberId;
                  } else if (a.role == GovernanceRole.auditor) {
                    assignedAuditorId ??= a.memberId;
                  }
                }
              }
            }

            final treasurerId = assignedTreasurerId ?? _selectedTreasurerId;
            final auditorId = assignedAuditorId ?? _selectedAuditorId;

            final canContinue =
                state.treasurerApproval.hasApproval &&
                state.auditorApproval.hasApproval;

            final needMembersForTreasurer =
                !state.treasurerApproval.hasApproval &&
                assignedTreasurerId == null;
            final needMembersForAuditor =
                !state.auditorApproval.hasApproval && assignedAuditorId == null;
            final membersAsync = (needMembersForTreasurer || needMembersForAuditor)
                ? ref.watch(payoutMembersProvider(state.shomitiId))
                : null;

            return ListView(
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Treasurer approval',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.s12),
                      if (needMembersForTreasurer)
                        membersAsync!.when(
                          loading: () => const LinearProgressIndicator(),
                          error: (e, s) =>
                              const Text('Failed to load members.'),
                          data: (members) => DropdownButtonFormField<String>(
                            key: const Key('payout_treasurer_picker'),
                            decoration: const InputDecoration(
                              labelText: 'Treasurer member',
                              border: OutlineInputBorder(),
                            ),
                            initialValue: _selectedTreasurerId,
                            items: [
                              for (final m in members)
                                DropdownMenuItem(
                                  value: m.id,
                                  child: Text(m.fullName),
                                ),
                            ],
                            onChanged: (value) =>
                                setState(() => _selectedTreasurerId = value),
                          ),
                        ),
                      if (assignedTreasurerId != null)
                        Text(
                          'Assigned treasurer: $assignedTreasurerId',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      const SizedBox(height: AppSpacing.s12),
                      TextField(
                        key: const Key('payout_treasurer_note'),
                        controller: _treasurerNoteController,
                        decoration: const InputDecoration(
                          labelText: 'Note (optional)',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: AppSpacing.s12),
                      AppButton.primary(
                        key: const Key('payout_treasurer_approve'),
                        label: state.treasurerApproval.hasApproval
                            ? 'Approved'
                            : 'Approve',
                        onPressed:
                            (!state.treasurerApproval.hasApproval &&
                                    treasurerId != null)
                                ? () => _approve(
                                      shomitiId: state.shomitiId,
                                      ruleSetVersionId: state.ruleSetVersionId,
                                      month: state.month,
                                      role: PayoutApprovalRole.treasurer,
                                      approverMemberId: treasurerId,
                                      note: _treasurerNoteController.text,
                                    )
                                : null,
                      ),
                      if (state.treasurerApproval.hasApproval &&
                          state.treasurerApproval.approvedAt != null) ...[
                        const SizedBox(height: AppSpacing.s8),
                        Text(
                          'Approved at ${state.treasurerApproval.approvedAt}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auditor/witness approval',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.s12),
                      if (needMembersForAuditor)
                        membersAsync!.when(
                          loading: () => const LinearProgressIndicator(),
                          error: (e, s) =>
                              const Text('Failed to load members.'),
                          data: (members) => DropdownButtonFormField<String>(
                            key: const Key('payout_auditor_picker'),
                            decoration: const InputDecoration(
                              labelText: 'Auditor member',
                              border: OutlineInputBorder(),
                            ),
                            initialValue: _selectedAuditorId,
                            items: [
                              for (final m in members)
                                DropdownMenuItem(
                                  value: m.id,
                                  child: Text(m.fullName),
                                ),
                            ],
                            onChanged: (value) =>
                                setState(() => _selectedAuditorId = value),
                          ),
                        ),
                      if (assignedAuditorId != null)
                        Text(
                          'Assigned auditor: $assignedAuditorId',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      const SizedBox(height: AppSpacing.s12),
                      TextField(
                        key: const Key('payout_auditor_note'),
                        controller: _auditorNoteController,
                        decoration: const InputDecoration(
                          labelText: 'Note (optional)',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: AppSpacing.s12),
                      AppButton.primary(
                        key: const Key('payout_auditor_approve'),
                        label: state.auditorApproval.hasApproval
                            ? 'Approved'
                            : 'Approve',
                        onPressed:
                            (!state.auditorApproval.hasApproval &&
                                    auditorId != null)
                                ? () => _approve(
                                      shomitiId: state.shomitiId,
                                      ruleSetVersionId: state.ruleSetVersionId,
                                      month: state.month,
                                      role: PayoutApprovalRole.auditor,
                                      approverMemberId: auditorId,
                                      note: _auditorNoteController.text,
                                    )
                                : null,
                      ),
                      if (state.auditorApproval.hasApproval &&
                          state.auditorApproval.approvedAt != null) ...[
                        const SizedBox(height: AppSpacing.s8),
                        Text(
                          'Approved at ${state.auditorApproval.approvedAt}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
                AppCard(
                  child: Row(
                    children: [
                      const Expanded(child: Text('Approval status')),
                      Text(
                        canContinue ? 'Approved for payout' : 'Pending',
                        key: const Key('payout_approval_status'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
                AppButton.primary(
                  key: const Key('payout_approvals_continue'),
                  label: 'Continue',
                  onPressed:
                      canContinue ? () => context.push(payoutProofLocation) : null,
                ),
                const SizedBox(height: AppSpacing.s16),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _approve({
    required String shomitiId,
    required String ruleSetVersionId,
    required BillingMonth month,
    required PayoutApprovalRole role,
    required String approverMemberId,
    required String note,
  }) async {
    try {
      await ref.read(recordPayoutApprovalProvider)(
            shomitiId: shomitiId,
            ruleSetVersionId: ruleSetVersionId,
            month: month,
            role: role,
            approverMemberId: approverMemberId,
            note: note,
          );
      ref.invalidate(payoutControllerProvider);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to record approval: $e')),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_status_chip.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../../features/shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import '../domain/entities/dispute.dart';
import '../domain/entities/dispute_step.dart';
import 'providers/disputes_providers.dart';

class DisputeDetailPage extends ConsumerWidget {
  const DisputeDetailPage({
    required this.disputeId,
    super.key,
  });

  final String disputeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disputeAsync = ref.watch(disputeByIdProvider(disputeId));

    return Scaffold(
      appBar: AppBar(title: const Text('Dispute')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: disputeAsync.when(
          loading: () => const AppLoadingState(),
          error: (error, stack) => AppErrorState(
            message: 'Failed to load dispute.',
            onRetry: () => ref.invalidate(disputeByIdProvider(disputeId)),
          ),
          data: (dispute) {
            if (dispute == null) {
              return const AppEmptyState(
                title: 'Dispute not found',
                message: 'It may have been removed.',
                icon: Icons.search,
              );
            }

            final created = MaterialLocalizations.of(context).formatShortDate(
              dispute.createdAt,
            );

            final statusChip = switch (dispute.status) {
              DisputeStatus.resolved => const AppStatusChip(
                  label: 'Resolved',
                  kind: AppStatusKind.success,
                ),
              DisputeStatus.open => AppStatusChip(
                  label: dispute.currentStep.title,
                  kind: AppStatusKind.info,
                ),
            };

            return ListView(
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dispute.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      Text('Created $created'),
                      const SizedBox(height: AppSpacing.s12),
                      statusChip,
                      if (dispute.involvedMembersText != null) ...[
                        const SizedBox(height: AppSpacing.s12),
                        Text(
                          'Involved: ${dispute.involvedMembersText}',
                          key: const Key('dispute_detail_involved'),
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
                        'Summary',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      Text(dispute.description),
                      if (dispute.evidenceReferences.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.s12),
                        Text(
                          'Evidence references',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: AppSpacing.s8),
                        for (final e in dispute.evidenceReferences)
                          Text('• $e', key: Key('dispute_evidence_$e')),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
                Text(
                  'Resolution steps (Rules §13)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.s8),
                for (final step in DisputeStep.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s12),
                    child: _StepCard(
                      disputeId: dispute.id,
                      step: step,
                      record: dispute.stepRecord(step),
                      canComplete: dispute.canCompleteStep(step),
                      isResolved: dispute.status == DisputeStatus.resolved,
                    ),
                  ),
                const SizedBox(height: AppSpacing.s8),
                if (dispute.status == DisputeStatus.open) ...[
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Final outcome',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.s8),
                        const Text(
                          'This app does not provide legal advice. If you need formal remedies, consult appropriate local resources.',
                        ),
                        const SizedBox(height: AppSpacing.s12),
                        AppButton.primary(
                          key: const Key('dispute_resolve'),
                          label: 'Resolve dispute',
                          onPressed: dispute.canResolve
                              ? () => _resolve(context, ref)
                              : null,
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  AppButton.secondary(
                    key: const Key('dispute_reopen'),
                    label: 'Reopen',
                    onPressed: () => _reopen(context, ref),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _resolve(BuildContext context, WidgetRef ref) async {
    final outcomeController = TextEditingController();
    final proofController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resolve dispute'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              key: const Key('resolve_outcome_note'),
              controller: outcomeController,
              minLines: 2,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Outcome note (required)',
                helperText: 'What was decided? Keep it factual.',
              ),
            ),
            const SizedBox(height: AppSpacing.s12),
            TextField(
              key: const Key('resolve_proof_reference'),
              controller: proofController,
              decoration: const InputDecoration(
                labelText: 'Proof reference (optional)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            key: const Key('resolve_cancel'),
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            key: const Key('resolve_confirm'),
            onPressed: () => context.pop(true),
            child: const Text('Resolve'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final shomiti = await ref.read(activeShomitiProvider.future);
      if (shomiti == null) throw StateError('Shomiti not configured.');

      await ref.read(disputesRepositoryProvider).resolve(
            shomitiId: shomiti.id,
            disputeId: disputeId,
            outcomeNote: outcomeController.text,
            proofReference: proofController.text.trim().isEmpty
                ? null
                : proofController.text.trim(),
            now: DateTime.now(),
          );

      ref.invalidate(disputeByIdProvider(disputeId));
      ref.invalidate(disputesProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dispute resolved.')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to resolve: $e')),
      );
    }
  }

  Future<void> _reopen(BuildContext context, WidgetRef ref) async {
    final noteController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reopen dispute'),
        content: TextField(
          key: const Key('reopen_note'),
          controller: noteController,
          minLines: 2,
          maxLines: 6,
          decoration: const InputDecoration(
            labelText: 'Note (required)',
            helperText: 'Why are you reopening? Keep it factual.',
          ),
        ),
        actions: [
          TextButton(
            key: const Key('reopen_cancel'),
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            key: const Key('reopen_confirm'),
            onPressed: () => context.pop(true),
            child: const Text('Reopen'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final shomiti = await ref.read(activeShomitiProvider.future);
      if (shomiti == null) throw StateError('Shomiti not configured.');

      await ref.read(disputesRepositoryProvider).reopen(
            shomitiId: shomiti.id,
            disputeId: disputeId,
            note: noteController.text,
            now: DateTime.now(),
          );

      ref.invalidate(disputeByIdProvider(disputeId));
      ref.invalidate(disputesProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dispute reopened.')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reopen: $e')),
      );
    }
  }
}

class _StepCard extends ConsumerWidget {
  const _StepCard({
    required this.disputeId,
    required this.step,
    required this.record,
    required this.canComplete,
    required this.isResolved,
  });

  final String disputeId;
  final DisputeStep step;
  final DisputeStepRecord? record;
  final bool canComplete;
  final bool isResolved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedAt = record?.completedAt;
    final isCompleted = completedAt != null;

    final statusChip = isCompleted
        ? const AppStatusChip(label: 'Done', kind: AppStatusKind.success)
        : const AppStatusChip(label: 'Pending', kind: AppStatusKind.warning);

    final completedLabel = isCompleted
        ? MaterialLocalizations.of(context).formatShortDate(completedAt)
        : null;

    final action = step == DisputeStep.finalOutcome
        ? null
        : AppButton.secondary(
            key: Key('dispute_step_complete_${step.name}'),
            label: 'Mark step complete',
            onPressed: (!isResolved && canComplete)
                ? () => _complete(context, ref)
                : null,
          );

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  step.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              statusChip,
            ],
          ),
          const SizedBox(height: AppSpacing.s8),
          Text(step.description),
          if (completedLabel != null) ...[
            const SizedBox(height: AppSpacing.s8),
            Text('Completed $completedLabel'),
          ],
          if ((record?.note ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.s8),
            Text('Note: ${record?.note}'),
          ],
          if ((record?.proofReference ?? '').trim().isNotEmpty) ...[
            const SizedBox(height: AppSpacing.s8),
            Text('Proof: ${record?.proofReference}'),
          ],
          if (!isCompleted && !canComplete && !isResolved && step.previous != null)
            const Padding(
              padding: EdgeInsets.only(top: AppSpacing.s8),
              child: Text(
                'Complete the previous step first.',
                key: Key('dispute_step_order_hint'),
              ),
            ),
          if (action != null) ...[
            const SizedBox(height: AppSpacing.s12),
            action,
          ],
        ],
      ),
    );
  }

  Future<void> _complete(BuildContext context, WidgetRef ref) async {
    final noteController = TextEditingController();
    final proofController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(step.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              key: Key('complete_step_note_${step.name}'),
              controller: noteController,
              minLines: 2,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Note (required)',
                helperText: 'Keep it factual and respectful.',
              ),
            ),
            const SizedBox(height: AppSpacing.s12),
            TextField(
              key: Key('complete_step_proof_${step.name}'),
              controller: proofController,
              decoration: const InputDecoration(
                labelText: 'Proof reference (optional)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            key: Key('complete_step_cancel_${step.name}'),
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            key: Key('complete_step_confirm_${step.name}'),
            onPressed: () => context.pop(true),
            child: const Text('Complete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final shomiti = await ref.read(activeShomitiProvider.future);
      if (shomiti == null) throw StateError('Shomiti not configured.');

      await ref.read(disputesRepositoryProvider).completeStep(
            shomitiId: shomiti.id,
            disputeId: disputeId,
            step: step,
            note: noteController.text,
            proofReference: proofController.text.trim().isEmpty
                ? null
                : proofController.text.trim(),
            now: DateTime.now(),
          );

      ref.invalidate(disputeByIdProvider(disputeId));
      ref.invalidate(disputesProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Step completed.')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to complete step: $e')),
      );
    }
  }
}

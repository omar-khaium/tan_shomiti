import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_status_chip.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'models/shares_ui_state.dart';
import 'providers/shares_providers.dart';

class SharesPage extends ConsumerWidget {
  const SharesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shares = ref.watch(sharesUiStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Shares')),
      body: shares.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load shares.'),
        ),
        data: (state) {
          if (state == null) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No Shomiti found',
                message: 'Create a Shomiti first, then assign shares.',
                icon: Icons.group_outlined,
              ),
            );
          }

          if (state.allocations.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No members yet',
                message: 'Add members first, then assign shares.',
                icon: Icons.group_outlined,
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.s16),
            children: [
              _SummaryCard(state: state),
              const SizedBox(height: AppSpacing.s16),
              if (state.validationMessage != null) ...[
                AppCard(
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(width: AppSpacing.s12),
                      Expanded(child: Text(state.validationMessage!)),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
              ],
              Text(
                'Member allocations',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.s8),
              for (final row in state.allocations)
                _MemberRow(
                  row: row,
                  maxSharesPerPerson: state.maxSharesPerPerson,
                  remainingShares: state.remainingShares,
                  onIncrement: () => ref
                      .read(sharesControllerProvider.notifier)
                      .increment(row.memberId),
                  onDecrement: () => ref
                      .read(sharesControllerProvider.notifier)
                      .decrement(row.memberId),
                ),
              const SizedBox(height: AppSpacing.s24),
              AppButton.primary(
                key: const Key('shares_review'),
                label: 'Review allocations',
                onPressed: state.isValid
                    ? () => showDialog<void>(
                        context: context,
                        builder: (context) => _ReviewDialog(state: state),
                      )
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.state});

  final SharesUiState state;

  @override
  Widget build(BuildContext context) {
    final totalShares = state.totalShares;
    final allocatedShares = state.allocatedShares;
    final remainingShares = state.remainingShares;
    final monthlyPotBdt = state.monthlyPotBdt;
    final shareValueBdt = state.shareValueBdt;
    final maxSharesPerPerson = state.maxSharesPerPerson;
    final allowShareTransfers = state.allowShareTransfers;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Overview', style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              AppStatusChip(
                label: remainingShares == 0
                    ? 'Complete'
                    : '$remainingShares remaining',
                kind: remainingShares == 0
                    ? AppStatusKind.success
                    : AppStatusKind.warning,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s12),
          _KvRow(label: 'Total shares (cycle)', value: '$totalShares'),
          _KvRow(label: 'Allocated shares', value: '$allocatedShares'),
          _KvRow(label: 'Share value (S)', value: '$shareValueBdt BDT'),
          _KvRow(label: 'Monthly pot estimate', value: '$monthlyPotBdt BDT'),
          _KvRow(label: 'Max shares/person', value: '$maxSharesPerPerson'),
          _KvRow(
            label: 'Transfers',
            value: allowShareTransfers ? 'Allowed (unanimous)' : 'Not allowed',
          ),
        ],
      ),
    );
  }
}

class _KvRow extends StatelessWidget {
  const _KvRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: AppSpacing.s12),
          Text(value, textAlign: TextAlign.end),
        ],
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({
    required this.row,
    required this.maxSharesPerPerson,
    required this.remainingShares,
    required this.onIncrement,
    required this.onDecrement,
  });

  final SharesMemberAllocation row;
  final int maxSharesPerPerson;
  final int remainingShares;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final memberId = row.memberId;
    final displayName = row.displayName;
    final shares = row.shares;
    final monthlyDueBdt = row.monthlyDueBdt;

    final canDecrement = shares > 1;
    final canIncrement = shares < maxSharesPerPerson && remainingShares > 0;

    return AppCard(
      key: Key('shares_row_$memberId'),
      padding: const EdgeInsets.all(AppSpacing.s12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  '$monthlyDueBdt BDT / month',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.s8),
          IconButton(
            key: Key('shares_decrement_$memberId'),
            onPressed: canDecrement ? onDecrement : null,
            icon: const Icon(Icons.remove),
            tooltip: 'Decrease shares',
          ),
          SizedBox(
            width: 44,
            child: Text(
              '$shares',
              key: Key('shares_count_$memberId'),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            key: Key('shares_increment_$memberId'),
            onPressed: canIncrement ? onIncrement : null,
            icon: const Icon(Icons.add),
            tooltip: 'Increase shares',
          ),
        ],
      ),
    );
  }
}

class _ReviewDialog extends StatelessWidget {
  const _ReviewDialog({required this.state});

  final SharesUiState state;

  @override
  Widget build(BuildContext context) {
    final allocations = state.allocations;

    return AlertDialog(
      key: const Key('shares_review_dialog'),
      title: const Text('Review allocations'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: allocations.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final row = allocations[index];
            return ListTile(
              title: Text(row.displayName),
              trailing: Text('${row.shares}'),
            );
          },
        ),
      ),
      actions: [
        AppButton.tertiary(
          key: const Key('shares_review_close'),
          label: 'Close',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'models/contributions_ui_state.dart';
import 'providers/contributions_providers.dart';

class ContributionsPage extends ConsumerWidget {
  const ContributionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contributionsUiStateProvider);

    return state.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.s16),
        child: AppLoadingState(),
      ),
      error: (error, stackTrace) => const Padding(
        padding: EdgeInsets.all(AppSpacing.s16),
        child: AppErrorState(message: 'Failed to load dues.'),
      ),
      data: (ui) {
        if (ui == null) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.s16),
            child: AppEmptyState(
              title: 'No Shomiti yet',
              message: 'Complete setup to generate monthly dues.',
              icon: Icons.payments_outlined,
            ),
          );
        }

        if (ui.rows.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.s16),
            child: AppEmptyState(
              title: 'No members found',
              message: 'Add members and shares first.',
              icon: Icons.group_outlined,
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.s16),
          children: [
            _MonthHeader(
              month: ui.month,
              onPrev: () async {
                await ref
                    .read(contributionsControllerProvider.notifier)
                    .previousMonth();
              },
              onNext: () async {
                await ref
                    .read(contributionsControllerProvider.notifier)
                    .nextMonth();
              },
            ),
            const SizedBox(height: AppSpacing.s12),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total due',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Text(
                    '${ui.totalDueBdt} BDT',
                    key: const Key('dues_total_due'),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            for (final row in ui.rows) _DueRow(row: row),
          ],
        );
      },
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({
    required this.month,
    required this.onPrev,
    required this.onNext,
  });

  final DateTime month;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final label = '${_monthName(month.month)} ${month.year}';

    return Row(
      children: [
        IconButton(
          key: const Key('dues_prev_month'),
          onPressed: onPrev,
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Previous month',
        ),
        Expanded(
          child: Text(
            label,
            key: const Key('dues_month_label'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton(
          key: const Key('dues_next_month'),
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right),
          tooltip: 'Next month',
        ),
      ],
    );
  }

  static String _monthName(int m) {
    const names = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    if (m < 1 || m > 12) return 'Month';
    return names[m - 1];
  }
}

class _DueRow extends StatelessWidget {
  const _DueRow({required this.row});

  final MonthlyDueRow row;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: Key('dues_row_${row.position}'),
      padding: const EdgeInsets.all(AppSpacing.s12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.displayName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.s4),
                Text(
                  'Shares: ${row.shares}',
                  key: Key('dues_shares_${row.position}'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            '${row.dueAmountBdt} BDT',
            key: Key('dues_amount_${row.position}'),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_status_chip.dart';
import '../../../core/ui/formatters/billing_month_label.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../app/router/app_router.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import 'models/draw_ui_state.dart';
import 'providers/draw_providers.dart';

class DrawPage extends ConsumerWidget {
  const DrawPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(drawUiStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Draw')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: ui.when(
          loading: () => const Center(child: AppLoadingState()),
          error: (error, stackTrace) => Center(
            child: AppErrorState(
              message: 'Failed to load eligibility.',
              onRetry: () => ref.invalidate(drawControllerProvider),
            ),
          ),
          data: (state) => _DrawBody(state: state),
        ),
      ),
    );
  }
}

class _DrawBody extends ConsumerWidget {
  const _DrawBody({required this.state});

  final DrawUiState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monthLabel = formatBillingMonthLabel(state.month);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _MonthHeader(
          month: state.month,
          onPrev: () => ref
              .read(drawControllerProvider.notifier)
              .setMonth(state.month.previous()),
          onNext: () => ref
              .read(drawControllerProvider.notifier)
              .setMonth(state.month.next()),
        ),
        const SizedBox(height: AppSpacing.s16),
        _SummaryCard(summary: state.summary),
        const SizedBox(height: AppSpacing.s16),
        Expanded(
          child: _EligibilityList(
            hasDuesForMonth: state.hasDuesForMonth,
            rows: state.rows,
          ),
        ),
        const SizedBox(height: AppSpacing.s12),
        AppButton.primary(
          key: const Key('eligibility_run_draw'),
          label: 'Run draw',
          onPressed: state.canRunDraw
              ? () => context.push(
                    drawRunLocation,
                    extra: state.month,
                  )
              : null,
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(
          'Month: $monthLabel',
          key: const Key('eligibility_month_label'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({
    required this.month,
    required this.onPrev,
    required this.onNext,
  });

  final BillingMonth month;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final label = formatBillingMonthLabel(month);

    return Row(
      children: [
        IconButton(
          key: const Key('eligibility_prev_month'),
          onPressed: onPrev,
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Previous month',
        ),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton(
          key: const Key('eligibility_next_month'),
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right),
          tooltip: 'Next month',
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary});

  final DrawEligibilitySummary summary;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Eligibility summary',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.s8),
          Row(
            children: [
              Expanded(
                child: Text('Eligible entries: ${summary.eligibleEntries}'),
              ),
              Expanded(
                child: Text('Ineligible entries: ${summary.ineligibleEntries}'),
              ),
            ],
          ),
          if (summary.ineligibleReasons.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.s12),
            Wrap(
              spacing: AppSpacing.s8,
              runSpacing: AppSpacing.s8,
              children: [
                for (final entry in summary.ineligibleReasons.entries)
                  Chip(label: Text('${entry.key}: ${entry.value}')),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _EligibilityList extends StatelessWidget {
  const _EligibilityList({required this.hasDuesForMonth, required this.rows});

  final bool hasDuesForMonth;
  final List<DrawEligibilityRowUiModel> rows;

  @override
  Widget build(BuildContext context) {
    if (!hasDuesForMonth) {
      return const AppEmptyState(
        title: 'No dues generated',
        message: 'No dues generated for this month yet',
        icon: Icons.info_outline,
      );
    }

    if (rows.isEmpty) {
      return const AppEmptyState(
        title: 'No entries',
        message: 'No eligible or ineligible entries for this month.',
        icon: Icons.info_outline,
      );
    }

    return ListView.separated(
      itemCount: rows.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.s12),
      itemBuilder: (context, index) {
        final row = rows[index];
        final badgeKind = row.isEligible ? AppStatusKind.success : AppStatusKind.warning;
        final badgeLabel = row.isEligible ? 'Eligible' : 'Ineligible';

        return AppCard(
          child: Padding(
            key: Key('eligibility_row_${row.position}'),
            padding: const EdgeInsets.all(AppSpacing.s12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        row.memberName,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.s4),
                      Text(
                        'Shares: ${row.shares}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (!row.isEligible && row.reason != null) ...[
                        const SizedBox(height: AppSpacing.s4),
                        Text(
                          row.reason!,
                          key: Key('eligibility_reason_${row.position}'),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                AppStatusChip(
                  key: Key('eligibility_badge_${row.position}'),
                  label: badgeLabel,
                  kind: badgeKind,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

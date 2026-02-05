import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/formatters/billing_month_label.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'providers/draw_providers.dart';

class DrawRecordDetailsPage extends ConsumerWidget {
  const DrawRecordDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(drawRecordDetailsUiProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Draw record')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: ui.when(
          loading: () => const Center(child: AppLoadingState()),
          error: (error, stack) => Center(
            child: AppErrorState(
              message: 'Failed to load draw record.',
              onRetry: () => ref.invalidate(drawRecordDetailsControllerProvider),
            ),
          ),
          data: (state) {
            if (state == null) {
              return const AppEmptyState(
                title: 'No shomiti configured',
                message: 'Complete setup to record and verify draws.',
                icon: Icons.info_outline,
              );
            }

            final monthLabel = formatBillingMonthLabel(state.month);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      key: const Key('draw_record_prev_month'),
                      onPressed: () => ref
                          .read(drawRecordDetailsControllerProvider.notifier)
                          .previousMonth(),
                      icon: const Icon(Icons.chevron_left),
                      tooltip: 'Previous month',
                    ),
                    Expanded(
                      child: Text(
                        monthLabel,
                        key: const Key('draw_record_month_label'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      key: const Key('draw_record_next_month'),
                      onPressed: () => ref
                          .read(drawRecordDetailsControllerProvider.notifier)
                          .nextMonth(),
                      icon: const Icon(Icons.chevron_right),
                      tooltip: 'Next month',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s16),
                if (!state.hasRecord)
                  const AppEmptyState(
                    title: 'No draw recorded',
                    message: 'No draw is recorded for this month yet.',
                    icon: Icons.info_outline,
                  )
                else ...[
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Row(
                          label: 'Method',
                          value: state.methodLabel ?? '—',
                          valueKey: const Key('draw_record_method'),
                        ),
                        const SizedBox(height: AppSpacing.s12),
                        _Row(
                          label: 'Proof reference',
                          value: state.proofReference ?? '—',
                          valueKey: const Key('draw_record_proof_ref'),
                        ),
                        const SizedBox(height: AppSpacing.s12),
                        _Row(
                          label: 'Winner',
                          value: state.winnerLabel ?? '—',
                          valueKey: const Key('draw_record_winner'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  AppCard(
                    child: _Row(
                      label: 'Status',
                      value:
                          '${state.statusLabel} (witnesses: ${state.witnessCount})',
                      valueKey: const Key('draw_record_status'),
                    ),
                  ),
                  const Spacer(),
                  AppButton.primary(
                    key: const Key('draw_collect_witnesses'),
                    label: 'Collect witness sign-offs',
                    onPressed: state.drawId == null
                        ? null
                        : () => context.push(
                              drawWitnessesLocation,
                              extra: state.drawId,
                            ),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  AppButton.secondary(
                    key: const Key('draw_redo'),
                    label: 'Redo draw',
                    onPressed: state.drawId == null
                        ? null
                        : () => context.push(
                              drawRedoLocation,
                              extra: state.drawId,
                            ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    required this.valueKey,
  });

  final String label;
  final String value;
  final Key valueKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(width: AppSpacing.s12),
        Expanded(
          child: Text(
            value,
            key: valueKey,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

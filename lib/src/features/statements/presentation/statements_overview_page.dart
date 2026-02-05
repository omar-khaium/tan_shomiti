import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_status_chip.dart';
import '../../../core/ui/formatters/billing_month_label.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'providers/statements_providers.dart';

class StatementsOverviewPage extends ConsumerWidget {
  const StatementsOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(statementsUiStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Statements')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: ui.when(
          loading: () => const Center(child: AppLoadingState()),
          error: (error, stack) => Center(
            child: AppErrorState(
              message: 'Failed to load statements.',
              onRetry: () => ref.invalidate(statementsControllerProvider),
            ),
          ),
          data: (state) {
            final monthLabel = formatBillingMonthLabel(state.month);
            final ready = state.isReadyToGenerate;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      key: const Key('statement_prev_month'),
                      onPressed: () => ref
                          .read(statementsControllerProvider.notifier)
                          .previousMonth(),
                      icon: const Icon(Icons.chevron_left),
                      tooltip: 'Previous month',
                    ),
                    Expanded(
                      child: Text(
                        monthLabel,
                        key: const Key('statement_month_label'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      key: const Key('statement_next_month'),
                      onPressed: () => ref
                          .read(statementsControllerProvider.notifier)
                          .nextMonth(),
                      icon: const Icon(Icons.chevron_right),
                      tooltip: 'Next month',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s16),
                AppCard(
                  child: Row(
                    children: [
                      const Expanded(child: Text('Statement status')),
                      AppStatusChip(
                        key: const Key('statement_ready_badge'),
                        label: ready ? 'Ready' : 'Not ready',
                        kind:
                            ready ? AppStatusKind.success : AppStatusKind.warning,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                AppButton.primary(
                  key: const Key('statement_generate'),
                  label: 'Generate statement',
                  onPressed: ready
                      ? () => context.push(statementDetailsLocation)
                      : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


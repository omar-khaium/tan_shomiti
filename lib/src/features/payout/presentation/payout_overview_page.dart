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
import 'providers/payout_providers.dart';

class PayoutOverviewPage extends ConsumerWidget {
  const PayoutOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(payoutUiStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Payout')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: ui.when(
          loading: () => const Center(child: AppLoadingState()),
          error: (error, stack) => Center(
            child: AppErrorState(
              message: 'Failed to load payout.',
              onRetry: () => ref.invalidate(payoutControllerProvider),
            ),
          ),
          data: (state) {
            final monthLabel = formatBillingMonthLabel(state.month);
            final prereq = state.prerequisites;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      key: const Key('payout_prev_month'),
                      onPressed: () => ref
                          .read(payoutControllerProvider.notifier)
                          .previousMonth(),
                      icon: const Icon(Icons.chevron_left),
                      tooltip: 'Previous month',
                    ),
                    Expanded(
                      child: Text(
                        monthLabel,
                        key: const Key('payout_month_label'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      key: const Key('payout_next_month'),
                      onPressed: () => ref
                          .read(payoutControllerProvider.notifier)
                          .nextMonth(),
                      icon: const Icon(Icons.chevron_right),
                      tooltip: 'Next month',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s16),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prerequisites',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.s12),
                      _PrereqRow(
                        keyLabel: const Key('payout_prereq_draw'),
                        label: 'Draw recorded (finalized)',
                        ok: prereq.hasRecordedDraw && prereq.isDrawFinalized,
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      _PrereqRow(
                        keyLabel: const Key('payout_prereq_collection'),
                        label: 'Collection verified (no short pot payout)',
                        ok: prereq.isCollectionVerified &&
                            prereq.isCollectionComplete,
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      _PrereqRow(
                        keyLabel: const Key('payout_prereq_treasurer'),
                        label: 'Treasurer approval',
                        ok: prereq.hasTreasurerApproval,
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      _PrereqRow(
                        keyLabel: const Key('payout_prereq_auditor'),
                        label: 'Auditor/witness approval',
                        ok: prereq.hasAuditorApproval,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                AppButton.primary(
                  key: const Key('payout_continue'),
                  label: 'Continue',
                  onPressed: () => context.push(payoutCollectionLocation),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PrereqRow extends StatelessWidget {
  const _PrereqRow({
    required this.keyLabel,
    required this.label,
    required this.ok,
  });

  final Key keyLabel;
  final String label;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label, key: keyLabel),
        ),
        AppStatusChip(
          label: ok ? 'OK' : 'Missing',
          kind: ok ? AppStatusKind.success : AppStatusKind.warning,
        ),
      ],
    );
  }
}

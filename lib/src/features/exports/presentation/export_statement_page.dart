import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/formatters/billing_month_label.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import '../../statements/presentation/providers/statements_domain_providers.dart';

class ExportStatementPage extends ConsumerStatefulWidget {
  const ExportStatementPage({super.key});

  @override
  ConsumerState<ExportStatementPage> createState() =>
      _ExportStatementPageState();
}

class _ExportStatementPageState extends ConsumerState<ExportStatementPage> {
  BillingMonth _month = BillingMonth.fromDate(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final shomitiAsync = ref.watch(activeShomitiProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Export statement')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: shomitiAsync.when(
          loading: () => const Center(child: AppLoadingState()),
          error: (error, stack) => Center(
            child: AppErrorState(
              message: 'Failed to load shomiti.',
              onRetry: () => ref.invalidate(activeShomitiProvider),
            ),
          ),
          data: (shomiti) {
            if (shomiti == null) {
              return const AppCard(
                child: Text('Shomiti is not configured.'),
              );
            }

            final statementAsync = ref.watch(
              statementByMonthProvider(
                StatementMonthArgs(
                  shomitiId: shomiti.id,
                  month: _month,
                ),
              ),
            );

            final monthLabel = formatBillingMonthLabel(_month);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      key: const Key('export_statement_prev_month'),
                      onPressed: () => setState(() => _month = _month.previous()),
                      icon: const Icon(Icons.chevron_left),
                      tooltip: 'Previous month',
                    ),
                    Expanded(
                      child: Text(
                        monthLabel,
                        key: const Key('export_statement_month_label'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      key: const Key('export_statement_next_month'),
                      onPressed: () => setState(() => _month = _month.next()),
                      icon: const Icon(Icons.chevron_right),
                      tooltip: 'Next month',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s16),
                AppCard(
                  child: statementAsync.when(
                    loading: () => const AppLoadingState(),
                    error: (error, stack) => const Text(
                      'Failed to load statement.',
                      key: Key('export_statement_error'),
                    ),
                    data: (statement) {
                      if (statement == null) {
                        return const Text(
                          'No statement generated for this month yet.',
                          key: Key('export_statement_empty'),
                        );
                      }

                      return const Text(
                        'Statement found. Export options are available in the next stage.',
                        key: Key('export_statement_ready'),
                      );
                    },
                  ),
                ),
                const Spacer(),
                AppButton.primary(
                  key: const Key('export_statement_generate'),
                  label: 'Generate export (coming soon)',
                  onPressed: null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


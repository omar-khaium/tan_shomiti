import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../domain/entities/monthly_checklist_completion.dart';
import '../domain/value_objects/monthly_checklist_step.dart';
import '../../shomiti_setup/domain/entities/shomiti.dart';
import 'providers/operations_providers.dart';

final selectedOpsMonthProvider = StateProvider<BillingMonth>((ref) {
  return BillingMonth.fromDate(DateTime.now());
});

class OperationsDashboardPage extends ConsumerWidget {
  const OperationsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(selectedOpsMonthProvider);
    final checklistAsync = ref.watch(monthlyChecklistForMonthProvider(month));
    final checklist = checklistAsync.value ?? const [];
    final completedCount = checklist.where((c) => c.isCompleted).length;
    final progress = checklist.isEmpty ? 0.0 : completedCount / checklist.length;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s16),
      children: [
        Row(
          children: [
            IconButton(
              key: const Key('ops_month_prev'),
              tooltip: 'Previous month',
              onPressed: () {
                ref.read(selectedOpsMonthProvider.notifier).state =
                    month.previous();
              },
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Text(
                'Operations — ${month.key}',
                key: const Key('ops_month_title'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              key: const Key('ops_month_next'),
              tooltip: 'Next month',
              onPressed: () {
                ref.read(selectedOpsMonthProvider.notifier).state = month.next();
              },
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s12),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Monthly checklist (Rules §17)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.s8),
              Text('$completedCount/${MonthlyChecklistStep.values.length} completed'),
              const SizedBox(height: AppSpacing.s8),
              LinearProgressIndicator(value: progress),
              const SizedBox(height: AppSpacing.s16),
              if (checklistAsync.isLoading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.s8),
                  child: LinearProgressIndicator(),
                ),
              if (checklistAsync.hasError)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
                  child: Text(
                    'Failed to load checklist.',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              for (final completion in (checklist.isEmpty
                  ? [
                      for (final item in MonthlyChecklistStep.values)
                        MonthlyChecklistCompletion(item: item, completedAt: null),
                    ]
                  : checklist)) ...[
                _ChecklistRow(
                  month: month,
                  completion: completion,
                ),
                const Divider(height: AppSpacing.s16),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({
    required this.month,
    required this.completion,
  });

  final BillingMonth month;
  final MonthlyChecklistCompletion completion;

  @override
  Widget build(BuildContext context) {
    final item = _OpsChecklistItem.fromDomain(completion.item);
    final completedAt = completion.completedAt;
    final completedAtLabel =
        completedAt == null ? null : MaterialLocalizations.of(context).formatTimeOfDay(
              TimeOfDay.fromDateTime(completedAt),
            );

    return Row(
      children: [
        Expanded(
          child: CheckboxListTile(
            key: Key('ops_check_${completion.item.key}'),
            value: completion.isCompleted,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(item.title),
            subtitle: Text(
              completedAtLabel == null
                  ? item.subtitle
                  : '${item.subtitle}\nCompleted at $completedAtLabel',
            ),
            onChanged: (value) async {
              if (value == null) return;
              final container = ProviderScope.containerOf(context);
              await container.read(setMonthlyChecklistItemCompletionProvider)(
                    shomitiId: activeShomitiId,
                    month: month,
                    item: completion.item,
                    isCompleted: value,
                    now: DateTime.now(),
                  );
              container.invalidate(monthlyChecklistForMonthProvider(month));
            },
          ),
        ),
        TextButton(
          key: Key('ops_go_${completion.item.key}'),
          onPressed: item.location == null
              ? null
              : () => context.push(item.location!),
          child: const Text('Go'),
        ),
      ],
    );
  }
}

class _OpsChecklistItem {
  const _OpsChecklistItem({
    required this.itemKey,
    required this.title,
    required this.subtitle,
    required this.location,
  });

  final String itemKey;
  final String title;
  final String subtitle;
  final String? location;

  static _OpsChecklistItem fromDomain(MonthlyChecklistStep item) {
    return switch (item.key) {
      'attendance' => _OpsChecklistItem(
        itemKey: item.key,
        title: 'Confirm attendance/proxies',
        subtitle: 'Record who attended or who is represented by proxy.',
        location: membersLocation,
      ),
      'payments' => _OpsChecklistItem(
        itemKey: item.key,
        title: 'Confirm payments received (or apply §9 policy)',
        subtitle: 'Ensure the pot is complete or resolve shortfall.',
        location: contributionsLocation,
      ),
      'draw' => _OpsChecklistItem(
        itemKey: item.key,
        title: 'Run draw with witnesses',
        subtitle: 'Record draw integrity and witness sign-off.',
        location: drawLocation,
      ),
      'payout_amount' => _OpsChecklistItem(
        itemKey: item.key,
        title: 'Announce winner and payout amount',
        subtitle: 'Confirm winner and the full pot amount before payout.',
        location: payoutLocation,
      ),
      'payout_proof' => _OpsChecklistItem(
        itemKey: item.key,
        title: 'Send payout and share proof',
        subtitle: 'Store and share payout proof inside the group channel.',
        location: payoutLocation,
      ),
      'publish_statement' => _OpsChecklistItem(
        itemKey: item.key,
        title: 'Publish ledger + monthly statement',
        subtitle: 'Generate statement and ensure it is signed-off.',
        location: statementsLocation,
      ),
      _ => _OpsChecklistItem(
        itemKey: item.key,
        title: item.key,
        subtitle: '',
        location: null,
      ),
    };
  }
}

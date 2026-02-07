import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../contributions/domain/value_objects/billing_month.dart';

final selectedOpsMonthProvider = StateProvider<BillingMonth>((ref) {
  return BillingMonth.fromDate(DateTime.now());
});

/// Stage 2 (UI): in-memory completion state, keyed by BillingMonth.key.
final opsChecklistDraftProvider =
    StateProvider<Map<String, Set<String>>>((ref) => {});

class OperationsDashboardPage extends ConsumerWidget {
  const OperationsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConfigured = ref.watch(shomitiConfiguredProvider);
    if (!isConfigured) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: AppEmptyState(
          icon: Icons.dashboard_outlined,
          title: 'No Shomiti yet',
          message: 'Complete setup to start using the monthly checklist.',
        ),
      );
    }

    final month = ref.watch(selectedOpsMonthProvider);
    final monthKey = month.key;
    final completedByMonth = ref.watch(opsChecklistDraftProvider);
    final completed = completedByMonth[monthKey] ?? const <String>{};

    const items = _opsChecklistItems;
    final progress = items.isEmpty ? 0.0 : completed.length / items.length;

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
              Text('${completed.length}/${items.length} completed'),
              const SizedBox(height: AppSpacing.s8),
              LinearProgressIndicator(value: progress),
              const SizedBox(height: AppSpacing.s16),
              for (final item in items) ...[
                _ChecklistRow(
                  item: item,
                  isCompleted: completed.contains(item.key),
                  onChanged: (value) {
                    final next = Map<String, Set<String>>.from(
                      ref.read(opsChecklistDraftProvider),
                    );
                    final set = Set<String>.from(next[monthKey] ?? const {});
                    if (value == true) {
                      set.add(item.key);
                    } else {
                      set.remove(item.key);
                    }
                    next[monthKey] = set;
                    ref.read(opsChecklistDraftProvider.notifier).state = next;
                  },
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
    required this.item,
    required this.isCompleted,
    required this.onChanged,
  });

  final _OpsChecklistItem item;
  final bool isCompleted;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CheckboxListTile(
            key: Key('ops_check_${item.key}'),
            value: isCompleted,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(item.title),
            subtitle: Text(item.subtitle),
            onChanged: onChanged,
          ),
        ),
        TextButton(
          key: Key('ops_go_${item.key}'),
          onPressed: item.location == null
              ? null
              : () => context.push(item.location!),
          child: const Text('Go'),
        ),
      ],
    );
  }
}

@immutable
class _OpsChecklistItem {
  const _OpsChecklistItem({
    required this.key,
    required this.title,
    required this.subtitle,
    required this.location,
  });

  final String key;
  final String title;
  final String subtitle;
  final String? location;
}

const _opsChecklistItems = <_OpsChecklistItem>[
  _OpsChecklistItem(
    key: 'attendance',
    title: 'Confirm attendance/proxies',
    subtitle: 'Record who attended or who is represented by proxy.',
    location: membersLocation,
  ),
  _OpsChecklistItem(
    key: 'payments',
    title: 'Confirm payments received (or apply §9 policy)',
    subtitle: 'Ensure the pot is complete or resolve shortfall.',
    location: contributionsLocation,
  ),
  _OpsChecklistItem(
    key: 'draw',
    title: 'Run draw with witnesses',
    subtitle: 'Record draw integrity and witness sign-off.',
    location: drawLocation,
  ),
  _OpsChecklistItem(
    key: 'payout_amount',
    title: 'Announce winner and payout amount',
    subtitle: 'Confirm winner and the full pot amount before payout.',
    location: payoutLocation,
  ),
  _OpsChecklistItem(
    key: 'payout_proof',
    title: 'Send payout and share proof',
    subtitle: 'Store and share payout proof inside the group channel.',
    location: payoutLocation,
  ),
  _OpsChecklistItem(
    key: 'publish_statement',
    title: 'Publish ledger + monthly statement',
    subtitle: 'Generate statement and ensure it is signed-off.',
    location: statementsLocation,
  ),
];


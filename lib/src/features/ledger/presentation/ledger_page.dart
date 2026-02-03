import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_list_row.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'providers/ledger_providers.dart';

class LedgerPage extends ConsumerWidget {
  const LedgerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(ledgerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ledger')),
      body: entries.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(
            message: 'Failed to load ledger.',
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No ledger entries yet',
                message:
                    'Once dues and payouts are recorded, entries will show up here.',
                icon: Icons.table_view_outlined,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.s16),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = items[index];
              final formattedDate =
                  MaterialLocalizations.of(context).formatShortDate(
                entry.occurredAt,
              );

              return AppListRow(
                title: 'BDT ${entry.amount.takaFloor} (${entry.direction.name})',
                value: entry.note ?? formattedDate,
              );
            },
          );
        },
      ),
    );
  }
}

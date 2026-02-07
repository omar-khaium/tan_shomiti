import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_status_chip.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../domain/entities/dispute.dart';
import '../domain/entities/dispute_step.dart';
import 'providers/disputes_providers.dart';

class DisputesPage extends ConsumerWidget {
  const DisputesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final disputesAsync = ref.watch(disputesProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(disputesTitle),
          bottom: const TabBar(
            tabs: [
              Tab(key: Key('disputes_tab_open'), text: 'Open'),
              Tab(key: Key('disputes_tab_resolved'), text: 'Resolved'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          key: const Key('disputes_create'),
          onPressed: () => context.push(disputeCreateLocation),
          label: const Text('Create dispute'),
          icon: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.s16),
          child: disputesAsync.when(
            loading: () => const AppLoadingState(),
            error: (error, stack) => AppErrorState(
              message: 'Failed to load disputes.',
              onRetry: () => ref.invalidate(disputesProvider),
            ),
            data: (disputes) {
              final open = disputes
                  .where((d) => d.status == DisputeStatus.open)
                  .toList(growable: false);
              final resolved = disputes
                  .where((d) => d.status == DisputeStatus.resolved)
                  .toList(growable: false);

              return TabBarView(
                children: [
                  _DisputesList(
                    disputes: open,
                    emptyKey: const Key('disputes_open_empty'),
                    emptyTitle: 'No open disputes',
                    emptyMessage:
                        'Create a dispute to track the Section 13 resolution steps.',
                  ),
                  _DisputesList(
                    disputes: resolved,
                    emptyKey: const Key('disputes_resolved_empty'),
                    emptyTitle: 'No resolved disputes',
                    emptyMessage: 'Resolved disputes will appear here.',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DisputesList extends StatelessWidget {
  const _DisputesList({
    required this.disputes,
    required this.emptyKey,
    required this.emptyTitle,
    required this.emptyMessage,
  });

  final List<Dispute> disputes;
  final Key emptyKey;
  final String emptyTitle;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (disputes.isEmpty) {
      return AppEmptyState(
        key: emptyKey,
        title: emptyTitle,
        message: emptyMessage,
        icon: Icons.gavel,
      );
    }

    return ListView.separated(
      key: const Key('disputes_list'),
      itemCount: disputes.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final d = disputes[index];
        final created = MaterialLocalizations.of(context).formatShortDate(
          d.createdAt,
        );

        final chip = switch (d.status) {
          DisputeStatus.resolved => const AppStatusChip(
              label: 'Resolved',
              kind: AppStatusKind.success,
            ),
          DisputeStatus.open => AppStatusChip(
              label: d.currentStep.title,
              kind: AppStatusKind.info,
            ),
        };

        return ListTile(
          key: Key('dispute_row_${d.id}'),
          title: Text(d.title),
          subtitle: Text('Created $created'),
          trailing: chip,
          onTap: () => context.push(disputeDetailsLocation(d.id)),
        );
      },
    );
  }
}

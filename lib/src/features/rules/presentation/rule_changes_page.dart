import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../../app/router/app_router.dart';
import '../domain/entities/rule_set_version.dart';
import 'providers/rules_viewer_providers.dart';

class RuleChangesPage extends ConsumerWidget {
  const RuleChangesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(rulesViewerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rule changes')),
      body: version.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load rules.'),
        ),
        data: (data) {
          if (data == null) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No rules snapshot found',
                message:
                    'Create a Shomiti first. Rule changes require an existing rules snapshot.',
                icon: Icons.rule_folder_outlined,
              ),
            );
          }

          return _RuleChangesBody(version: data);
        },
      ),
    );
  }
}

class _RuleChangesBody extends StatelessWidget {
  const _RuleChangesBody({required this.version});

  final RuleSetVersion version;

  @override
  Widget build(BuildContext context) {
    final createdAt = MaterialLocalizations.of(context).formatShortDate(
      version.createdAt,
    );

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s16),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Active rules snapshot',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.s8),
              _FieldRow(
                label: 'Version id',
                value: version.id,
                valueKey: const Key('rule_changes_active_version_id'),
              ),
              _FieldRow(label: 'Created', value: createdAt),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s16),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pending change',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.s8),
              const Text(
                'No pending change yet.',
                key: Key('rule_changes_pending_empty'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s16),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'History',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.s8),
              const Text(
                'No rule changes recorded yet.',
                key: Key('rule_changes_history_empty'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s16),
        AppButton.primary(
          key: const Key('rule_changes_propose'),
          label: 'Propose change',
          onPressed: () => context.push(ruleChangesProposeLocation),
        ),
      ],
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.label,
    required this.value,
    this.valueKey,
  });

  final String label;
  final String value;
  final Key? valueKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              key: valueKey,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}


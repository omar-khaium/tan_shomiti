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
import 'providers/rule_changes_providers.dart';
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

class _RuleChangesBody extends ConsumerWidget {
  const _RuleChangesBody({required this.version});

  final RuleSetVersion version;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createdAt = MaterialLocalizations.of(
      context,
    ).formatShortDate(version.createdAt);

    final pending = ref.watch(pendingRuleAmendmentProvider);
    final history = ref.watch(ruleAmendmentsProvider);

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
              pending.when(
                loading: () => const Text('Loading…'),
                error: (error, stack) => const Text(
                  'Failed to load pending change.',
                  key: Key('rule_changes_pending_error'),
                ),
                data: (data) {
                  if (data == null) {
                    return const Text(
                      'No pending change yet.',
                      key: Key('rule_changes_pending_empty'),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pending consent',
                        key: const Key('rule_changes_pending_label'),
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton.secondary(
                              key: const Key('rule_changes_collect_consent'),
                              label: 'Collect consent',
                              onPressed: () => context.push(
                                ruleChangesConsentLocation,
                                extra: data.id,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.s12),
                          Expanded(
                            child: AppButton.primary(
                              key: const Key('rule_changes_apply'),
                              label: 'Apply',
                              onPressed: () async {
                                try {
                                  await ref.read(applyRuleAmendmentProvider)(
                                    shomitiId: data.shomitiId,
                                    amendmentId: data.id,
                                    now: DateTime.now(),
                                  );

                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Rule change applied.'),
                                    ),
                                  );
                                } catch (e) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Failed to apply: $e'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s16),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('History', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.s8),
              history.when(
                loading: () => const Text('Loading…'),
                error: (error, stack) => const Text(
                  'Failed to load history.',
                  key: Key('rule_changes_history_error'),
                ),
                data: (data) {
                  final applied = data
                      .where((a) => a.appliedAt != null)
                      .toList();
                  if (applied.isEmpty) {
                    return const Text(
                      'No rule changes recorded yet.',
                      key: Key('rule_changes_history_empty'),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final a in applied.take(5))
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.s8),
                          child: Text(
                            'Applied: ${a.note ?? a.id}',
                            key: Key('rule_changes_history_${a.id}'),
                          ),
                        ),
                    ],
                  );
                },
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
  const _FieldRow({required this.label, required this.value, this.valueKey});

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
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
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

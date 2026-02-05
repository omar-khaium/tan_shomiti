import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../domain/usecases/defaults_exceptions.dart';
import 'models/defaults_row_ui_model.dart';
import 'providers/defaults_controller_providers.dart';

class DefaultsPage extends ConsumerWidget {
  const DefaultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows = ref.watch(defaultsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Defaults')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: rows.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => const Center(
            child: Text('Failed to load defaults. Please try again.'),
          ),
          data: (items) {
            if (items.isEmpty) {
              return const Center(child: Text('No defaults detected.'));
            }

            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.s12),
              itemBuilder: (context, index) {
                final row = items[index];
                final episodeKey = row.episodeKey;
                final controller = ref.read(defaultsControllerProvider.notifier);

                return AppCard(
                  child: Padding(
                    key: Key('defaults_row_$index'),
                    padding: const EdgeInsets.all(AppSpacing.s12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    row.memberName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                  const SizedBox(height: AppSpacing.s4),
                                  Text(
                                    'Missed payments: ${row.missedCount}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            _StatusBadge(
                              key: Key('defaults_status_$index'),
                              status: row.status,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s12),
                        Text(
                          'Next step: ${_nextStepLabel(row.nextStep)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: AppSpacing.s12),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton.secondary(
                                key: Key('defaults_record_reminder_$index'),
                                label: 'Record reminder',
                                onPressed: _isEnabled(
                                          row.nextStep,
                                          DefaultsNextStepUi.reminder,
                                        ) &&
                                        episodeKey != null
                                    ? () => _runAction(
                                          context,
                                          () => controller.recordReminder(
                                            memberId: row.memberId,
                                            episodeKey: episodeKey,
                                          ),
                                        )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s8),
                            Expanded(
                              child: AppButton.secondary(
                                key: Key('defaults_record_notice_$index'),
                                label: 'Record notice',
                                onPressed: _isEnabled(
                                          row.nextStep,
                                          DefaultsNextStepUi.notice,
                                        ) &&
                                        episodeKey != null
                                    ? () => _runAction(
                                          context,
                                          () => controller.recordNotice(
                                            memberId: row.memberId,
                                            episodeKey: episodeKey,
                                          ),
                                        )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.s8),
                        AppButton.primary(
                          key: Key('defaults_apply_guarantor_$index'),
                          label: 'Apply guarantor / deposit',
                          onPressed: _isEnabled(
                                row.nextStep,
                                DefaultsNextStepUi.guarantorOrDeposit,
                              )
                              && episodeKey != null
                              ? () => _runAction(
                                    context,
                                    () => controller.applyGuarantorOrDeposit(
                                      memberId: row.memberId,
                                      episodeKey: episodeKey,
                                    ),
                                  )
                              : null,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  static bool _isEnabled(DefaultsNextStepUi current, DefaultsNextStepUi step) {
    return current == step;
  }

  static String _nextStepLabel(DefaultsNextStepUi step) => switch (step) {
        DefaultsNextStepUi.none => 'None',
        DefaultsNextStepUi.reminder => 'Reminder',
        DefaultsNextStepUi.notice => 'Written notice',
        DefaultsNextStepUi.guarantorOrDeposit => 'Guarantor / deposit',
        DefaultsNextStepUi.dispute => 'Dispute',
      };

  static Future<void> _runAction(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    try {
      await action();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved.')),
      );
    } on DefaultsValidationException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Please try again.')),
      );
    }
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({super.key, required this.status});

  final DefaultsStatusUi status;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      DefaultsStatusUi.clear => ('Clear', Colors.green),
      DefaultsStatusUi.atRisk => ('At risk', Colors.orange),
      DefaultsStatusUi.inDefault => ('In default', Colors.red),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s8,
          vertical: AppSpacing.s4,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: color),
        ),
      ),
    );
  }
}

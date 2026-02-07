import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../domain/entities/rule_set_snapshot.dart';
import 'providers/rule_changes_providers.dart';
import 'providers/rules_viewer_providers.dart';
import '../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';

class ProposeRuleChangePage extends ConsumerStatefulWidget {
  const ProposeRuleChangePage({super.key});

  @override
  ConsumerState<ProposeRuleChangePage> createState() =>
      _ProposeRuleChangePageState();
}

class _ProposeRuleChangePageState extends ConsumerState<ProposeRuleChangePage> {
  final _formKey = GlobalKey<FormState>();

  final _shareValueController = TextEditingController();
  final _paymentDeadlineController = TextEditingController();
  final _meetingScheduleController = TextEditingController();

  final _noteController = TextEditingController();
  final _sharedRefController = TextEditingController();

  @override
  void dispose() {
    _shareValueController.dispose();
    _paymentDeadlineController.dispose();
    _meetingScheduleController.dispose();
    _noteController.dispose();
    _sharedRefController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shomiti = ref.watch(activeShomitiProvider);
    final version = ref.watch(rulesViewerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Propose rule change')),
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
              child: AppErrorState(message: 'No active rules snapshot found.'),
            );
          }

          final snapshot = data.snapshot;
          _shareValueController.text = _shareValueController.text.isEmpty
              ? '${snapshot.shareValueBdt}'
              : _shareValueController.text;
          _paymentDeadlineController.text =
              _paymentDeadlineController.text.isEmpty
              ? snapshot.paymentDeadline
              : _paymentDeadlineController.text;
          _meetingScheduleController.text =
              _meetingScheduleController.text.isEmpty
              ? snapshot.meetingSchedule
              : _meetingScheduleController.text;

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.s16),
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Change fields (MVP)',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      TextFormField(
                        key: const Key('rule_change_share_value'),
                        controller: _shareValueController,
                        decoration: const InputDecoration(
                          labelText: 'Share value (BDT)',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final v = int.tryParse(value?.trim() ?? '');
                          if (v == null || v <= 0) return 'Required';
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.s12),
                      TextFormField(
                        key: const Key('rule_change_meeting_schedule'),
                        controller: _meetingScheduleController,
                        decoration: const InputDecoration(
                          labelText: 'Meeting schedule',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.s12),
                      TextFormField(
                        key: const Key('rule_change_payment_deadline'),
                        controller: _paymentDeadlineController,
                        decoration: const InputDecoration(
                          labelText: 'Payment deadline',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Written record',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      TextFormField(
                        key: const Key('rule_change_note'),
                        controller: _noteController,
                        decoration: const InputDecoration(
                          labelText: 'Amendment note',
                        ),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.s12),
                      TextFormField(
                        key: const Key('rule_change_shared_ref'),
                        controller: _sharedRefController,
                        decoration: const InputDecoration(
                          labelText: 'Shared reference (optional now)',
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
                AppButton.primary(
                  key: const Key('rule_change_propose'),
                  label: 'Propose',
                  onPressed: shomiti.maybeWhen(
                    data: (s) => s == null
                        ? null
                        : () async {
                            if (!(_formKey.currentState?.validate() ?? false)) {
                              return;
                            }

                            final proposedSnapshot = _applyMvpEdits(
                              snapshot,
                              shareValueBdt: int.parse(
                                _shareValueController.text.trim(),
                              ),
                              meetingSchedule: _meetingScheduleController.text
                                  .trim(),
                              paymentDeadline: _paymentDeadlineController.text
                                  .trim(),
                            );

                            try {
                              final amendmentId =
                                  await ref.read(proposeRuleAmendmentProvider)(
                                    shomitiId: s.id,
                                    proposedSnapshot: proposedSnapshot,
                                    note: _noteController.text,
                                    sharedReference: _sharedRefController.text,
                                    now: DateTime.now(),
                                  );

                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Rule change proposed.'),
                                ),
                              );
                              context.go(
                                ruleChangesConsentLocation,
                                extra: amendmentId,
                              );
                            } catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed: $e')),
                              );
                            }
                          },
                    orElse: () => null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  RuleSetSnapshot _applyMvpEdits(
    RuleSetSnapshot base, {
    required int shareValueBdt,
    required String meetingSchedule,
    required String paymentDeadline,
  }) {
    return RuleSetSnapshot(
      schemaVersion: base.schemaVersion,
      shomitiName: base.shomitiName,
      startDate: base.startDate,
      groupType: base.groupType,
      memberCount: base.memberCount,
      shareValueBdt: shareValueBdt,
      maxSharesPerPerson: base.maxSharesPerPerson,
      allowShareTransfers: base.allowShareTransfers,
      cycleLengthMonths: base.cycleLengthMonths,
      meetingSchedule: meetingSchedule,
      paymentDeadline: paymentDeadline,
      payoutMethod: base.payoutMethod,
      groupChannel: base.groupChannel,
      missedPaymentPolicy: base.missedPaymentPolicy,
      gracePeriodDays: base.gracePeriodDays,
      lateFeeBdtPerDay: base.lateFeeBdtPerDay,
      defaultConsecutiveMissedThreshold: base.defaultConsecutiveMissedThreshold,
      defaultTotalMissedThreshold: base.defaultTotalMissedThreshold,
      feesEnabled: base.feesEnabled,
      feeAmountBdt: base.feeAmountBdt,
      feePayerModel: base.feePayerModel,
      ruleChangeAfterStartRequiresUnanimous:
          base.ruleChangeAfterStartRequiresUnanimous,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'providers/draw_domain_providers.dart';
import 'providers/draw_providers.dart';

class WitnessSignoffPage extends ConsumerStatefulWidget {
  const WitnessSignoffPage({required this.drawId, super.key});

  final String drawId;

  @override
  ConsumerState<WitnessSignoffPage> createState() => _WitnessSignoffPageState();
}

class _WitnessSignoffPageState extends ConsumerState<WitnessSignoffPage> {
  final _noteController = TextEditingController();
  String? _selectedWitnessId;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draw = ref.watch(drawRecordByIdProvider(widget.drawId));
    final approvals = ref.watch(drawWitnessApprovalsProvider(widget.drawId));
    final members = ref.watch(membersForDrawProvider(widget.drawId));

    return Scaffold(
      appBar: AppBar(title: const Text('Witness sign-off')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: draw.when(
          loading: () => const Center(child: AppLoadingState()),
          error: (error, stack) =>
              const Center(child: AppErrorState(message: 'Failed to load draw.')),
          data: (drawRecord) {
            if (drawRecord == null) {
              return const AppEmptyState(
                title: 'Draw not found',
                message: 'The selected draw record could not be loaded.',
                icon: Icons.info_outline,
              );
            }

            return approvals.when(
              loading: () => const Center(child: AppLoadingState()),
              error: (error, stack) => const Center(
                child: AppErrorState(message: 'Failed to load witness approvals.'),
              ),
              data: (signedOff) {
                final signedOffCount = signedOff.length;
                final canFinalize =
                    signedOffCount >= 2 && !drawRecord.isInvalidated;
                final alreadySigned = _selectedWitnessId != null &&
                    signedOff.any((a) => a.witnessMemberId == _selectedWitnessId);
                final canConfirm = _selectedWitnessId != null &&
                    !alreadySigned &&
                    !drawRecord.isInvalidated;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'At least 2 witnesses must confirm the draw result.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    Text(
                      'Signed off: $signedOffCount / 2',
                      key: const Key('witness_count_label'),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.s16),
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add witness',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: AppSpacing.s12),
                          members.when(
                            loading: () => const AppLoadingState(),
                            error: (e, s) => const AppErrorState(
                              message: 'Failed to load members.',
                            ),
                            data: (items) {
                              return DropdownButtonFormField<String>(
                                key: const Key('witness_member_picker'),
                                decoration: const InputDecoration(
                                  labelText: 'Witness member',
                                  border: OutlineInputBorder(),
                                ),
                                initialValue: _selectedWitnessId,
                                items: [
                                  for (final m in items)
                                    DropdownMenuItem(
                                      value: m.id,
                                      child: Text(m.fullName),
                                    ),
                                ],
                                onChanged: (value) =>
                                    setState(() => _selectedWitnessId = value),
                              );
                            },
                          ),
                          const SizedBox(height: AppSpacing.s12),
                          TextField(
                            key: const Key('witness_note'),
                            controller: _noteController,
                            decoration: const InputDecoration(
                              labelText: 'Note (optional)',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: AppSpacing.s12),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton.primary(
                                  key: const Key('witness_confirm'),
                                  label: 'Confirm',
                                  onPressed: canConfirm
                                      ? () => _confirm(
                                            drawId: drawRecord.id,
                                            ruleSetVersionId:
                                                drawRecord.ruleSetVersionId,
                                          )
                                      : null,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.s12),
                              Expanded(
                                child: AppButton.secondary(
                                  key: const Key('witness_add'),
                                  label: 'Clear',
                                  onPressed: _clearForm,
                                ),
                              ),
                            ],
                          ),
                          if (alreadySigned) ...[
                            const SizedBox(height: AppSpacing.s12),
                            Text(
                              'This witness already signed off.',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s16),
                    Expanded(
                      child: ListView.separated(
                        itemCount: signedOff.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: AppSpacing.s8),
                        itemBuilder: (context, index) {
                          final item = signedOff[index];
                          return AppCard(
                            child: Row(
                              children: [
                                Expanded(child: Text(item.witnessMemberId)),
                                if (item.note != null) ...[
                                  const SizedBox(width: AppSpacing.s12),
                                  Expanded(
                                    child: Text(
                                      item.note!,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    AppButton.primary(
                      key: const Key('witness_finalize'),
                      label: 'Mark draw finalized',
                      onPressed: canFinalize
                          ? () => _finalize(drawId: drawRecord.id)
                          : null,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirm({
    required String drawId,
    required String ruleSetVersionId,
  }) async {
    final witnessId = _selectedWitnessId;
    if (witnessId == null) return;

    try {
      await ref.read(recordDrawWitnessApprovalProvider)(
            drawId: drawId,
            witnessMemberId: witnessId,
            ruleSetVersionId: ruleSetVersionId,
            note: _noteController.text,
            now: DateTime.now(),
          );
      ref.invalidate(drawWitnessApprovalsProvider(drawId));
      _clearForm();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to record witness: $e')),
      );
    }
  }

  void _clearForm() {
    setState(() {
      _selectedWitnessId = null;
      _noteController.clear();
    });
  }

  Future<void> _finalize({required String drawId}) async {
    try {
      await ref.read(finalizeDrawRecordProvider)(
            drawId: drawId,
            now: DateTime.now(),
          );
      ref.invalidate(drawRecordDetailsControllerProvider);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to finalize: $e')),
      );
    }
  }
}

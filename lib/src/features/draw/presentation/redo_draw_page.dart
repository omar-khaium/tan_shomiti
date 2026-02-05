import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'models/draw_ui_state.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import 'providers/draw_context_providers.dart';
import 'providers/draw_domain_providers.dart';
import 'providers/draw_providers.dart';
import 'run_draw_page.dart';

class RedoDrawPage extends ConsumerStatefulWidget {
  const RedoDrawPage({required this.drawId, super.key});

  final String drawId;

  @override
  ConsumerState<RedoDrawPage> createState() => _RedoDrawPageState();
}

class _RedoDrawPageState extends ConsumerState<RedoDrawPage> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canConfirm = _reasonController.text.trim().isNotEmpty;
    final draw = ref.watch(drawRecordByIdProvider(widget.drawId));

    return Scaffold(
      appBar: AppBar(title: const Text('Redo draw')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: draw.when(
          loading: () => const Center(child: AppLoadingState()),
          error: (error, stack) => const Center(
            child: AppErrorState(message: 'Failed to load draw record.'),
          ),
          data: (record) {
            if (record == null) {
              return const AppEmptyState(
                title: 'Draw not found',
                message: 'The selected draw record could not be loaded.',
                icon: Icons.info_outline,
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppCard(
                  child: Text(
                    'Redo should be used only when the draw is compromised.',
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
                TextField(
                  key: const Key('redo_reason'),
                  controller: _reasonController,
                  decoration: const InputDecoration(
                    labelText: 'Reason',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  onChanged: (_) => setState(() {}),
                ),
                const Spacer(),
                AppButton.primary(
                  key: const Key('redo_confirm'),
                  label: 'Invalidate and redo',
                  onPressed: canConfirm
                      ? () => _confirmRedo(
                            shomitiId: record.shomitiId,
                            ruleSetVersionId: record.ruleSetVersionId,
                            month: record.month,
                          )
                      : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmRedo({
    required String shomitiId,
    required String ruleSetVersionId,
    required BillingMonth month,
  }) async {
    try {
      await ref.read(invalidateDrawRecordProvider)(
            drawId: widget.drawId,
            reason: _reasonController.text,
            now: DateTime.now(),
          );

      final drawContext = await ref.read(drawContextProvider.future);
      if (drawContext == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Setup is required to redo a draw.')),
        );
        return;
      }

      final result = await ref.read(computeDrawEligibilityProvider)(
            shomitiId: shomitiId,
            month: month,
            rules: drawContext.rules,
          );
      final eligible = result.items.where((i) => i.isEligible).toList();
      if (eligible.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No eligible entries for this month.')),
        );
        return;
      }

      final eligibleShares = [
        for (final item in eligible)
          DrawEligibleShareUiModel(
            memberId: item.memberId,
            memberName: item.memberName,
            shareIndex: item.shareIndex,
          ),
      ];

      if (!mounted) return;
      context.push(
        drawRunLocation,
        extra: RunDrawArgs(
          shomitiId: shomitiId,
          ruleSetVersionId: drawContext.ruleSetVersionId,
          month: month,
          eligibleShares: eligibleShares,
          redoOfDrawId: widget.drawId,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to redo: $e')),
      );
    }
  }
}

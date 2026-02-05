import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/formatters/billing_month_label.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../domain/value_objects/draw_method.dart';
import 'models/draw_ui_state.dart';
import 'providers/draw_domain_providers.dart';
import 'providers/draw_providers.dart';

enum DrawMethodUi {
  physicalSlips,
  numberedTokens,
  simpleRandomizer,
}

@immutable
class RunDrawArgs {
  const RunDrawArgs({
    required this.shomitiId,
    required this.ruleSetVersionId,
    required this.month,
    required this.eligibleShares,
  });

  final String shomitiId;
  final String ruleSetVersionId;
  final BillingMonth month;
  final List<DrawEligibleShareUiModel> eligibleShares;
}

class RunDrawPage extends ConsumerStatefulWidget {
  const RunDrawPage({required this.args, super.key});

  final RunDrawArgs args;

  @override
  ConsumerState<RunDrawPage> createState() => _RunDrawPageState();
}

class _RunDrawPageState extends ConsumerState<RunDrawPage> {
  DrawMethodUi? _method;
  DrawEligibleShareUiModel? _winner;
  final _proofController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _proofController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final monthLabel = formatBillingMonthLabel(widget.args.month);
    final eligible = widget.args.eligibleShares;
    final canSave = eligible.isNotEmpty &&
        _method != null &&
        _winner != null &&
        _proofController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Run draw')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: ListView(
          children: [
            Text(
              monthLabel,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Method',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  RadioGroup<DrawMethodUi>(
                    groupValue: _method,
                    onChanged: (value) => setState(() => _method = value),
                    child: Column(
                      children: const [
                        RadioListTile<DrawMethodUi>(
                          key: Key('draw_method_physical'),
                          title: Text('Physical slips'),
                          value: DrawMethodUi.physicalSlips,
                        ),
                        RadioListTile<DrawMethodUi>(
                          key: Key('draw_method_tokens'),
                          title: Text('Numbered tokens'),
                          value: DrawMethodUi.numberedTokens,
                        ),
                        RadioListTile<DrawMethodUi>(
                          key: Key('draw_method_randomizer'),
                          title: Text('Simple randomizer'),
                          value: DrawMethodUi.simpleRandomizer,
                        ),
                      ],
                    ),
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
                    'Winner',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  DropdownButtonFormField<DrawEligibleShareUiModel>(
                    decoration: const InputDecoration(
                      labelText: 'Select winning share',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: _winner,
                    items: [
                      for (final item in eligible)
                        DropdownMenuItem(
                          value: item,
                          child: Text(item.label),
                        ),
                    ],
                    onChanged: eligible.isEmpty
                        ? null
                        : (value) => setState(() => _winner = value),
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
                    'Inputs',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  TextField(
                    key: const Key('draw_proof_ref'),
                    controller: _proofController,
                    decoration: const InputDecoration(
                      labelText: 'Proof reference',
                      hintText: 'Video/screenshot/link id',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  TextField(
                    key: const Key('draw_notes'),
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notes (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            if (eligible.isEmpty)
              const AppEmptyState(
                title: 'No eligible entries',
                message:
                    'Return to the eligibility list and ensure there are eligible entries.',
                icon: Icons.info_outline,
              ),
            const SizedBox(height: AppSpacing.s16),
            AppCard(
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Selected winner',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    _winner?.label ?? '—',
                    key: const Key('draw_selected_winner'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            AppButton.primary(
              key: const Key('draw_save'),
              label: 'Save draw result',
              onPressed: canSave
                  ? () async {
                      final winner = _winner!;
                      final method = _mapMethod(_method!);
                      final eligibleKeys = [
                        for (final item in eligible) item.shareKey,
                      ];

                      try {
                        await ref.read(recordDrawResultProvider)(
                          shomitiId: widget.args.shomitiId,
                          ruleSetVersionId: widget.args.ruleSetVersionId,
                          month: widget.args.month,
                          method: method,
                          proofReference: _proofController.text,
                          notes: _notesController.text,
                          winnerMemberId: winner.memberId,
                          winnerShareIndex: winner.shareIndex,
                          eligibleShareKeys: eligibleKeys,
                          now: DateTime.now(),
                        );

                        ref.invalidate(drawControllerProvider);

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Draw result saved.')),
                        );
                        Navigator.of(context).pop();
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to save: $e')),
                        );
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  static DrawMethod _mapMethod(DrawMethodUi method) {
    return switch (method) {
      DrawMethodUi.physicalSlips => DrawMethod.physicalSlips,
      DrawMethodUi.numberedTokens => DrawMethod.numberedTokens,
      DrawMethodUi.simpleRandomizer => DrawMethod.simpleRandomizer,
    };
  }
}

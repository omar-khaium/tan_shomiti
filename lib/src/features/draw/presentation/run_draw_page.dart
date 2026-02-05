import 'package:flutter/material.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/formatters/billing_month_label.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../contributions/domain/value_objects/billing_month.dart';

enum DrawMethodUi {
  physicalSlips,
  numberedTokens,
  simpleRandomizer,
}

class RunDrawPage extends StatefulWidget {
  const RunDrawPage({required this.month, super.key});

  final BillingMonth month;

  @override
  State<RunDrawPage> createState() => _RunDrawPageState();
}

class _RunDrawPageState extends State<RunDrawPage> {
  DrawMethodUi? _method;
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
    final monthLabel = formatBillingMonthLabel(widget.month);

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
            const AppEmptyState(
              title: 'No eligible entries',
              message: 'Return to the eligibility list and ensure there are eligible entries.',
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
                    '—',
                    key: const Key('draw_selected_winner'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            AppButton.primary(
              key: const Key('draw_save'),
              label: 'Save draw result',
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}

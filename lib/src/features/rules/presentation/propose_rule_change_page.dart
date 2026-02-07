import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class ProposeRuleChangePage extends StatefulWidget {
  const ProposeRuleChangePage({super.key});

  @override
  State<ProposeRuleChangePage> createState() => _ProposeRuleChangePageState();
}

class _ProposeRuleChangePageState extends State<ProposeRuleChangePage> {
  final _noteController = TextEditingController();
  final _sharedRefController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    _sharedRefController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canContinue = _noteController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Propose rule change')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Written record',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.s8),
                TextField(
                  key: const Key('rule_change_note'),
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Amendment note',
                    helperText:
                        'Summarize what changed and why. Required to apply.',
                  ),
                  maxLines: 2,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.s12),
                TextField(
                  key: const Key('rule_change_shared_ref'),
                  controller: _sharedRefController,
                  decoration: const InputDecoration(
                    labelText: 'Shared reference (optional)',
                    helperText:
                        'Link or message id where the amendment was shared.',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s16),
          AppButton.primary(
            key: const Key('rule_change_continue'),
            label: 'Continue to consent',
            onPressed:
                canContinue ? () => context.push(ruleChangesConsentLocation) : null,
          ),
        ],
      ),
    );
  }
}


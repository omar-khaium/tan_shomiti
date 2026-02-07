import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ui/components/app_button.dart';
import '../../../../core/ui/components/app_card.dart';
import '../../../../core/ui/components/app_status_chip.dart';
import '../../../../core/ui/tokens/app_spacing.dart';
import '../models/statement_signoff_ui_model.dart';
import '../providers/statement_signoffs_providers.dart';

class StatementSignoffsSection extends ConsumerWidget {
  const StatementSignoffsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(statementSignoffStatusProvider);
    final signoffs = ref.watch(statementSignoffsControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppCard(
          child: Row(
            children: [
              const Expanded(child: Text('Sign-off status')),
              AppStatusChip(
                key: const Key('statement_signoff_status'),
                label: switch (status) {
                  StatementSignoffStatusUi.notSigned => 'Not signed',
                  StatementSignoffStatusUi.partiallySigned => 'Partially signed',
                  StatementSignoffStatusUi.signed => 'Signed',
                },
                kind: switch (status) {
                  StatementSignoffStatusUi.notSigned => AppStatusKind.warning,
                  StatementSignoffStatusUi.partiallySigned => AppStatusKind.warning,
                  StatementSignoffStatusUi.signed => AppStatusKind.success,
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s12),
        if (signoffs.isEmpty)
          const AppCard(
            child: Text(
              'No sign-offs yet.',
              key: Key('statement_signoffs_empty'),
            ),
          )
        else
          ...[
            for (var i = 0; i < signoffs.length; i++) ...[
              _SignoffRow(index: i, signoff: signoffs[i]),
              const SizedBox(height: AppSpacing.s12),
            ],
          ],
        AppButton.secondary(
          key: const Key('statement_add_signoff'),
          label: 'Add sign-off',
          onPressed: () async {
            final result = await showDialog<_NewSignoffInput>(
              context: context,
              builder: (context) => const _AddSignoffDialog(),
            );
            if (result == null) return;
            ref.read(statementSignoffsControllerProvider.notifier).addSignoff(
                  signerName: result.signerName,
                  role: result.role,
                  proofReference: result.proofReference,
                  now: DateTime.now(),
                );
          },
        ),
      ],
    );
  }
}

class _SignoffRow extends ConsumerWidget {
  const _SignoffRow({required this.index, required this.signoff});

  final int index;
  final StatementSignoffUiModel signoff;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(signoff.signerName, key: Key('statement_signoff_name_$index')),
                const SizedBox(height: AppSpacing.s4),
                Text(
                  '${signoff.roleLabel} • ${signoff.proofReference}',
                  key: Key('statement_signoff_meta_$index'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            key: Key('statement_signoff_remove_$index'),
            tooltip: 'Remove sign-off',
            onPressed: () => ref.read(statementSignoffsControllerProvider.notifier).removeAt(index),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}

@immutable
class _NewSignoffInput {
  const _NewSignoffInput({
    required this.signerName,
    required this.role,
    required this.proofReference,
  });

  final String signerName;
  final StatementSignerRoleUi role;
  final String proofReference;
}

class _AddSignoffDialog extends StatefulWidget {
  const _AddSignoffDialog();

  @override
  State<_AddSignoffDialog> createState() => _AddSignoffDialogState();
}

class _AddSignoffDialogState extends State<_AddSignoffDialog> {
  final _nameController = TextEditingController();
  final _proofController = TextEditingController();
  StatementSignerRoleUi _role = StatementSignerRoleUi.witness;

  @override
  void dispose() {
    _nameController.dispose();
    _proofController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canSave = _nameController.text.trim().isNotEmpty && _proofController.text.trim().isNotEmpty;

    return AlertDialog(
      title: const Text('Add sign-off'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key('statement_signoff_signer_name'),
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Signer name'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.s12),
          DropdownButtonFormField<StatementSignerRoleUi>(
            key: const Key('statement_signoff_role'),
            decoration: const InputDecoration(labelText: 'Role'),
            initialValue: _role,
            items: const [
              DropdownMenuItem(
                value: StatementSignerRoleUi.auditor,
                child: Text('Auditor'),
              ),
              DropdownMenuItem(
                value: StatementSignerRoleUi.witness,
                child: Text('Witness'),
              ),
            ],
            onChanged: (value) => setState(() => _role = value ?? _role),
          ),
          const SizedBox(height: AppSpacing.s12),
          TextField(
            key: const Key('statement_signoff_proof'),
            controller: _proofController,
            decoration: const InputDecoration(labelText: 'Proof reference'),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
      actions: [
        TextButton(
          key: const Key('statement_signoff_cancel'),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const Key('statement_signoff_save'),
          onPressed: canSave
              ? () => Navigator.of(context).pop(
                    _NewSignoffInput(
                      signerName: _nameController.text.trim(),
                      role: _role,
                      proofReference: _proofController.text.trim(),
                    ),
                  )
              : null,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/ui/components/app_button.dart';
import '../../../../core/ui/components/app_card.dart';
import '../../../../core/ui/components/app_status_chip.dart';
import '../../../../core/ui/tokens/app_spacing.dart';
import '../../domain/entities/statement_signer_role.dart';
import '../models/statement_signoff_ui_model.dart';
import '../providers/statement_signoffs_providers.dart';
import '../providers/statements_domain_providers.dart';

class StatementSignoffsSection extends ConsumerWidget {
  const StatementSignoffsSection({
    required this.args,
    required this.isEnabled,
    super.key,
  });

  final StatementMonthArgs args;
  final bool isEnabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(statementSignoffStatusProvider(args));
    final signoffs = ref.watch(statementSignoffsUiModelsProvider(args));

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
                  StatementSignoffStatusUi.partiallySigned =>
                    'Partially signed',
                  StatementSignoffStatusUi.signed => 'Signed',
                },
                kind: switch (status) {
                  StatementSignoffStatusUi.notSigned => AppStatusKind.warning,
                  StatementSignoffStatusUi.partiallySigned =>
                    AppStatusKind.warning,
                  StatementSignoffStatusUi.signed => AppStatusKind.success,
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s12),
        if (signoffs.isEmpty)
          AppCard(
            child: Text(
              isEnabled
                  ? 'No sign-offs yet.'
                  : 'Generate the statement before adding sign-offs.',
              key: const Key('statement_signoffs_empty'),
            ),
          )
        else ...[
          for (var i = 0; i < signoffs.length; i++) ...[
            _SignoffRow(args: args, index: i, signoff: signoffs[i]),
            const SizedBox(height: AppSpacing.s12),
          ],
        ],
        AppButton.secondary(
          key: const Key('statement_add_signoff'),
          label: 'Add sign-off',
          onPressed: isEnabled
              ? () async {
                  final result = await showDialog<_NewSignoffInput>(
                    context: context,
                    builder: (context) => _AddSignoffDialog(args: args),
                  );
                  if (result == null) return;

                  try {
                    await ref.read(recordStatementSignoffProvider)(
                      shomitiId: args.shomitiId,
                      month: args.month,
                      signerMemberId: result.signerMemberId,
                      role: result.role,
                      proofReference: result.proofReference,
                      note: result.note,
                      now: DateTime.now(),
                    );
                    ref.invalidate(statementSignoffsByMonthProvider(args));
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add sign-off: $e')),
                    );
                  }
                }
              : null,
        ),
      ],
    );
  }
}

class _SignoffRow extends ConsumerWidget {
  const _SignoffRow({
    required this.args,
    required this.index,
    required this.signoff,
  });

  final StatementMonthArgs args;
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
                Text(
                  signoff.signerName,
                  key: Key('statement_signoff_name_$index'),
                ),
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
            onPressed: () async {
              await ref.read(deleteStatementSignoffProvider)(
                shomitiId: args.shomitiId,
                month: args.month,
                signerMemberId: signoff.signerMemberId,
                now: DateTime.now(),
              );
              ref.invalidate(statementSignoffsByMonthProvider(args));
            },
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
    required this.signerMemberId,
    required this.role,
    required this.proofReference,
    required this.note,
  });

  final String signerMemberId;
  final StatementSignerRole role;
  final String proofReference;
  final String? note;
}

class _AddSignoffDialog extends ConsumerStatefulWidget {
  const _AddSignoffDialog({required this.args});

  final StatementMonthArgs args;

  @override
  ConsumerState<_AddSignoffDialog> createState() => _AddSignoffDialogState();
}

class _AddSignoffDialogState extends ConsumerState<_AddSignoffDialog> {
  final _proofController = TextEditingController();
  final _noteController = TextEditingController();
  StatementSignerRole _role = StatementSignerRole.witness;
  String? _selectedSignerId;

  @override
  void dispose() {
    _proofController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signers = ref.watch(
      statementSignoffEligibleSignersProvider(widget.args),
    );

    final canSave =
        _selectedSignerId != null && _proofController.text.trim().isNotEmpty;

    return AlertDialog(
      title: const Text('Add sign-off'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            key: const Key('statement_signoff_signer_member'),
            decoration: const InputDecoration(labelText: 'Signer'),
            initialValue: _selectedSignerId,
            items: [
              for (final s in signers)
                DropdownMenuItem(value: s.id, child: Text(s.name)),
            ],
            onChanged: (value) => setState(() => _selectedSignerId = value),
          ),
          const SizedBox(height: AppSpacing.s12),
          DropdownButtonFormField<StatementSignerRole>(
            key: const Key('statement_signoff_role'),
            decoration: const InputDecoration(labelText: 'Role'),
            initialValue: _role,
            items: const [
              DropdownMenuItem(
                value: StatementSignerRole.auditor,
                child: Text('Auditor'),
              ),
              DropdownMenuItem(
                value: StatementSignerRole.witness,
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
          const SizedBox(height: AppSpacing.s12),
          TextField(
            key: const Key('statement_signoff_note'),
            controller: _noteController,
            decoration: const InputDecoration(labelText: 'Notes (optional)'),
            maxLines: 2,
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
                    signerMemberId: _selectedSignerId!,
                    role: _role,
                    proofReference: _proofController.text.trim(),
                    note: _noteController.text.trim().isEmpty
                        ? null
                        : _noteController.text.trim(),
                  ),
                )
              : null,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

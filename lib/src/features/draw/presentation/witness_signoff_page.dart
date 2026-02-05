import 'package:flutter/material.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class WitnessSignoffPage extends StatefulWidget {
  const WitnessSignoffPage({super.key});

  @override
  State<WitnessSignoffPage> createState() => _WitnessSignoffPageState();
}

class _WitnessSignoffPageState extends State<WitnessSignoffPage> {
  final _noteController = TextEditingController();
  String? _selectedWitnessId;
  final List<_WitnessApproval> _approvals = [];

  static const _members = <_MemberOption>[
    _MemberOption(id: 'm1', label: 'Member 1'),
    _MemberOption(id: 'm2', label: 'Member 2'),
    _MemberOption(id: 'm3', label: 'Member 3'),
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signedOffCount = _approvals.length;
    final canFinalize = signedOffCount >= 2;
    final canConfirm = _selectedWitnessId != null &&
        !_approvals.any((a) => a.witnessId == _selectedWitnessId);

    return Scaffold(
      appBar: AppBar(title: const Text('Witness sign-off')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
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
                  DropdownButtonFormField<String>(
                    key: const Key('witness_member_picker'),
                    decoration: const InputDecoration(
                      labelText: 'Witness member',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: _selectedWitnessId,
                    items: [
                      for (final m in _members)
                        DropdownMenuItem(value: m.id, child: Text(m.label)),
                    ],
                    onChanged: (value) => setState(() => _selectedWitnessId = value),
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
                          onPressed: canConfirm ? _confirm : null,
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
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            Expanded(
              child: ListView.separated(
                itemCount: _approvals.length,
                separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.s8),
                itemBuilder: (context, index) {
                  final item = _approvals[index];
                  return AppCard(
                    child: Row(
                      children: [
                        Expanded(child: Text(item.witnessLabel)),
                        if (item.note != null) ...[
                          const SizedBox(width: AppSpacing.s12),
                          Expanded(
                            child: Text(
                              item.note!,
                              style: Theme.of(context).textTheme.bodySmall,
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
              onPressed: canFinalize ? () => Navigator.of(context).pop() : null,
            ),
          ],
        ),
      ),
    );
  }

  void _confirm() {
    final witnessId = _selectedWitnessId;
    if (witnessId == null) return;
    final member = _members.firstWhere((m) => m.id == witnessId);

    setState(() {
      _approvals.add(
        _WitnessApproval(
          witnessId: witnessId,
          witnessLabel: member.label,
          note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
        ),
      );
    });

    _clearForm();
  }

  void _clearForm() {
    setState(() {
      _selectedWitnessId = null;
      _noteController.clear();
    });
  }
}

class _MemberOption {
  const _MemberOption({required this.id, required this.label});

  final String id;
  final String label;
}

class _WitnessApproval {
  const _WitnessApproval({
    required this.witnessId,
    required this.witnessLabel,
    required this.note,
  });

  final String witnessId;
  final String witnessLabel;
  final String? note;
}

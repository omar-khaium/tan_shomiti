import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_text_field.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'providers/risk_controls_demo_store.dart';

class RecordGuarantorPage extends ConsumerStatefulWidget {
  const RecordGuarantorPage({
    required this.memberId,
    required this.displayName,
    super.key,
  });

  final String memberId;
  final String displayName;

  @override
  ConsumerState<RecordGuarantorPage> createState() =>
      _RecordGuarantorPageState();
}

class _RecordGuarantorPageState extends ConsumerState<RecordGuarantorPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _proofController = TextEditingController();

  String? _nameError;
  String? _phoneError;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _relationshipController.dispose();
    _proofController.dispose();
    super.dispose();
  }

  void _save() {
    setState(() {
      _nameError = null;
      _phoneError = null;
    });

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final relationship = _relationshipController.text.trim();
    final proof = _proofController.text.trim();

    var ok = true;
    if (name.isEmpty) {
      _nameError = 'Required';
      ok = false;
    }
    if (phone.isEmpty) {
      _phoneError = 'Required';
      ok = false;
    }

    if (!ok) {
      setState(() {});
      return;
    }

    ref
        .read(demoRiskControlsStoreProvider.notifier)
        .recordGuarantor(
          memberId: widget.memberId,
          guarantor: DemoGuarantor(
            name: name,
            phone: phone,
            relationship: relationship.isEmpty ? null : relationship,
            proofRef: proof.isEmpty ? null : proof,
            recordedAt: DateTime.now(),
          ),
        );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Guarantor recorded (demo).')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Guarantor • ${widget.displayName}')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        children: [
          AppTextField(
            key: const Key('guarantor_name'),
            controller: _nameController,
            label: 'Guarantor name',
            errorText: _nameError,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.s12),
          AppTextField(
            key: const Key('guarantor_phone'),
            controller: _phoneController,
            label: 'Guarantor phone',
            errorText: _phoneError,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.s12),
          AppTextField(
            key: const Key('guarantor_relationship'),
            controller: _relationshipController,
            label: 'Relationship (optional)',
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.s12),
          AppTextField(
            key: const Key('guarantor_proof'),
            controller: _proofController,
            label: 'Proof reference (optional)',
            hint: 'Receipt #, screenshot ref, etc.',
          ),
          const SizedBox(height: AppSpacing.s24),
          AppButton.primary(
            key: const Key('guarantor_save'),
            label: 'Save',
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}

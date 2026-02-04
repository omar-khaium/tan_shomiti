import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_text_field.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../domain/usecases/risk_controls_exceptions.dart';
import 'providers/risk_controls_providers.dart';

class RecordDepositPage extends ConsumerStatefulWidget {
  const RecordDepositPage({
    required this.memberId,
    required this.displayName,
    super.key,
  });

  final String memberId;
  final String displayName;

  @override
  ConsumerState<RecordDepositPage> createState() => _RecordDepositPageState();
}

class _RecordDepositPageState extends ConsumerState<RecordDepositPage> {
  final _amountController = TextEditingController();
  final _heldByController = TextEditingController();
  final _proofController = TextEditingController();

  String? _amountError;
  String? _heldByError;

  @override
  void dispose() {
    _amountController.dispose();
    _heldByController.dispose();
    _proofController.dispose();
    super.dispose();
  }

  void _save() {
    setState(() {
      _amountError = null;
      _heldByError = null;
    });

    final amount = int.tryParse(_amountController.text.trim());
    final heldBy = _heldByController.text.trim();
    final proof = _proofController.text.trim();

    var ok = true;
    if (amount == null || amount <= 0) {
      _amountError = 'Enter a positive amount';
      ok = false;
    }
    if (heldBy.isEmpty) {
      _heldByError = 'Required';
      ok = false;
    }

    if (!ok) {
      setState(() {});
      return;
    }

    ref
        .read(riskControlsControllerProvider.notifier)
        .recordSecurityDeposit(
          memberId: widget.memberId,
          amountBdt: amount!,
          heldBy: heldBy,
          proofRef: proof.isEmpty ? null : proof,
        )
        .then((_) {
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Deposit recorded.')));
          Navigator.of(context).pop();
        })
        .catchError((Object error) {
          if (!mounted) return;
          final message = error is RiskControlException
              ? error.message
              : 'Failed to record deposit.';
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deposit • ${widget.displayName}')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        children: [
          AppTextField(
            key: const Key('deposit_amount'),
            controller: _amountController,
            label: 'Amount (BDT)',
            errorText: _amountError,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.s12),
          AppTextField(
            key: const Key('deposit_held_by'),
            controller: _heldByController,
            label: 'Held by',
            hint: 'Treasurer name or role',
            errorText: _heldByError,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppSpacing.s12),
          AppTextField(
            key: const Key('deposit_proof'),
            controller: _proofController,
            label: 'Proof reference (optional)',
            hint: 'Receipt #, screenshot ref, etc.',
          ),
          const SizedBox(height: AppSpacing.s24),
          AppButton.primary(
            key: const Key('deposit_save'),
            label: 'Save',
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}

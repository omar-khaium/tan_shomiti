import 'package:flutter/material.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class PayoutProofPage extends StatefulWidget {
  const PayoutProofPage({super.key});

  @override
  State<PayoutProofPage> createState() => _PayoutProofPageState();
}

class _PayoutProofPageState extends State<PayoutProofPage> {
  final _proofController = TextEditingController();

  @override
  void dispose() {
    _proofController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canMarkPaid = _proofController.text.trim().isNotEmpty;

    // Stage 2: placeholders. Real winner/amount come in TS-403 stage3.
    const winnerLabel = '—';
    const amountLabel = '0 BDT';

    return Scaffold(
      appBar: AppBar(title: const Text('Payout proof')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  _Row(
                    label: 'Winner',
                    value: winnerLabel,
                    valueKey: Key('payout_winner_label'),
                  ),
                  SizedBox(height: AppSpacing.s8),
                  _Row(
                    label: 'Amount',
                    value: amountLabel,
                    valueKey: Key('payout_amount_label'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            TextField(
              key: const Key('payout_proof_ref'),
              controller: _proofController,
              decoration: const InputDecoration(
                labelText: 'Proof reference',
                hintText: 'Transaction id / screenshot id / link',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const Spacer(),
            AppButton.primary(
              key: const Key('payout_mark_paid'),
              label: 'Mark paid',
              onPressed: canMarkPaid ? () {} : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    required this.valueKey,
  });

  final String label;
  final String value;
  final Key valueKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, key: valueKey),
      ],
    );
  }
}


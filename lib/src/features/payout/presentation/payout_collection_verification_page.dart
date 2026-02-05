import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class PayoutCollectionVerificationPage extends StatelessWidget {
  const PayoutCollectionVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Stage 2: placeholder numbers. Real totals + gating comes in TS-403 stage3.
    const dueTotalBdt = 0;
    const paidTotalBdt = 0;
    const shortTotalBdt = 0;
    final isShort = shortTotalBdt > 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Verify collection')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Payout is allowed only after full collection is verified.',
                  ),
                  SizedBox(height: AppSpacing.s8),
                  Text(
                    'No partial payout: if the pot is short, payout must be postponed.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Row(
                    label: 'Due total',
                    value: '$dueTotalBdt BDT',
                    valueKey: const Key('payout_collection_due_total'),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  _Row(
                    label: 'Paid total',
                    value: '$paidTotalBdt BDT',
                    valueKey: const Key('payout_collection_paid_total'),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  _Row(
                    label: 'Short total',
                    value: '$shortTotalBdt BDT',
                    valueKey: const Key('payout_collection_short_total'),
                  ),
                ],
              ),
            ),
            const Spacer(),
            AppButton.primary(
              key: const Key('payout_collection_verify'),
              label: 'Mark collection verified',
              onPressed: isShort ? null : () => context.push(payoutApprovalsLocation),
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


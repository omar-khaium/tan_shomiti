import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import 'providers/payout_domain_providers.dart';
import 'providers/payout_providers.dart';

class PayoutProofPage extends ConsumerStatefulWidget {
  const PayoutProofPage({super.key});

  @override
  ConsumerState<PayoutProofPage> createState() => _PayoutProofPageState();
}

class _PayoutProofPageState extends ConsumerState<PayoutProofPage> {
  final _proofController = TextEditingController();

  @override
  void dispose() {
    _proofController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canMarkPaid = _proofController.text.trim().isNotEmpty;
    final ui = ref.watch(payoutUiStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Payout proof')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: ui.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Failed to load payout: $error'),
          ),
          data: (state) {
            final isAlreadyPaid = state.paid.isPaid;
            final isReady = state.prerequisites.canProceed;
            final canSubmit = canMarkPaid && isReady && !isAlreadyPaid;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Row(
                        label: 'Winner',
                        value: state.winnerLabel,
                        valueKey: const Key('payout_winner_label'),
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      _Row(
                        label: 'Amount',
                        value: '${state.amountBdt} BDT',
                        valueKey: const Key('payout_amount_label'),
                      ),
                      if (isAlreadyPaid) ...[
                        const SizedBox(height: AppSpacing.s12),
                        Text(
                          'Already marked paid at ${state.paid.paidAt}.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
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
                  label: isAlreadyPaid ? 'Paid' : 'Mark paid',
                  onPressed: canSubmit
                      ? () => _markPaid(
                            shomitiId: state.shomitiId,
                            ruleSetVersionId: state.ruleSetVersionId,
                            month: state.month,
                            proofReference: _proofController.text,
                          )
                      : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _markPaid({
    required String shomitiId,
    required String ruleSetVersionId,
    required BillingMonth month,
    required String proofReference,
  }) async {
    try {
      await ref.read(markPayoutPaidProvider)(
            shomitiId: shomitiId,
            ruleSetVersionId: ruleSetVersionId,
            month: month,
            proofReference: proofReference,
          );
      ref.invalidate(payoutControllerProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payout marked paid.')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to mark paid: $e')),
      );
    }
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

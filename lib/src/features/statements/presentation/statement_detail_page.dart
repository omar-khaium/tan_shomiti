import 'package:flutter/material.dart';

import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class StatementDetailPage extends StatelessWidget {
  const StatementDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Stage 2: UI-only placeholders. Real statement derivation comes in TS-501 stage3.
    const totalDue = '—';
    const totalCollected = '—';
    const shortfall = '—';
    const winner = '—';
    const drawProof = '—';
    const payoutProof = '—';

    return Scaffold(
      appBar: AppBar(title: const Text('Statement')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: ListView(
          children: const [
            AppCard(
              child: _Row(
                label: 'Total due',
                value: totalDue,
                valueKey: Key('statement_total_due'),
              ),
            ),
            SizedBox(height: AppSpacing.s12),
            AppCard(
              child: _Row(
                label: 'Total collected',
                value: totalCollected,
                valueKey: Key('statement_total_collected'),
              ),
            ),
            SizedBox(height: AppSpacing.s12),
            AppCard(
              child: _Row(
                label: 'Shortfall',
                value: shortfall,
                valueKey: Key('statement_shortfall'),
              ),
            ),
            SizedBox(height: AppSpacing.s16),
            AppCard(
              child: _Row(
                label: 'Winner',
                value: winner,
                valueKey: Key('statement_winner_label'),
              ),
            ),
            SizedBox(height: AppSpacing.s12),
            AppCard(
              child: _Row(
                label: 'Draw proof',
                value: drawProof,
                valueKey: Key('statement_draw_proof'),
              ),
            ),
            SizedBox(height: AppSpacing.s12),
            AppCard(
              child: _Row(
                label: 'Payout proof',
                value: payoutProof,
                valueKey: Key('statement_payout_proof'),
              ),
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


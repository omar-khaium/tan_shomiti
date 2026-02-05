import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/formatters/billing_month_label.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../contributions/domain/value_objects/billing_month.dart';

class DrawRecordDetailsPage extends StatelessWidget {
  const DrawRecordDetailsPage({
    required this.month,
    required this.methodLabel,
    required this.proofReference,
    required this.winnerLabel,
    required this.statusLabel,
    super.key,
  });

  final BillingMonth month;
  final String methodLabel;
  final String proofReference;
  final String winnerLabel;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    final monthLabel = formatBillingMonthLabel(month);

    return Scaffold(
      appBar: AppBar(title: const Text('Draw record')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              monthLabel,
              key: const Key('draw_record_month_label'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.s16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Row(
                    label: 'Method',
                    value: methodLabel,
                    valueKey: const Key('draw_record_method'),
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  _Row(
                    label: 'Proof reference',
                    value: proofReference,
                    valueKey: const Key('draw_record_proof_ref'),
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  _Row(
                    label: 'Winner',
                    value: winnerLabel,
                    valueKey: const Key('draw_record_winner'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            AppCard(
              child: _Row(
                label: 'Status',
                value: statusLabel,
                valueKey: const Key('draw_record_status'),
              ),
            ),
            const Spacer(),
            AppButton.primary(
              key: const Key('draw_collect_witnesses'),
              label: 'Collect witness sign-offs',
              onPressed: () => context.push(drawWitnessesLocation),
            ),
            const SizedBox(height: AppSpacing.s8),
            AppButton.secondary(
              key: const Key('draw_redo'),
              label: 'Redo draw',
              onPressed: () => context.push(drawRedoLocation),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(width: AppSpacing.s12),
        Expanded(
          child: Text(
            value,
            key: valueKey,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}


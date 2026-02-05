import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../domain/value_objects/billing_month.dart';
import 'models/contributions_ui_state.dart';
import 'models/demo_payment_receipt.dart';
import 'providers/contributions_demo_payments_providers.dart';
import 'providers/contributions_providers.dart';

class ContributionsPage extends ConsumerWidget {
  const ContributionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contributionsUiStateProvider);

    return state.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.s16),
        child: AppLoadingState(),
      ),
      error: (error, stackTrace) => const Padding(
        padding: EdgeInsets.all(AppSpacing.s16),
        child: AppErrorState(message: 'Failed to load dues.'),
      ),
      data: (ui) {
        if (ui == null) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.s16),
            child: AppEmptyState(
              title: 'No Shomiti yet',
              message: 'Complete setup to generate monthly dues.',
              icon: Icons.payments_outlined,
            ),
          );
        }

        if (ui.rows.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.s16),
            child: AppEmptyState(
              title: 'No members found',
              message: 'Add members and shares first.',
              icon: Icons.group_outlined,
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.s16),
          children: [
            _MonthHeader(
              month: ui.month,
              onPrev: () async {
                await ref
                    .read(contributionsControllerProvider.notifier)
                    .previousMonth();
              },
              onNext: () async {
                await ref
                    .read(contributionsControllerProvider.notifier)
                    .nextMonth();
              },
            ),
            const SizedBox(height: AppSpacing.s12),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total due',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  Text(
                    '${ui.totalDueBdt} BDT',
                    key: const Key('dues_total_due'),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            for (final row in ui.rows) _DueRow(row: row, month: ui.month),
          ],
        );
      },
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({
    required this.month,
    required this.onPrev,
    required this.onNext,
  });

  final BillingMonth month;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final label = '${_monthName(month.month)} ${month.year}';

    return Row(
      children: [
        IconButton(
          key: const Key('dues_prev_month'),
          onPressed: onPrev,
          icon: const Icon(Icons.chevron_left),
          tooltip: 'Previous month',
        ),
        Expanded(
          child: Text(
            label,
            key: const Key('dues_month_label'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton(
          key: const Key('dues_next_month'),
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right),
          tooltip: 'Next month',
        ),
      ],
    );
  }

  static String _monthName(int m) {
    const names = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    if (m < 1 || m > 12) return 'Month';
    return names[m - 1];
  }
}

class _DueRow extends ConsumerWidget {
  const _DueRow({required this.row, required this.month});

  final MonthlyDueRow row;
  final BillingMonth month;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receipt = ref.watch(
      demoPaymentReceiptProvider(
        DemoPaymentKey(memberId: row.memberId, monthKey: month.key),
      ),
    );

    return AppCard(
      key: Key('dues_row_${row.position}'),
      padding: const EdgeInsets.all(AppSpacing.s12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.displayName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.s4),
                Text(
                  'Shares: ${row.shares}',
                  key: Key('dues_shares_${row.position}'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.s4),
                Text(
                  receipt == null ? 'Unpaid' : 'Paid',
                  key: Key('dues_status_${row.position}'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${row.dueAmountBdt} BDT',
                key: Key('dues_amount_${row.position}'),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppSpacing.s8),
              if (receipt == null)
                TextButton(
                  key: Key('dues_record_payment_${row.position}'),
                  onPressed: () async {
                    final input = await showDialog<_PaymentInput>(
                      context: context,
                      builder: (context) => _RecordPaymentDialog(
                        dueAmountBdt: row.dueAmountBdt,
                        memberName: row.displayName,
                      ),
                    );

                    if (input == null) return;

                    await ref
                        .read(demoPaymentsControllerProvider.notifier)
                        .recordPayment(
                          memberId: row.memberId,
                          monthKey: month.key,
                          amountBdt: input.amountBdt,
                          method: input.method,
                          reference: input.reference,
                        );
                  },
                  child: const Text('Record payment'),
                )
              else
                TextButton(
                  key: Key('dues_view_receipt_${row.position}'),
                  onPressed: () async {
                    await showDialog<void>(
                      context: context,
                      builder: (context) => _ReceiptDialog(receipt: receipt),
                    );
                  },
                  child: const Text('View receipt'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecordPaymentDialog extends StatefulWidget {
  const _RecordPaymentDialog({
    required this.dueAmountBdt,
    required this.memberName,
  });

  final int dueAmountBdt;
  final String memberName;

  @override
  State<_RecordPaymentDialog> createState() => _RecordPaymentDialogState();
}

class _PaymentInput {
  const _PaymentInput({
    required this.amountBdt,
    required this.method,
    required this.reference,
  });

  final int amountBdt;
  final DemoPaymentMethod method;
  final String reference;
}

class _RecordPaymentDialogState extends State<_RecordPaymentDialog> {
  late final TextEditingController _amountController;
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _proofController = TextEditingController();

  DemoPaymentMethod _method = DemoPaymentMethod.cash;
  String? _error;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.dueAmountBdt.toString(),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    _proofController.dispose();
    super.dispose();
  }

  void _validate() {
    final amount = int.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      setState(() => _error = 'Enter a valid amount.');
      return;
    }
    final reference = _referenceController.text.trim();
    if (reference.isEmpty) {
      setState(() => _error = 'Reference is required.');
      return;
    }

    setState(() => _error = null);
    Navigator.of(context).pop(
      _PaymentInput(amountBdt: amount, method: _method, reference: reference),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Record payment — ${widget.memberName}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              key: const Key('payment_amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount (BDT)'),
            ),
            const SizedBox(height: AppSpacing.s12),
            DropdownButtonFormField<DemoPaymentMethod>(
              key: const Key('payment_method'),
              initialValue: _method,
              decoration: const InputDecoration(labelText: 'Method'),
              items: const [
                DropdownMenuItem(
                  value: DemoPaymentMethod.cash,
                  child: Text('Cash'),
                ),
                DropdownMenuItem(
                  value: DemoPaymentMethod.bankTransfer,
                  child: Text('Bank transfer'),
                ),
                DropdownMenuItem(
                  value: DemoPaymentMethod.mobileWallet,
                  child: Text('Mobile wallet'),
                ),
                DropdownMenuItem(
                  value: DemoPaymentMethod.other,
                  child: Text('Other'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() => _method = value);
              },
            ),
            const SizedBox(height: AppSpacing.s12),
            TextField(
              key: const Key('payment_reference'),
              controller: _referenceController,
              decoration: const InputDecoration(
                labelText: 'Reference (required)',
              ),
            ),
            const SizedBox(height: AppSpacing.s12),
            TextField(
              key: const Key('payment_proof_note'),
              controller: _proofController,
              decoration: const InputDecoration(
                labelText: 'Proof note (optional)',
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.s12),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _error!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          key: const Key('payment_cancel'),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const Key('payment_confirm'),
          onPressed: _validate,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _ReceiptDialog extends StatelessWidget {
  const _ReceiptDialog({required this.receipt});

  final DemoPaymentReceipt receipt;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: const Key('receipt_dialog'),
      title: const Text('Receipt'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Receipt #: ${receipt.receiptNumber}',
            key: const Key('receipt_number'),
          ),
          const SizedBox(height: AppSpacing.s8),
          Text('Amount: ${receipt.amountBdt} BDT'),
          Text('Method: ${receipt.methodLabel}'),
          Text('Reference: ${receipt.reference}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

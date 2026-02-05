import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class PayoutApprovalsPage extends StatefulWidget {
  const PayoutApprovalsPage({super.key});

  @override
  State<PayoutApprovalsPage> createState() => _PayoutApprovalsPageState();
}

class _PayoutApprovalsPageState extends State<PayoutApprovalsPage> {
  final _treasurerNoteController = TextEditingController();
  final _auditorNoteController = TextEditingController();

  bool _treasurerApproved = false;
  bool _auditorApproved = false;

  @override
  void dispose() {
    _treasurerNoteController.dispose();
    _auditorNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canContinue = _treasurerApproved && _auditorApproved;

    return Scaffold(
      appBar: AppBar(title: const Text('Approvals')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: ListView(
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Treasurer approval',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  TextField(
                    key: const Key('payout_treasurer_note'),
                    controller: _treasurerNoteController,
                    decoration: const InputDecoration(
                      labelText: 'Note (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  AppButton.primary(
                    key: const Key('payout_treasurer_approve'),
                    label: _treasurerApproved ? 'Approved' : 'Approve',
                    onPressed: () => setState(
                      () => _treasurerApproved = !_treasurerApproved,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Auditor/witness approval',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  TextField(
                    key: const Key('payout_auditor_note'),
                    controller: _auditorNoteController,
                    decoration: const InputDecoration(
                      labelText: 'Note (optional)',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: AppSpacing.s12),
                  AppButton.primary(
                    key: const Key('payout_auditor_approve'),
                    label: _auditorApproved ? 'Approved' : 'Approve',
                    onPressed: () => setState(
                      () => _auditorApproved = !_auditorApproved,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            AppCard(
              child: Row(
                children: [
                  const Expanded(child: Text('Approval status')),
                  Text(
                    canContinue ? 'Approved for payout' : 'Pending',
                    key: const Key('payout_approval_status'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            AppButton.primary(
              label: 'Continue',
              onPressed:
                  canContinue ? () => context.push(payoutProofLocation) : null,
            ),
            const SizedBox(height: AppSpacing.s16),
          ],
        ),
      ),
    );
  }
}

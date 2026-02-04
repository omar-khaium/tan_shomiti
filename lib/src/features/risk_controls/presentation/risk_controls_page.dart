import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_status_chip.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'models/risk_controls_ui_state.dart';
import 'providers/risk_controls_providers.dart';
import 'record_deposit_page.dart';
import 'record_guarantor_page.dart';

class RiskControlsPage extends ConsumerWidget {
  const RiskControlsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(riskControlsUiStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Risk controls')),
      body: state.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load risk controls.'),
        ),
        data: (ui) {
          if (ui == null) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No members yet',
                message:
                    'Add members first, then record guarantors or deposits.',
                icon: Icons.group_outlined,
              ),
            );
          }

          if (ui.rows.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No members found',
                message: 'Add members to start recording risk controls.',
                icon: Icons.group_outlined,
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.s16),
            children: [
              _SummaryCard(missingCount: ui.missingCount),
              const SizedBox(height: AppSpacing.s16),
              Text(
                'Per-member status',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.s8),
              for (final row in ui.rows)
                _RiskRow(
                  row: row,
                  onRecordGuarantor: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => RecordGuarantorPage(
                        memberId: row.memberId,
                        displayName: row.displayName,
                      ),
                    ),
                  ),
                  onRecordDeposit: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => RecordDepositPage(
                        memberId: row.memberId,
                        displayName: row.displayName,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.missingCount});

  final int missingCount;

  @override
  Widget build(BuildContext context) {
    final kind = missingCount == 0
        ? AppStatusKind.success
        : missingCount <= 2
        ? AppStatusKind.warning
        : AppStatusKind.error;
    final label = missingCount == 0 ? 'Complete' : '$missingCount missing';

    return AppCard(
      child: Row(
        children: [
          Text('Overview', style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          AppStatusChip(label: label, kind: kind),
        ],
      ),
    );
  }
}

class _RiskRow extends StatelessWidget {
  const _RiskRow({
    required this.row,
    required this.onRecordGuarantor,
    required this.onRecordDeposit,
  });

  final RiskControlRow row;
  final VoidCallback onRecordGuarantor;
  final VoidCallback onRecordDeposit;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      key: Key('risk_row_${row.position}'),
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
                const SizedBox(height: 4),
                Text(_statusLabel(row.status)),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.s8),
          PopupMenuButton<_Action>(
            key: Key('risk_actions_${row.position}'),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _Action.recordGuarantor,
                child: Text('Record guarantor'),
              ),
              PopupMenuItem(
                value: _Action.recordDeposit,
                child: Text('Record deposit'),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case _Action.recordGuarantor:
                  onRecordGuarantor();
                case _Action.recordDeposit:
                  onRecordDeposit();
              }
            },
            child: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  static String _statusLabel(RiskControlStatus status) {
    return switch (status) {
      RiskControlStatus.missing => 'Missing (needs guarantor or deposit)',
      RiskControlStatus.guarantorRecorded => 'Guarantor recorded',
      RiskControlStatus.depositRecorded => 'Deposit recorded (held)',
      RiskControlStatus.depositReturned => 'Deposit returned',
    };
  }
}

enum _Action { recordGuarantor, recordDeposit }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../audit/domain/entities/audit_event.dart';
import '../../audit/presentation/providers/audit_providers.dart';
import '../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import 'providers/statements_domain_providers.dart';
import 'providers/statements_providers.dart';
import '../domain/entities/monthly_statement.dart';

class StatementDetailPage extends ConsumerStatefulWidget {
  const StatementDetailPage({super.key});

  @override
  ConsumerState<StatementDetailPage> createState() => _StatementDetailPageState();
}

class _StatementDetailPageState extends ConsumerState<StatementDetailPage> {
  bool _viewLogged = false;

  @override
  Widget build(BuildContext context) {
    final ui = ref.watch(statementsUiStateProvider).valueOrNull;
    final shomiti = ref.watch(activeShomitiProvider).valueOrNull;

    final month = ui?.month;
    final shomitiId = shomiti?.id;

    late final AsyncValue<MonthlyStatement?> statementAsync;
    if (month != null && shomitiId != null) {
      final args = StatementMonthArgs(shomitiId: shomitiId, month: month);
      final provider = statementByMonthProvider(args);
      statementAsync = ref.watch(provider);

      ref.listen(provider, (prev, next) {
        final statement = next.valueOrNull;
        if (_viewLogged || statement == null) return;
        _viewLogged = true;
        final now = DateTime.now();
        ref.read(appendAuditEventProvider)(
              NewAuditEvent(
                action: 'statement_viewed',
                occurredAt: now,
                message: 'Viewed monthly statement.',
                metadataJson: jsonEncode({
                  'shomitiId': shomitiId,
                  'monthKey': statement.month.key,
                }),
              ),
            );
      });
    } else {
      statementAsync = const AsyncValue.data(null);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Statement')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: statementAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Failed to load statement: $e')),
          data: (statement) {
            final totalDue = statement?.totalDueBdt.toString() ?? '—';
            final totalCollected = statement?.totalCollectedBdt.toString() ?? '—';
            final shortfall = statement?.shortfallBdt.toString() ?? '—';
            final winner = statement?.winnerLabel ?? '—';
            final drawProof = statement?.drawProofReference ?? '—';
            final payoutProof = statement?.payoutProofReference ?? '—';

            return ListView(
              children: [
                AppCard(
                  child: _Row(
                    label: 'Total due',
                    value: '$totalDue BDT',
                    valueKey: const Key('statement_total_due'),
                  ),
                ),
                const SizedBox(height: AppSpacing.s12),
                AppCard(
                  child: _Row(
                    label: 'Total collected',
                    value: '$totalCollected BDT',
                    valueKey: const Key('statement_total_collected'),
                  ),
                ),
                const SizedBox(height: AppSpacing.s12),
                AppCard(
                  child: _Row(
                    label: 'Shortfall',
                    value: '$shortfall BDT',
                    valueKey: const Key('statement_shortfall'),
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
                AppCard(
                  child: _Row(
                    label: 'Winner',
                    value: winner,
                    valueKey: const Key('statement_winner_label'),
                  ),
                ),
                const SizedBox(height: AppSpacing.s12),
                AppCard(
                  child: _Row(
                    label: 'Draw proof',
                    value: drawProof,
                    valueKey: const Key('statement_draw_proof'),
                  ),
                ),
                const SizedBox(height: AppSpacing.s12),
                AppCard(
                  child: _Row(
                    label: 'Payout proof',
                    value: payoutProof,
                    valueKey: const Key('statement_payout_proof'),
                  ),
                ),
              ],
            );
          },
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../../members/domain/entities/governance_role.dart';
import 'providers/payout_domain_providers.dart';
import 'providers/payout_providers.dart';

class PayoutCollectionVerificationPage extends ConsumerStatefulWidget {
  const PayoutCollectionVerificationPage({super.key});

  @override
  ConsumerState<PayoutCollectionVerificationPage> createState() =>
      _PayoutCollectionVerificationPageState();
}

class _PayoutCollectionVerificationPageState
    extends ConsumerState<PayoutCollectionVerificationPage> {
  String? _selectedVerifierId;

  @override
  Widget build(BuildContext context) {
    final ui = ref.watch(payoutUiStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Verify collection')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: ui.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Failed to load payout: $error'),
          ),
          data: (state) {
            final totals = state.totals;
            final isShort = totals.shortfallBdt > 0;
            final canVerifyCollection =
                !state.verification.isVerified &&
                !isShort;

            String? assignedTreasurerId;
            if (!state.verification.isVerified) {
              final assignmentsAsync =
                  ref.watch(payoutRoleAssignmentsProvider(state.shomitiId));
              final assignments = assignmentsAsync.valueOrNull;
              if (assignments != null) {
                for (final a in assignments) {
                  if (a.role == GovernanceRole.treasurer) {
                    assignedTreasurerId = a.memberId;
                    break;
                  }
                }
              }
            }

            final verifierId = assignedTreasurerId ?? _selectedVerifierId;
            final requirePicker =
                !state.verification.isVerified && assignedTreasurerId == null;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payout is allowed only after full collection is verified.',
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      Text(
                        state.allowShortfallCoverage
                            ? 'Collection can be completed by coverage policy before payout.'
                            : 'No partial payout: if the pot is short, payout must be postponed.',
                      ),
                      if (state.verification.isVerified) ...[
                        const SizedBox(height: AppSpacing.s12),
                        Text(
                          'Verified by ${state.verification.verifiedByName ?? state.verification.verifiedByMemberId} at ${state.verification.verifiedAt}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
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
                        value: '${totals.dueTotalBdt} BDT',
                        valueKey: const Key('payout_collection_due_total'),
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      _Row(
                        label: 'Paid total',
                        value: '${totals.paidTotalBdt} BDT',
                        valueKey: const Key('payout_collection_paid_total'),
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      _Row(
                        label: 'Short total',
                        value: '${totals.shortfallBdt} BDT',
                        valueKey: const Key('payout_collection_short_total'),
                      ),
                      if (requirePicker) ...[
                        const SizedBox(height: AppSpacing.s12),
                        ref
                            .watch(payoutMembersProvider(state.shomitiId))
                            .when(
                          loading: () => const LinearProgressIndicator(),
                          error: (e, s) =>
                              const Text('Failed to load members.'),
                          data: (members) => DropdownButtonFormField<String>(
                            key: const Key('payout_collection_verifier_picker'),
                            decoration: const InputDecoration(
                              labelText: 'Verifier (Treasurer)',
                              border: OutlineInputBorder(),
                            ),
                            initialValue: _selectedVerifierId,
                            items: [
                              for (final m in members)
                                DropdownMenuItem(
                                  value: m.id,
                                  child: Text(m.fullName),
                                ),
                            ],
                            onChanged: (value) =>
                                setState(() => _selectedVerifierId = value),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Spacer(),
                AppButton.primary(
                  key: const Key('payout_collection_verify'),
                  label: state.verification.isVerified
                      ? 'Continue'
                      : 'Mark collection verified',
                  onPressed: state.verification.isVerified
                      ? () => context.push(payoutApprovalsLocation)
                      : (canVerifyCollection && verifierId != null)
                          ? () => _verify(
                                shomitiId: state.shomitiId,
                                ruleSetVersionId: state.ruleSetVersionId,
                                month: state.month,
                                verifiedByMemberId: verifierId,
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

  Future<void> _verify({
    required String shomitiId,
    required String ruleSetVersionId,
    required BillingMonth month,
    required String verifiedByMemberId,
  }) async {
    try {
      await ref.read(verifyMonthlyCollectionProvider)(
            shomitiId: shomitiId,
            ruleSetVersionId: ruleSetVersionId,
            month: month,
            verifiedByMemberId: verifiedByMemberId,
          );
      ref.invalidate(payoutControllerProvider);
      if (!mounted) return;
      context.push(payoutApprovalsLocation);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to verify collection: $e')),
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

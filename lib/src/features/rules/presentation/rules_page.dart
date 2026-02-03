import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import '../domain/entities/rule_set_snapshot.dart';
import '../domain/entities/rule_set_version.dart';
import 'providers/rules_viewer_providers.dart';

class RulesPage extends ConsumerWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final version = ref.watch(rulesViewerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Rules')),
      body: version.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load rules.'),
        ),
        data: (data) {
          if (data == null) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No rules snapshot found',
                message:
                    'Create a Shomiti first. The app will show the active rules snapshot here.',
                icon: Icons.rule_folder_outlined,
              ),
            );
          }

          return _RulesBody(version: data);
        },
      ),
    );
  }
}

class _RulesBody extends StatelessWidget {
  const _RulesBody({required this.version});

  final RuleSetVersion version;

  @override
  Widget build(BuildContext context) {
    final createdAt = MaterialLocalizations.of(context).formatShortDate(
      version.createdAt,
    );
    final snapshot = version.snapshot;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s16),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Active rules snapshot',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.s8),
              _RuleField(
                label: 'Version id',
                value: version.id,
                valueKey: const Key('rules_version_id'),
              ),
              _RuleField(label: 'Created', value: createdAt),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s16),
        _Section(
          title: 'Setup',
          children: [
            _RuleField(label: 'Shomiti name', value: snapshot.shomitiName),
            _RuleField(
              label: 'Start date',
              value: MaterialLocalizations.of(context).formatShortDate(
                snapshot.startDate,
              ),
            ),
            _RuleField(label: 'Group type', value: _groupType(snapshot.groupType)),
            _RuleField(label: 'Member count (N)', value: '${snapshot.memberCount}'),
            _RuleField(label: 'Share value (S)', value: 'BDT ${snapshot.shareValueBdt}'),
            _RuleField(
              label: 'Max shares per person',
              value: '${snapshot.maxSharesPerPerson}',
            ),
            _RuleField(
              label: 'Share transfers',
              value: snapshot.allowShareTransfers ? 'Allowed' : 'Not allowed',
            ),
            _RuleField(
              label: 'Cycle length (months)',
              value: '${snapshot.cycleLengthMonths}',
            ),
            _RuleField(label: 'Meeting schedule', value: snapshot.meetingSchedule),
            _RuleField(label: 'Payment deadline', value: snapshot.paymentDeadline),
            _RuleField(label: 'Payout method', value: _payoutMethod(snapshot.payoutMethod)),
            _RuleField(
              label: 'Group channel',
              value: snapshot.groupChannel?.trim().isNotEmpty == true
                  ? snapshot.groupChannel!.trim()
                  : 'Not set',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s16),
        _Section(
          title: 'Policies',
          children: [
            _RuleField(
              label: 'Missed payment policy',
              value: _missedPaymentPolicy(snapshot.missedPaymentPolicy),
            ),
            _RuleField(
              label: 'Grace period (days)',
              value: snapshot.gracePeriodDays?.toString() ?? 'Not set',
            ),
            _RuleField(
              label: 'Late fee (BDT/day)',
              value: snapshot.lateFeeBdtPerDay?.toString() ?? 'Not set',
            ),
            _RuleField(
              label: 'Fees enabled',
              value: snapshot.feesEnabled ? 'Yes' : 'No',
            ),
            _RuleField(
              label: 'Fee amount (BDT)',
              value: snapshot.feeAmountBdt?.toString() ?? 'Not set',
            ),
            _RuleField(
              label: 'Fee payer model',
              value: _feePayerModel(snapshot.feePayerModel),
            ),
            _RuleField(
              label: 'Rule change after start requires unanimous',
              value: snapshot.ruleChangeAfterStartRequiresUnanimous ? 'Yes' : 'No',
            ),
          ],
        ),
      ],
    );
  }

  String _groupType(GroupTypePolicy policy) => switch (policy) {
        GroupTypePolicy.closed => 'Closed',
        GroupTypePolicy.open => 'Open',
      };

  String _payoutMethod(PayoutMethod method) => switch (method) {
        PayoutMethod.cash => 'Cash',
        PayoutMethod.bank => 'Bank',
        PayoutMethod.mobileWallet => 'Mobile wallet',
        PayoutMethod.mixed => 'Mixed',
      };

  String _missedPaymentPolicy(MissedPaymentPolicy policy) => switch (policy) {
        MissedPaymentPolicy.postponePayout => 'Postpone payout',
        MissedPaymentPolicy.coverFromReserve => 'Cover from reserve',
        MissedPaymentPolicy.coverByGuarantor => 'Cover by guarantor',
      };

  String _feePayerModel(FeePayerModel model) => switch (model) {
        FeePayerModel.everyoneEqually => 'Everyone equally',
        FeePayerModel.winnerPays => 'Winner pays',
      };
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.s8),
          ...children,
        ],
      ),
    );
  }
}

class _RuleField extends StatelessWidget {
  const _RuleField({
    required this.label,
    required this.value,
    this.valueKey,
  });

  final String label;
  final String value;
  final Key? valueKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: AppSpacing.s12),
          Expanded(
            child: Text(
              value,
              key: valueKey,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_text_field.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class SetupWizardPage extends ConsumerStatefulWidget {
  const SetupWizardPage({super.key});

  @override
  ConsumerState<SetupWizardPage> createState() => _SetupWizardPageState();
}

class _SetupWizardPageState extends ConsumerState<SetupWizardPage> {
  final _nameController = TextEditingController();
  final _memberCountController = TextEditingController();
  final _shareValueController = TextEditingController();
  final _maxSharesController = TextEditingController(text: '1');
  final _cycleLengthController = TextEditingController();
  final _meetingScheduleController = TextEditingController();
  final _paymentDeadlineController = TextEditingController();
  final _groupChannelController = TextEditingController();
  final _gracePeriodDaysController = TextEditingController();
  final _lateFeeController = TextEditingController();
  final _feeAmountController = TextEditingController();

  int _stepIndex = 0;

  DateTime _startDate = DateTime.now();
  GroupType _groupType = GroupType.closed;
  bool _allowShareTransfers = false;
  MissedPaymentPolicy _missedPaymentPolicy = MissedPaymentPolicy.postponePayout;
  PayoutMethod _payoutMethod = PayoutMethod.mobileWallet;
  bool _feesEnabled = false;
  FeePayerModel _feePayerModel = FeePayerModel.everyoneEqually;

  String? _nameError;
  String? _memberCountError;
  String? _shareValueError;
  String? _cycleLengthError;
  String? _meetingScheduleError;
  String? _paymentDeadlineError;

  @override
  void dispose() {
    _nameController.dispose();
    _memberCountController.dispose();
    _shareValueController.dispose();
    _maxSharesController.dispose();
    _cycleLengthController.dispose();
    _meetingScheduleController.dispose();
    _paymentDeadlineController.dispose();
    _groupChannelController.dispose();
    _gracePeriodDaysController.dispose();
    _lateFeeController.dispose();
    _feeAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalSteps = _SetupStep.values.length;
    final step = _SetupStep.values[_stepIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup'),
        actions: [
          AppButton.tertiary(
            key: const Key('setup_continue_demo'),
            label: 'Continue in demo mode',
            onPressed: () {
              ref.read(shomitiConfiguredProvider.notifier).state = true;
              context.go(dashboardLocation);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Step ${_stepIndex + 1} of $totalSteps',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: AppSpacing.s8),
            Text(step.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.s16),
            Expanded(
              child: ListView(
                children: [
                  AppCard(
                    child: _StepBody(
                      step: step,
                      startDate: _startDate,
                      onPickStartDate: _pickStartDate,
                      groupType: _groupType,
                      onGroupTypeChanged: (value) =>
                          setState(() => _groupType = value),
                      payoutMethod: _payoutMethod,
                      onPayoutMethodChanged: (value) =>
                          setState(() => _payoutMethod = value),
                      allowShareTransfers: _allowShareTransfers,
                      onAllowShareTransfersChanged: (value) =>
                          setState(() => _allowShareTransfers = value),
                      missedPaymentPolicy: _missedPaymentPolicy,
                      onMissedPaymentPolicyChanged: (value) =>
                          setState(() => _missedPaymentPolicy = value),
                      feesEnabled: _feesEnabled,
                      onFeesEnabledChanged: (value) =>
                          setState(() => _feesEnabled = value),
                      feePayerModel: _feePayerModel,
                      onFeePayerModelChanged: (value) =>
                          setState(() => _feePayerModel = value),
                      nameController: _nameController,
                      memberCountController: _memberCountController,
                      shareValueController: _shareValueController,
                      maxSharesController: _maxSharesController,
                      cycleLengthController: _cycleLengthController,
                      meetingScheduleController: _meetingScheduleController,
                      paymentDeadlineController: _paymentDeadlineController,
                      groupChannelController: _groupChannelController,
                      gracePeriodDaysController: _gracePeriodDaysController,
                      lateFeeController: _lateFeeController,
                      feeAmountController: _feeAmountController,
                      nameError: _nameError,
                      memberCountError: _memberCountError,
                      shareValueError: _shareValueError,
                      cycleLengthError: _cycleLengthError,
                      meetingScheduleError: _meetingScheduleError,
                      paymentDeadlineError: _paymentDeadlineError,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            Row(
              children: [
                Expanded(
                  child: AppButton.secondary(
                    key: const Key('setup_back'),
                    label: 'Back',
                    onPressed: _stepIndex == 0 ? null : _back,
                  ),
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: AppButton.primary(
                    key: const Key('setup_next'),
                    label: _stepIndex == totalSteps - 1 ? 'Finish' : 'Next',
                    onPressed: _stepIndex == totalSteps - 1 ? _finish : _next,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickStartDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      initialDate: _startDate,
    );

    if (picked == null) return;
    setState(() => _startDate = picked);
  }

  void _back() {
    if (_stepIndex == 0) return;
    setState(() => _stepIndex -= 1);
  }

  void _next() {
    if (!_validateCurrentStep()) return;
    if (_stepIndex >= _SetupStep.values.length - 1) return;
    setState(() => _stepIndex += 1);
  }

  void _finish() {
    if (!_validateCurrentStep()) return;

    ref.read(shomitiConfiguredProvider.notifier).state = true;
    context.go(dashboardLocation);
  }

  bool _validateCurrentStep() {
    final step = _SetupStep.values[_stepIndex];

    setState(() {
      _nameError = null;
      _memberCountError = null;
      _shareValueError = null;
      _cycleLengthError = null;
      _meetingScheduleError = null;
      _paymentDeadlineError = null;

      switch (step) {
        case _SetupStep.basics:
          if (_nameController.text.trim().isEmpty) {
            _nameError = 'Required';
          }
          break;
        case _SetupStep.membersAndShares:
          _memberCountError = _validatePositiveInt(_memberCountController.text);
          _shareValueError = _validatePositiveInt(_shareValueController.text);
          break;
        case _SetupStep.schedule:
          _cycleLengthError = _validatePositiveInt(_cycleLengthController.text);
          if (_meetingScheduleController.text.trim().isEmpty) {
            _meetingScheduleError = 'Required';
          }
          if (_paymentDeadlineController.text.trim().isEmpty) {
            _paymentDeadlineError = 'Required';
          }
          break;
        case _SetupStep.policies:
        case _SetupStep.fees:
        case _SetupStep.review:
          break;
      }
    });

    return [
      _nameError,
      _memberCountError,
      _shareValueError,
      _cycleLengthError,
      _meetingScheduleError,
      _paymentDeadlineError,
    ].every((e) => e == null);
  }

  String? _validatePositiveInt(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return 'Required';

    final parsed = int.tryParse(trimmed);
    if (parsed == null || parsed <= 0) return 'Must be > 0';

    return null;
  }
}

enum _SetupStep {
  basics('Shomiti basics'),
  membersAndShares('Members and shares'),
  schedule('Schedule'),
  policies('Policies'),
  fees('Fees (optional)'),
  review('Review');

  const _SetupStep(this.title);

  final String title;
}

enum GroupType {
  closed('Closed (recommended)'),
  open('Open');

  const GroupType(this.label);
  final String label;
}

enum MissedPaymentPolicy {
  postponePayout('Postpone payout (recommended)'),
  coverFromReserve('Cover from reserve'),
  coverByGuarantor('Cover by guarantor');

  const MissedPaymentPolicy(this.label);
  final String label;
}

enum PayoutMethod {
  cash('Cash'),
  bank('Bank transfer'),
  mobileWallet('Mobile wallet'),
  mixed('Mixed');

  const PayoutMethod(this.label);
  final String label;
}

enum FeePayerModel {
  everyoneEqually('Everyone equally'),
  winnerPays('Winner pays');

  const FeePayerModel(this.label);
  final String label;
}

class _StepBody extends StatelessWidget {
  const _StepBody({
    required this.step,
    required this.startDate,
    required this.onPickStartDate,
    required this.groupType,
    required this.onGroupTypeChanged,
    required this.payoutMethod,
    required this.onPayoutMethodChanged,
    required this.allowShareTransfers,
    required this.onAllowShareTransfersChanged,
    required this.missedPaymentPolicy,
    required this.onMissedPaymentPolicyChanged,
    required this.feesEnabled,
    required this.onFeesEnabledChanged,
    required this.feePayerModel,
    required this.onFeePayerModelChanged,
    required this.nameController,
    required this.memberCountController,
    required this.shareValueController,
    required this.maxSharesController,
    required this.cycleLengthController,
    required this.meetingScheduleController,
    required this.paymentDeadlineController,
    required this.groupChannelController,
    required this.gracePeriodDaysController,
    required this.lateFeeController,
    required this.feeAmountController,
    required this.nameError,
    required this.memberCountError,
    required this.shareValueError,
    required this.cycleLengthError,
    required this.meetingScheduleError,
    required this.paymentDeadlineError,
  });

  final _SetupStep step;
  final DateTime startDate;
  final VoidCallback onPickStartDate;
  final GroupType groupType;
  final ValueChanged<GroupType> onGroupTypeChanged;
  final PayoutMethod payoutMethod;
  final ValueChanged<PayoutMethod> onPayoutMethodChanged;
  final bool allowShareTransfers;
  final ValueChanged<bool> onAllowShareTransfersChanged;
  final MissedPaymentPolicy missedPaymentPolicy;
  final ValueChanged<MissedPaymentPolicy> onMissedPaymentPolicyChanged;
  final bool feesEnabled;
  final ValueChanged<bool> onFeesEnabledChanged;
  final FeePayerModel feePayerModel;
  final ValueChanged<FeePayerModel> onFeePayerModelChanged;

  final TextEditingController nameController;
  final TextEditingController memberCountController;
  final TextEditingController shareValueController;
  final TextEditingController maxSharesController;
  final TextEditingController cycleLengthController;
  final TextEditingController meetingScheduleController;
  final TextEditingController paymentDeadlineController;
  final TextEditingController groupChannelController;
  final TextEditingController gracePeriodDaysController;
  final TextEditingController lateFeeController;
  final TextEditingController feeAmountController;

  final String? nameError;
  final String? memberCountError;
  final String? shareValueError;
  final String? cycleLengthError;
  final String? meetingScheduleError;
  final String? paymentDeadlineError;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      _SetupStep.basics => _BasicsStep(
        startDate: startDate,
        onPickStartDate: onPickStartDate,
        payoutMethod: payoutMethod,
        onPayoutMethodChanged: onPayoutMethodChanged,
        nameController: nameController,
        groupChannelController: groupChannelController,
        nameError: nameError,
      ),
      _SetupStep.membersAndShares => _MembersAndSharesStep(
        groupType: groupType,
        onGroupTypeChanged: onGroupTypeChanged,
        allowShareTransfers: allowShareTransfers,
        onAllowShareTransfersChanged: onAllowShareTransfersChanged,
        memberCountController: memberCountController,
        shareValueController: shareValueController,
        maxSharesController: maxSharesController,
        memberCountError: memberCountError,
        shareValueError: shareValueError,
      ),
      _SetupStep.schedule => _ScheduleStep(
        cycleLengthController: cycleLengthController,
        meetingScheduleController: meetingScheduleController,
        paymentDeadlineController: paymentDeadlineController,
        cycleLengthError: cycleLengthError,
        meetingScheduleError: meetingScheduleError,
        paymentDeadlineError: paymentDeadlineError,
      ),
      _SetupStep.policies => _PoliciesStep(
        missedPaymentPolicy: missedPaymentPolicy,
        onMissedPaymentPolicyChanged: onMissedPaymentPolicyChanged,
        gracePeriodDaysController: gracePeriodDaysController,
        lateFeeController: lateFeeController,
      ),
      _SetupStep.fees => _FeesStep(
        feesEnabled: feesEnabled,
        onFeesEnabledChanged: onFeesEnabledChanged,
        feeAmountController: feeAmountController,
        feePayerModel: feePayerModel,
        onFeePayerModelChanged: onFeePayerModelChanged,
      ),
      _SetupStep.review => _ReviewStep(
        startDate: startDate,
        groupType: groupType,
        payoutMethod: payoutMethod,
        allowShareTransfers: allowShareTransfers,
        missedPaymentPolicy: missedPaymentPolicy,
        feesEnabled: feesEnabled,
        feePayerModel: feePayerModel,
        nameController: nameController,
        memberCountController: memberCountController,
        shareValueController: shareValueController,
        maxSharesController: maxSharesController,
        cycleLengthController: cycleLengthController,
        meetingScheduleController: meetingScheduleController,
        paymentDeadlineController: paymentDeadlineController,
        groupChannelController: groupChannelController,
        gracePeriodDaysController: gracePeriodDaysController,
        lateFeeController: lateFeeController,
        feeAmountController: feeAmountController,
      ),
    };
  }
}

class _BasicsStep extends StatelessWidget {
  const _BasicsStep({
    required this.startDate,
    required this.onPickStartDate,
    required this.payoutMethod,
    required this.onPayoutMethodChanged,
    required this.nameController,
    required this.groupChannelController,
    required this.nameError,
  });

  final DateTime startDate;
  final VoidCallback onPickStartDate;
  final PayoutMethod payoutMethod;
  final ValueChanged<PayoutMethod> onPayoutMethodChanged;
  final TextEditingController nameController;
  final TextEditingController groupChannelController;
  final String? nameError;

  @override
  Widget build(BuildContext context) {
    final startDateLabel = MaterialLocalizations.of(
      context,
    ).formatMediumDate(startDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'Shomiti name',
          fieldKey: const Key('setup_name_field'),
          controller: nameController,
          errorText: nameError,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppSpacing.s12),
        ListTile(
          key: const Key('setup_start_date_button'),
          contentPadding: EdgeInsets.zero,
          title: const Text('Start date'),
          subtitle: Text(startDateLabel),
          trailing: const Icon(Icons.calendar_today),
          onTap: onPickStartDate,
        ),
        const SizedBox(height: AppSpacing.s12),
        DropdownButtonFormField<PayoutMethod>(
          key: const Key('setup_payout_method_field'),
          decoration: const InputDecoration(labelText: 'Payout method'),
          initialValue: payoutMethod,
          items: [
            for (final method in PayoutMethod.values)
              DropdownMenuItem(value: method, child: Text(method.label)),
          ],
          onChanged: (value) {
            if (value == null) return;
            onPayoutMethodChanged(value);
          },
        ),
        const SizedBox(height: AppSpacing.s12),
        AppTextField(
          label: 'Group channel (optional)',
          fieldKey: const Key('setup_group_channel_field'),
          controller: groupChannelController,
        ),
      ],
    );
  }
}

class _MembersAndSharesStep extends StatelessWidget {
  const _MembersAndSharesStep({
    required this.groupType,
    required this.onGroupTypeChanged,
    required this.allowShareTransfers,
    required this.onAllowShareTransfersChanged,
    required this.memberCountController,
    required this.shareValueController,
    required this.maxSharesController,
    required this.memberCountError,
    required this.shareValueError,
  });

  final GroupType groupType;
  final ValueChanged<GroupType> onGroupTypeChanged;
  final bool allowShareTransfers;
  final ValueChanged<bool> onAllowShareTransfersChanged;

  final TextEditingController memberCountController;
  final TextEditingController shareValueController;
  final TextEditingController maxSharesController;

  final String? memberCountError;
  final String? shareValueError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Group type'),
        const SizedBox(height: AppSpacing.s8),
        RadioGroup<GroupType>(
          groupValue: groupType,
          onChanged: (value) {
            if (value == null) return;
            onGroupTypeChanged(value);
          },
          child: Column(
            children: [
              for (final type in GroupType.values)
                RadioListTile<GroupType>(
                  key: Key('setup_group_type_${type.name}'),
                  contentPadding: EdgeInsets.zero,
                  title: Text(type.label),
                  value: type,
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s12),
        AppTextField(
          label: 'Number of members (N)',
          fieldKey: const Key('setup_member_count_field'),
          controller: memberCountController,
          keyboardType: TextInputType.number,
          errorText: memberCountError,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppSpacing.s12),
        AppTextField(
          label: 'Share value per month (S, BDT)',
          fieldKey: const Key('setup_share_value_field'),
          controller: shareValueController,
          keyboardType: TextInputType.number,
          errorText: shareValueError,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppSpacing.s12),
        AppTextField(
          label: 'Max shares per person',
          fieldKey: const Key('setup_max_shares_field'),
          controller: maxSharesController,
          keyboardType: TextInputType.number,
          helperText: 'Recommended: keep low (default 1).',
        ),
        const SizedBox(height: AppSpacing.s12),
        SwitchListTile(
          key: const Key('setup_allow_transfers_switch'),
          contentPadding: EdgeInsets.zero,
          title: const Text('Allow share transfers'),
          subtitle: const Text(
            'Not recommended. If enabled later, unanimous approval is required.',
          ),
          value: allowShareTransfers,
          onChanged: onAllowShareTransfersChanged,
        ),
      ],
    );
  }
}

class _ScheduleStep extends StatelessWidget {
  const _ScheduleStep({
    required this.cycleLengthController,
    required this.meetingScheduleController,
    required this.paymentDeadlineController,
    required this.cycleLengthError,
    required this.meetingScheduleError,
    required this.paymentDeadlineError,
  });

  final TextEditingController cycleLengthController;
  final TextEditingController meetingScheduleController;
  final TextEditingController paymentDeadlineController;

  final String? cycleLengthError;
  final String? meetingScheduleError;
  final String? paymentDeadlineError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'Cycle length (months)',
          fieldKey: const Key('setup_cycle_length_field'),
          controller: cycleLengthController,
          keyboardType: TextInputType.number,
          helperText: 'Typically equals total shares.',
          errorText: cycleLengthError,
        ),
        const SizedBox(height: AppSpacing.s12),
        AppTextField(
          label: 'Meeting day/time',
          fieldKey: const Key('setup_meeting_schedule_field'),
          controller: meetingScheduleController,
          hint: 'e.g., Every month, Friday 8pm',
          errorText: meetingScheduleError,
        ),
        const SizedBox(height: AppSpacing.s12),
        AppTextField(
          label: 'Payment deadline each month',
          fieldKey: const Key('setup_payment_deadline_field'),
          controller: paymentDeadlineController,
          hint: 'e.g., 5th day of the month',
          errorText: paymentDeadlineError,
        ),
      ],
    );
  }
}

class _PoliciesStep extends StatelessWidget {
  const _PoliciesStep({
    required this.missedPaymentPolicy,
    required this.onMissedPaymentPolicyChanged,
    required this.gracePeriodDaysController,
    required this.lateFeeController,
  });

  final MissedPaymentPolicy missedPaymentPolicy;
  final ValueChanged<MissedPaymentPolicy> onMissedPaymentPolicyChanged;
  final TextEditingController gracePeriodDaysController;
  final TextEditingController lateFeeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Short pot policy (choose one)'),
        const SizedBox(height: AppSpacing.s8),
        RadioGroup<MissedPaymentPolicy>(
          groupValue: missedPaymentPolicy,
          onChanged: (value) {
            if (value == null) return;
            onMissedPaymentPolicyChanged(value);
          },
          child: Column(
            children: [
              for (final policy in MissedPaymentPolicy.values)
                RadioListTile<MissedPaymentPolicy>(
                  key: Key('setup_missed_policy_${policy.name}'),
                  contentPadding: EdgeInsets.zero,
                  title: Text(policy.label),
                  value: policy,
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s12),
        AppTextField(
          label: 'Grace period (days, optional)',
          fieldKey: const Key('setup_grace_period_days_field'),
          controller: gracePeriodDaysController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppSpacing.s12),
        AppTextField(
          label: 'Late fee (BDT per day, optional)',
          fieldKey: const Key('setup_late_fee_field'),
          controller: lateFeeController,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

class _FeesStep extends StatelessWidget {
  const _FeesStep({
    required this.feesEnabled,
    required this.onFeesEnabledChanged,
    required this.feeAmountController,
    required this.feePayerModel,
    required this.onFeePayerModelChanged,
  });

  final bool feesEnabled;
  final ValueChanged<bool> onFeesEnabledChanged;
  final TextEditingController feeAmountController;
  final FeePayerModel feePayerModel;
  final ValueChanged<FeePayerModel> onFeePayerModelChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          key: const Key('setup_fees_enabled_switch'),
          contentPadding: EdgeInsets.zero,
          title: const Text('Enable fees'),
          subtitle: const Text('Optional admin/service fee (Section 11).'),
          value: feesEnabled,
          onChanged: onFeesEnabledChanged,
        ),
        const SizedBox(height: AppSpacing.s12),
        if (feesEnabled) ...[
          AppTextField(
            label: 'Fee amount (BDT)',
            fieldKey: const Key('setup_fee_amount_field'),
            controller: feeAmountController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.s12),
          DropdownButtonFormField<FeePayerModel>(
            key: const Key('setup_fee_payer_model_field'),
            decoration: const InputDecoration(labelText: 'Who pays fees'),
            initialValue: feePayerModel,
            items: [
              for (final model in FeePayerModel.values)
                DropdownMenuItem(value: model, child: Text(model.label)),
            ],
            onChanged: (value) {
              if (value == null) return;
              onFeePayerModelChanged(value);
            },
          ),
        ] else ...[
          const Text('No fees will be applied.'),
        ],
      ],
    );
  }
}

class _ReviewStep extends StatelessWidget {
  const _ReviewStep({
    required this.startDate,
    required this.groupType,
    required this.payoutMethod,
    required this.allowShareTransfers,
    required this.missedPaymentPolicy,
    required this.feesEnabled,
    required this.feePayerModel,
    required this.nameController,
    required this.memberCountController,
    required this.shareValueController,
    required this.maxSharesController,
    required this.cycleLengthController,
    required this.meetingScheduleController,
    required this.paymentDeadlineController,
    required this.groupChannelController,
    required this.gracePeriodDaysController,
    required this.lateFeeController,
    required this.feeAmountController,
  });

  final DateTime startDate;
  final GroupType groupType;
  final PayoutMethod payoutMethod;
  final bool allowShareTransfers;
  final MissedPaymentPolicy missedPaymentPolicy;
  final bool feesEnabled;
  final FeePayerModel feePayerModel;

  final TextEditingController nameController;
  final TextEditingController memberCountController;
  final TextEditingController shareValueController;
  final TextEditingController maxSharesController;
  final TextEditingController cycleLengthController;
  final TextEditingController meetingScheduleController;
  final TextEditingController paymentDeadlineController;
  final TextEditingController groupChannelController;
  final TextEditingController gracePeriodDaysController;
  final TextEditingController lateFeeController;
  final TextEditingController feeAmountController;

  @override
  Widget build(BuildContext context) {
    final startDateLabel = MaterialLocalizations.of(
      context,
    ).formatMediumDate(startDate);

    String line(String label, String value) => '$label: $value';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          line(
            'Name',
            nameController.text.trim().isEmpty
                ? '—'
                : nameController.text.trim(),
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(line('Start date', startDateLabel)),
        const SizedBox(height: AppSpacing.s8),
        Text(line('Group type', groupType.label)),
        const SizedBox(height: AppSpacing.s8),
        Text(
          line(
            'Members (N)',
            memberCountController.text.trim().isEmpty
                ? '—'
                : memberCountController.text.trim(),
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(
          line(
            'Share value (S)',
            shareValueController.text.trim().isEmpty
                ? '—'
                : '${shareValueController.text.trim()} BDT',
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(
          line(
            'Max shares/person',
            maxSharesController.text.trim().isEmpty
                ? '—'
                : maxSharesController.text.trim(),
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(
          line(
            'Cycle length',
            cycleLengthController.text.trim().isEmpty
                ? '—'
                : '${cycleLengthController.text.trim()} months',
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(
          line(
            'Meeting',
            meetingScheduleController.text.trim().isEmpty
                ? '—'
                : meetingScheduleController.text.trim(),
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(
          line(
            'Payment deadline',
            paymentDeadlineController.text.trim().isEmpty
                ? '—'
                : paymentDeadlineController.text.trim(),
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(line('Payout method', payoutMethod.label)),
        const SizedBox(height: AppSpacing.s8),
        Text(
          line(
            'Share transfers',
            allowShareTransfers ? 'Allowed' : 'Not allowed (recommended)',
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(line('Short pot policy', missedPaymentPolicy.label)),
        const SizedBox(height: AppSpacing.s8),
        Text(
          line(
            'Grace period',
            gracePeriodDaysController.text.trim().isEmpty
                ? '—'
                : '${gracePeriodDaysController.text.trim()} days',
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(
          line(
            'Late fee',
            lateFeeController.text.trim().isEmpty
                ? '—'
                : '${lateFeeController.text.trim()} BDT/day',
          ),
        ),
        const SizedBox(height: AppSpacing.s8),
        Text(line('Fees', feesEnabled ? 'Enabled' : 'Disabled')),
        if (feesEnabled) ...[
          const SizedBox(height: AppSpacing.s8),
          Text(
            line(
              'Fee amount',
              feeAmountController.text.trim().isEmpty
                  ? '—'
                  : '${feeAmountController.text.trim()} BDT',
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          Text(line('Fee payer', feePayerModel.label)),
        ],
        const SizedBox(height: AppSpacing.s8),
        Text(
          line(
            'Group channel',
            groupChannelController.text.trim().isEmpty
                ? '—'
                : groupChannelController.text.trim(),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/ui/components/app_button.dart';
import '../../../../core/ui/components/app_empty_state.dart';
import '../../../../core/ui/components/app_error_state.dart';
import '../../../../core/ui/components/app_loading_state.dart';
import '../../../../core/ui/components/app_status_chip.dart';
import '../../../../core/ui/components/app_text_field.dart';
import '../../../../core/ui/tokens/app_spacing.dart';
import 'providers/governance_demo_providers.dart';

class MemberSignoffPage extends ConsumerWidget {
  const MemberSignoffPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final governance = ref.watch(governanceDemoControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(governanceSignoffTitle)),
      body: governance.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load sign-off status.'),
        ),
        data: (data) {
          if (data == null) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'No Shomiti found',
                message: 'Create a Shomiti first, then record sign-off.',
                icon: Icons.fact_check_outlined,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.s16),
            itemCount: data.members.length + 1,
            separatorBuilder: (context, index) =>
                index == 0 ? const SizedBox(height: AppSpacing.s12) : const Divider(height: 1),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Row(
                  children: [
                    Text(
                      'Signed ${data.signedCount}/${data.members.length}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    AppStatusChip(
                      label: data.signedCount == data.members.length
                          ? 'Complete'
                          : 'In progress',
                      kind: data.signedCount == data.members.length
                          ? AppStatusKind.success
                          : AppStatusKind.info,
                    ),
                  ],
                );
              }

              final memberIndex = index - 1;
              final member = data.members[memberIndex];

              final statusChip = member.consent.isSigned
                  ? const AppStatusChip(
                      label: 'Signed',
                      kind: AppStatusKind.success,
                    )
                  : const AppStatusChip(
                      label: 'Pending',
                      kind: AppStatusKind.warning,
                    );

              final subtitle = member.consent.isSigned
                  ? _signedSubtitle(context, member.consent)
                  : 'Tap to record consent';

              return ListTile(
                key: Key('signoff_member_$memberIndex'),
                title: Text(member.name),
                subtitle: Text(subtitle),
                trailing: statusChip,
                onTap: () async {
                  if (member.consent.isSigned) {
                    await _showConsentDetailsDialog(
                      context: context,
                      memberName: member.name,
                      consent: member.consent,
                    );
                    return;
                  }

                  final recorded = await _showRecordConsentDialog(
                    context: context,
                    memberName: member.name,
                    memberIndex: memberIndex,
                    ref: ref,
                  );

                  if (!recorded || !context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Recorded sign-off for ${member.name}.')),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _signedSubtitle(BuildContext context, GovernanceMemberConsent consent) {
    final signedAt = consent.signedAt;
    final date = signedAt == null
        ? null
        : MaterialLocalizations.of(context).formatShortDate(signedAt);
    final datePart = date == null ? null : 'Signed $date';
    final proof =
        consent.proofType == null ? null : _proofTypeLabel(consent.proofType!);
    final reference = consent.proofReference;
    final referencePart =
        (reference == null || reference.isEmpty) ? null : reference;

    return [
      ?datePart,
      ?proof,
      ?referencePart,
    ].join(' · ');
  }

  String _proofTypeLabel(ConsentProofType type) => switch (type) {
        ConsentProofType.signature => 'Signature',
        ConsentProofType.otp => 'OTP',
        ConsentProofType.chatReference => 'Chat reference',
      };

  Future<void> _showConsentDetailsDialog({
    required BuildContext context,
    required String memberName,
    required GovernanceMemberConsent consent,
  }) async {
    final proof = consent.proofType == null ? null : _proofTypeLabel(consent.proofType!);

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(memberName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (consent.signedAt != null)
              Text(
                'Signed: ${MaterialLocalizations.of(context).formatShortDate(consent.signedAt!)}',
              ),
            if (proof != null) Text('Proof: $proof'),
            if (consent.proofReference != null)
              Text('Reference: ${consent.proofReference}'),
          ],
        ),
        actions: [
          AppButton.secondary(
            key: const Key('signoff_details_close'),
            label: 'Close',
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }

  Future<bool> _showRecordConsentDialog({
    required BuildContext context,
    required String memberName,
    required int memberIndex,
    required WidgetRef ref,
  }) async {
    final formKey = GlobalKey<FormState>();
    final proofReferenceController = TextEditingController();
    var proofType = ConsentProofType.signature;

    final recorded = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Record sign-off: $memberName'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<ConsentProofType>(
                key: const Key('signoff_proof_type'),
                initialValue: proofType,
                items: ConsentProofType.values
                    .map(
                      (type) => DropdownMenuItem<ConsentProofType>(
                        value: type,
                        child: Text(_proofTypeLabel(type)),
                      ),
                    )
                    .toList(),
                onChanged: (value) => proofType = value ?? proofType,
                decoration: const InputDecoration(labelText: 'Proof type'),
              ),
              const SizedBox(height: AppSpacing.s12),
              AppTextField(
                label: 'Proof reference',
                fieldKey: const Key('signoff_proof_reference'),
                controller: proofReferenceController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Required';
                  return null;
                },
                hint: 'e.g. chat message link, OTP code, signature note',
              ),
            ],
          ),
        ),
        actions: [
          AppButton.secondary(
            key: const Key('signoff_cancel'),
            label: 'Cancel',
            onPressed: () => context.pop(false),
          ),
          AppButton.primary(
            key: Key('signoff_confirm_$memberIndex'),
            label: 'Record',
            onPressed: () {
              if (!(formKey.currentState?.validate() ?? false)) return;

              ref.read(governanceDemoControllerProvider.notifier).recordConsent(
                    memberIndex: memberIndex,
                    proofType: proofType,
                    proofReference: proofReferenceController.text.trim(),
                  );

              context.pop(true);
            },
          ),
        ],
      ),
    );

    return recorded ?? false;
  }
}

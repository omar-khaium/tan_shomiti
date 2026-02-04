import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_status_chip.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'providers/members_demo_providers.dart';

class MemberDetailPage extends ConsumerStatefulWidget {
  const MemberDetailPage({required this.memberId, super.key});

  final String memberId;

  @override
  ConsumerState<MemberDetailPage> createState() => _MemberDetailPageState();
}

class _MemberDetailPageState extends ConsumerState<MemberDetailPage> {
  bool _showSensitive = false;

  @override
  Widget build(BuildContext context) {
    final members = ref.watch(membersDemoControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Member'),
        actions: [
          AppButton.tertiary(
            key: const Key('member_edit'),
            label: 'Edit',
            onPressed: () => context.push(memberEditLocation(widget.memberId)),
          ),
        ],
      ),
      body: members.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load member.'),
        ),
        data: (state) {
          MembersDemoMember? member;
          for (final candidate in state.members) {
            if (candidate.id == widget.memberId) {
              member = candidate;
              break;
            }
          }

          if (member == null) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.s16),
              child: AppEmptyState(
                title: 'Member not found',
                message: 'This member may have been removed from the list.',
                icon: Icons.person_off_outlined,
              ),
            );
          }
          final resolved = member;

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.s16),
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          resolved.fullName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        AppStatusChip(
                          label: resolved.isActive ? 'Active' : 'Inactive',
                          kind: resolved.isActive
                              ? AppStatusKind.success
                              : AppStatusKind.error,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    SwitchListTile.adaptive(
                      key: const Key('member_show_sensitive_toggle'),
                      value: _showSensitive,
                      onChanged: (value) =>
                          setState(() => _showSensitive = value),
                      title: const Text('Show sensitive info'),
                      subtitle: const Text('Mask phone and ID by default.'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.s16),
              _Field(label: 'Phone', value: _maskPhone(resolved.phone)),
              _Field(
                label: 'Address/workplace',
                value: resolved.addressOrWorkplace,
              ),
              _Field(
                label: 'NID/Passport',
                value: _maskId(resolved.nidOrPassport),
              ),
              const Divider(),
              _Field(
                label: 'Emergency contact',
                value: resolved.emergencyContactName,
              ),
              _Field(
                label: 'Emergency phone',
                value: _maskPhone(resolved.emergencyContactPhone),
              ),
              if (resolved.notes?.trim().isNotEmpty == true) ...[
                const Divider(),
                _Field(label: 'Notes', value: resolved.notes!.trim()),
              ],
              const SizedBox(height: AppSpacing.s24),
              AppButton.secondary(
                key: const Key('member_deactivate'),
                label: resolved.isActive
                    ? 'Deactivate member'
                    : 'Member inactive',
                onPressed: resolved.isActive
                    ? () async {
                        await ref
                            .read(membersDemoControllerProvider.notifier)
                            .deactivateMember(resolved.id);

                        if (!context.mounted) return;
                        context.pop();
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }

  String _maskPhone(String phone) {
    if (_showSensitive) return phone;
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length <= 4) return phone;
    final visible = digits.substring(digits.length - 3);
    return '${digits.substring(0, 2)}******$visible';
  }

  String _maskId(String? id) {
    if (id == null || id.trim().isEmpty) return 'Not set';
    if (_showSensitive) return id.trim();
    final trimmed = id.trim();
    if (trimmed.length <= 4) return '****';
    return '${trimmed.substring(0, 2)}********${trimmed.substring(trimmed.length - 2)}';
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: AppSpacing.s12),
          Expanded(child: Text(value, textAlign: TextAlign.end)),
        ],
      ),
    );
  }
}

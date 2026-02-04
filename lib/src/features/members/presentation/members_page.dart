import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/components/app_error_state.dart';
import '../../../core/ui/components/app_loading_state.dart';
import '../../../core/ui/components/app_status_chip.dart';
import '../../../core/ui/tokens/app_spacing.dart';
import 'providers/members_demo_providers.dart';

class MembersPage extends ConsumerWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersDemoControllerProvider);

    return Scaffold(
      floatingActionButton: members.maybeWhen(
        data: (state) => FloatingActionButton(
          key: const Key('members_add'),
          onPressed: state.isJoiningClosed
              ? null
              : () => context.push(memberAddLocation),
          child: const Icon(Icons.add),
        ),
        orElse: () => const SizedBox.shrink(),
      ),
      body: members.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppLoadingState(),
        ),
        error: (error, stack) => const Padding(
          padding: EdgeInsets.all(AppSpacing.s16),
          child: AppErrorState(message: 'Failed to load members.'),
        ),
        data: (state) {
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.s16),
            children: [
              if (state.isJoiningClosed)
                AppCard(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lock_outline),
                      const SizedBox(width: AppSpacing.s12),
                      Expanded(
                        child: Text(
                          state.closedJoiningReason ??
                              'Joining is closed. No new members can be added.',
                        ),
                      ),
                    ],
                  ),
                ),
              if (state.isJoiningClosed) const SizedBox(height: AppSpacing.s16),
              if (state.members.isEmpty)
                const AppEmptyState(
                  title: 'No members yet',
                  message:
                      'Add members to record identity, contact, and emergency details.',
                  icon: Icons.group_outlined,
                )
              else
                _MemberList(
                  members: state.members,
                  onTapMember: (memberId) =>
                      context.push(memberDetailsLocation(memberId)),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _MemberList extends StatelessWidget {
  const _MemberList({required this.members, required this.onTapMember});

  final List<MembersDemoMember> members;
  final ValueChanged<String> onTapMember;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final member in members) ...[
          ListTile(
            key: Key('member_row_${member.id}'),
            title: Text(member.fullName),
            subtitle: Text(_maskPhone(member.phone)),
            trailing: AppStatusChip(
              label: member.isActive
                  ? (member.isProfileComplete ? 'Active' : 'Incomplete')
                  : 'Inactive',
              kind: member.isActive
                  ? (member.isProfileComplete
                        ? AppStatusKind.success
                        : AppStatusKind.warning)
                  : AppStatusKind.error,
            ),
            onTap: () => onTapMember(member.id),
          ),
          const Divider(height: 1),
        ],
      ],
    );
  }

  String _maskPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length <= 4) return phone;
    final visible = digits.substring(digits.length - 3);
    return '${digits.substring(0, 2)}******$visible';
  }
}

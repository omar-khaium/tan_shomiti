import 'package:flutter/material.dart';

import '../components/app_button.dart';
import '../components/app_card.dart';
import '../components/app_confirm_dialog.dart';
import '../components/app_empty_state.dart';
import '../components/app_error_state.dart';
import '../components/app_list_row.dart';
import '../components/app_loading_state.dart';
import '../components/app_status_chip.dart';
import '../components/app_text_field.dart';
import '../tokens/app_spacing.dart';

class ComponentsGalleryPage extends StatelessWidget {
  const ComponentsGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Components')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        children: [
          _Section(
            title: 'Buttons',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppSpacing.s12,
                  runSpacing: AppSpacing.s12,
                  children: [
                    AppButton.primary(
                      label: 'Primary',
                      onPressed: () {},
                    ),
                    AppButton.secondary(
                      label: 'Secondary',
                      onPressed: () {},
                    ),
                    AppButton.tertiary(
                      label: 'Tertiary',
                      onPressed: () {},
                    ),
                    AppButton.primary(
                      label: 'Disabled',
                      onPressed: null,
                    ),
                    AppButton.primary(
                      label: 'Loading',
                      onPressed: () {},
                      isLoading: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
          _Section(
            title: 'Inputs',
            child: Column(
              children: const [
                AppTextField(
                  label: 'Shomiti name',
                  hint: 'e.g. Office Tan',
                  helperText: 'This is visible to group members.',
                ),
                SizedBox(height: AppSpacing.s12),
                AppTextField(
                  label: 'Share value (BDT)',
                  hint: 'e.g. 2000',
                  errorText: 'Please enter a valid amount.',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
          _Section(
            title: 'Cards + rows',
            child: AppCard(
              child: Column(
                children: [
                  AppListRow(
                    title: 'Monthly pot',
                    value: 'BDT 20,000',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  AppListRow(
                    title: 'Payment deadline',
                    value: 'Every 5th, 8:00 PM',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
          _Section(
            title: 'Status chips',
            child: Wrap(
              spacing: AppSpacing.s12,
              runSpacing: AppSpacing.s12,
              children: const [
                AppStatusChip(label: 'Paid', kind: AppStatusKind.success),
                AppStatusChip(label: 'Pending', kind: AppStatusKind.warning),
                AppStatusChip(label: 'Overdue', kind: AppStatusKind.error),
                AppStatusChip(label: 'Eligible', kind: AppStatusKind.info),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
          _Section(
            title: 'States',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AppLoadingState(),
                SizedBox(height: AppSpacing.s12),
                AppEmptyState(
                  title: 'No entries yet',
                  message: 'Create a Shomiti to start tracking monthly dues.',
                  icon: Icons.inbox_outlined,
                ),
                SizedBox(height: AppSpacing.s12),
                AppErrorState(
                  message: 'Something went wrong. Please try again.',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s24),
          _Section(
            title: 'Dialogs',
            child: AppButton.secondary(
              label: 'Show confirm dialog',
              onPressed: () async {
                await showAppConfirmDialog(
                  context: context,
                  title: 'Delete draft?',
                  message:
                      'This will remove the draft setup. You can start again anytime.',
                  confirmLabel: 'Delete',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.s12),
        child,
      ],
    );
  }
}


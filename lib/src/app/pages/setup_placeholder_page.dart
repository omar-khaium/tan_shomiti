import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/ui/components/app_button.dart';
import '../../core/ui/tokens/app_spacing.dart';
import '../router/app_router.dart';

class SetupPlaceholderPage extends ConsumerWidget {
  const SetupPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No Shomiti is configured yet.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.s8),
            const Text(
              'In the next sprint, this becomes the full setup wizard.',
            ),
            const SizedBox(height: AppSpacing.s16),
            AppButton.primary(
              key: const Key('setup_continue_demo'),
              label: 'Continue in demo mode',
              onPressed: () {
                ref.read(shomitiConfiguredProvider.notifier).state = true;
                context.go(dashboardLocation);
              },
            ),
          ],
        ),
      ),
    );
  }
}

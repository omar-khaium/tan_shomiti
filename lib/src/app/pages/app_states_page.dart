import 'package:flutter/material.dart';

import '../../core/ui/components/app_card.dart';
import '../../core/ui/components/app_empty_state.dart';
import '../../core/ui/components/app_error_state.dart';
import '../../core/ui/components/app_loading_state.dart';
import '../../core/ui/tokens/app_spacing.dart';

class AppStatesPage extends StatelessWidget {
  const AppStatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App states')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        children: const [
          _StateSection(
            title: 'Loading',
            child: AppLoadingState(),
          ),
          SizedBox(height: AppSpacing.s16),
          _StateSection(
            title: 'Empty',
            child: AppEmptyState(
              title: 'Nothing to show yet.',
              message: 'Create a Shomiti to get started.',
            ),
          ),
          SizedBox(height: AppSpacing.s16),
          _StateSection(
            title: 'Error',
            child: AppErrorState(
              message: 'Something went wrong. Please try again.',
              onRetry: _noop,
            ),
          ),
        ],
      ),
    );
  }
}

void _noop() {}

class _StateSection extends StatelessWidget {
  const _StateSection({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.s12),
          child,
        ],
      ),
    );
  }
}

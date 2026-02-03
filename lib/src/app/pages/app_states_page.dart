import 'package:flutter/material.dart';

class AppStatesPage extends StatelessWidget {
  const AppStatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App states')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _StateCard(
            title: 'Loading',
            child: _LoadingState(),
          ),
          SizedBox(height: 16),
          _StateCard(
            title: 'Empty',
            child: _EmptyState(),
          ),
          SizedBox(height: 16),
          _StateCard(
            title: 'Error',
            child: _ErrorState(),
          ),
        ],
      ),
    );
  }
}

class _StateCard extends StatelessWidget {
  const _StateCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        SizedBox(width: 12),
        Text('Loading…'),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Nothing to show yet.\nCreate a Shomiti to get started.',
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Something went wrong. Please try again.'),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () {},
          child: const Text('Retry'),
        ),
      ],
    );
  }
}


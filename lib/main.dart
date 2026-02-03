import 'package:flutter/material.dart';

void main() {
  runApp(const TanShomitiApp());
}

class TanShomitiApp extends StatelessWidget {
  const TanShomitiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final sectionTitle = switch (_selectedIndex) {
      0 => 'Dashboard',
      1 => 'Members',
      2 => 'Contributions',
      _ => 'More',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(sectionTitle),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [
            _SectionPlaceholder(title: 'Dashboard'),
            _SectionPlaceholder(title: 'Members'),
            _SectionPlaceholder(title: 'Contributions'),
            _MoreSection(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.group_outlined),
            selectedIcon: Icon(Icons.group),
            label: 'Members',
          ),
          NavigationDestination(
            icon: Icon(Icons.payments_outlined),
            selectedIcon: Icon(Icons.payments),
            label: 'Dues',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            selectedIcon: Icon(Icons.more),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class _SectionPlaceholder extends StatelessWidget {
  const _SectionPlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class _MoreSection extends StatelessWidget {
  const _MoreSection();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        _MoreTile(
          title: 'Draw',
          subtitle: 'Run and record the monthly draw (coming soon)',
          onTap: () => _openPlaceholder(context, 'Draw'),
        ),
        _MoreTile(
          title: 'Payout',
          subtitle: 'Approve payout and store proof (coming soon)',
          onTap: () => _openPlaceholder(context, 'Payout'),
        ),
        _MoreTile(
          title: 'Ledger',
          subtitle: 'View ledger and statements (coming soon)',
          onTap: () => _openPlaceholder(context, 'Ledger'),
        ),
        _MoreTile(
          title: 'Rules',
          subtitle: 'View current rules and versions (coming soon)',
          onTap: () => _openPlaceholder(context, 'Rules'),
        ),
        _MoreTile(
          title: 'Disputes',
          subtitle: 'Track disputes and resolutions (coming soon)',
          onTap: () => _openPlaceholder(context, 'Disputes'),
        ),
        const Divider(),
        _MoreTile(
          title: 'App states',
          subtitle: 'Preview loading/empty/error UI',
          onTap: () => _openAppStates(context),
        ),
        _MoreTile(
          title: 'Settings',
          subtitle: 'Security and app preferences (coming soon)',
          onTap: () => _openPlaceholder(context, 'Settings'),
        ),
      ],
    );
  }

  void _openPlaceholder(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(title)),
          body: Center(child: Text('$title (coming soon)')),
        ),
      ),
    );
  }

  void _openAppStates(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const _AppStatesPage(),
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

class _AppStatesPage extends StatelessWidget {
  const _AppStatesPage();

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

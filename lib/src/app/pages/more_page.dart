import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        _MoreTile(
          title: drawTitle,
          subtitle: 'Run and record the monthly draw',
          onTap: () => context.push(drawLocation),
        ),
        _MoreTile(
          title: payoutTitle,
          subtitle: 'Approve payout and store proof',
          onTap: () => context.push(payoutLocation),
        ),
        _MoreTile(
          title: ledgerTitle,
          subtitle: 'View ledger and statements',
          onTap: () => context.push(ledgerLocation),
        ),
        _MoreTile(
          title: rulesTitle,
          subtitle: 'View current rules and versions',
          onTap: () => context.push(rulesLocation),
        ),
        _MoreTile(
          title: disputesTitle,
          subtitle: 'Track disputes and resolutions',
          onTap: () => context.push(disputesLocation),
        ),
        const Divider(),
        _MoreTile(
          title: 'App states',
          subtitle: 'Preview loading/empty/error UI',
          onTap: () => context.push(appStatesLocation),
        ),
        _MoreTile(
          title: settingsTitle,
          subtitle: 'Security and app preferences',
          onTap: () => context.push(settingsLocation),
        ),
      ],
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

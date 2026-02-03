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
          tileKey: const Key('more_draw'),
          title: drawTitle,
          subtitle: 'Run and record the monthly draw',
          onTap: () => context.push(drawLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_payout'),
          title: payoutTitle,
          subtitle: 'Approve payout and store proof',
          onTap: () => context.push(payoutLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_ledger'),
          title: ledgerTitle,
          subtitle: 'View ledger and statements',
          onTap: () => context.push(ledgerLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_rules'),
          title: rulesTitle,
          subtitle: 'View current rules and versions',
          onTap: () => context.push(rulesLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_disputes'),
          title: disputesTitle,
          subtitle: 'Track disputes and resolutions',
          onTap: () => context.push(disputesLocation),
        ),
        const Divider(),
        _MoreTile(
          tileKey: const Key('more_components'),
          title: componentsTitle,
          subtitle: 'Preview design system components',
          onTap: () => context.push(componentsLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_app_states'),
          title: 'App states',
          subtitle: 'Preview loading/empty/error UI',
          onTap: () => context.push(appStatesLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_settings'),
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
    required this.tileKey,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Key tileKey;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: tileKey,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/data/local/reset_app_data_provider.dart';
import '../../core/ui/components/app_confirm_dialog.dart';
import '../router/app_router.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          tileKey: const Key('more_draw_record'),
          title: 'Draw record',
          subtitle: 'Witness sign-off and redo workflow',
          onTap: () => context.push(drawRecordLocation),
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
          tileKey: const Key('more_statements'),
          title: statementsTitle,
          subtitle: 'Generate and view monthly statements',
          onTap: () => context.push(statementsLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_audit'),
          title: auditTitle,
          subtitle: 'View audit events and approvals',
          onTap: () => context.push(auditLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_governance'),
          title: governanceTitle,
          subtitle: 'Assign roles and record member sign-off',
          onTap: () => context.push(governanceLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_shares'),
          title: sharesTitle,
          subtitle: 'Assign shares and review pot totals',
          onTap: () => context.push(sharesLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_risk_controls'),
          title: riskControlsTitle,
          subtitle: 'Record guarantors and security deposits',
          onTap: () => context.push(riskControlsLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_membership_changes'),
          title: membershipChangesTitle,
          subtitle: 'Exit, replacement, and removal workflows',
          onTap: () => context.push(membershipChangesLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_defaults'),
          title: defaultsTitle,
          subtitle: 'Track missed payments and enforcement steps',
          onTap: () => context.push(defaultsLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_rules'),
          title: rulesTitle,
          subtitle: 'View current rules and versions',
          onTap: () => context.push(rulesLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_rule_changes'),
          title: ruleChangesTitle,
          subtitle: 'Propose and apply rule amendments',
          onTap: () => context.push(ruleChangesLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_disputes'),
          title: disputesTitle,
          subtitle: 'Track disputes and resolutions',
          onTap: () => context.push(disputesLocation),
        ),
        _MoreTile(
          tileKey: const Key('more_exports'),
          title: exportsTitle,
          subtitle: 'Export records (CSV/PDF) with privacy defaults',
          onTap: () => context.push(exportsLocation),
        ),
        const Divider(),
        if (kDebugMode)
          _MoreTile(
            tileKey: const Key('more_reset_app_data'),
            title: 'Reset app data',
            subtitle: 'Debug only: clears the local database.',
            onTap: () async {
              final confirmed = await showAppConfirmDialog(
                context: context,
                title: 'Reset app data?',
                message:
                    'This will permanently delete local data on this device.',
                confirmLabel: 'Reset',
                cancelKey: const Key('reset_app_data_cancel'),
                confirmKey: const Key('reset_app_data_confirm'),
              );

              if (confirmed != true) return;

              await ref.read(resetAppDataProvider)();

              if (!context.mounted) return;
              context.go(setupLocation);
            },
          ),
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

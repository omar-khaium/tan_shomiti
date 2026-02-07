import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_router.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/components/app_list_row.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class ExportsPage extends StatelessWidget {
  const ExportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(exportsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        children: [
          const AppCard(
            child: Text(
              'Privacy notice: Exports may contain financial records. Share only with consent and avoid sharing outside the group.',
              key: Key('exports_privacy_notice'),
            ),
          ),
          const SizedBox(height: AppSpacing.s16),
          AppListRow(
            title: 'Statements',
            value: 'Export a monthly statement (CSV/PDF)',
            onTap: () => context.push(exportStatementLocation),
          ),
          AppListRow(
            title: 'Ledger',
            value: 'Export recent ledger entries (CSV)',
            onTap: () => context.push(exportLedgerLocation),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../../core/ui/components/app_button.dart';
import '../../../core/ui/components/app_card.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class ExportLedgerPage extends StatelessWidget {
  const ExportLedgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export ledger')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.s16),
        children: [
          const AppCard(
            child: Text(
              'Exports will be privacy-safe by default and can be shared only with consent.',
              key: Key('export_ledger_notice'),
            ),
          ),
          const SizedBox(height: AppSpacing.s16),
          AppButton.primary(
            key: const Key('export_ledger_generate'),
            label: 'Generate export (coming soon)',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}


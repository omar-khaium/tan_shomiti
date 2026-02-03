import 'package:flutter/material.dart';

import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class LedgerPage extends StatelessWidget {
  const LedgerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ledger')),
      body: const Padding(
        padding: EdgeInsets.all(AppSpacing.s16),
        child: AppEmptyState(
          title: 'No ledger entries yet',
          message:
              'Once dues and payouts are recorded, entries will show up here.',
          icon: Icons.table_view_outlined,
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../../core/ui/components/app_empty_state.dart';
import '../../../core/ui/tokens/app_spacing.dart';

class AuditLogPage extends StatelessWidget {
  const AuditLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audit log')),
      body: const Padding(
        padding: EdgeInsets.all(AppSpacing.s16),
        child: AppEmptyState(
          title: 'No audit events yet',
          message: 'Actions and approvals will appear here for transparency.',
          icon: Icons.receipt_long_outlined,
        ),
      ),
    );
  }
}


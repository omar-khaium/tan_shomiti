import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/audit/presentation/audit_log_page.dart';
import 'package:tan_shomiti/src/features/ledger/presentation/ledger_page.dart';

void main() {
  testWidgets('Ledger page shows empty state', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const LedgerPage(),
      ),
    );

    expect(find.text('Ledger'), findsOneWidget);
    expect(find.text('No ledger entries yet'), findsOneWidget);
  });

  testWidgets('Audit log page shows empty state', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const AuditLogPage(),
      ),
    );

    expect(find.text('Audit log'), findsOneWidget);
    expect(find.text('No audit events yet'), findsOneWidget);
  });
}


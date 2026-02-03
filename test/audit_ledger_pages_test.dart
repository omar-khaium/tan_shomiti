import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/audit/presentation/audit_log_page.dart';
import 'package:tan_shomiti/src/features/audit/presentation/providers/audit_providers.dart';
import 'package:tan_shomiti/src/features/ledger/presentation/ledger_page.dart';
import 'package:tan_shomiti/src/features/ledger/presentation/providers/ledger_providers.dart';

void main() {
  testWidgets('Ledger page shows empty state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          ledgerProvider.overrideWith((ref) => Stream.value(const [])),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const LedgerPage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Ledger'), findsOneWidget);
    expect(find.text('No ledger entries yet'), findsOneWidget);
  });

  testWidgets('Audit log page shows empty state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          auditLogProvider.overrideWith((ref) => Stream.value(const [])),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const AuditLogPage(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Audit log'), findsOneWidget);
    expect(find.text('No audit events yet'), findsOneWidget);
  });
}

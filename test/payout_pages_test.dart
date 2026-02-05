import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/components/app_button.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/payout/presentation/models/payout_ui_state.dart';
import 'package:tan_shomiti/src/features/payout/presentation/payout_approvals_page.dart';
import 'package:tan_shomiti/src/features/payout/presentation/payout_collection_verification_page.dart';
import 'package:tan_shomiti/src/features/payout/presentation/payout_overview_page.dart';
import 'package:tan_shomiti/src/features/payout/presentation/payout_proof_page.dart';
import 'package:tan_shomiti/src/features/payout/presentation/providers/payout_providers.dart';

void main() {
  Future<void> pumpOverview(
    WidgetTester tester, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const PayoutOverviewPage(),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('Payout overview shows loading state', (tester) async {
    await pumpOverview(
      tester,
      overrides: [
        payoutUiStateProvider.overrideWith((ref) => const AsyncLoading()),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
  });

  testWidgets('Payout overview shows error state', (tester) async {
    await pumpOverview(
      tester,
      overrides: [
        payoutUiStateProvider.overrideWith(
          (ref) => AsyncValue<PayoutUiState>.error(
            Exception('boom'),
            StackTrace.empty,
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load payout.'), findsOneWidget);
  });

  testWidgets('Payout overview shows required keys', (tester) async {
    await pumpOverview(
      tester,
      overrides: [
        payoutUiStateProvider.overrideWith(
          (ref) => AsyncData(
            PayoutUiState(
              month: const BillingMonth(year: 2026, month: 2),
              prerequisites: const PayoutPrerequisitesUiState(
                hasRecordedDraw: false,
                isCollectionVerified: false,
                hasTreasurerApproval: false,
                hasAuditorApproval: false,
              ),
            ),
          ),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('payout_month_label')), findsOneWidget);
    expect(find.byKey(const Key('payout_prereq_draw')), findsOneWidget);
    expect(find.byKey(const Key('payout_prereq_collection')), findsOneWidget);
    expect(find.byKey(const Key('payout_prereq_treasurer')), findsOneWidget);
    expect(find.byKey(const Key('payout_prereq_auditor')), findsOneWidget);
    expect(find.byKey(const Key('payout_continue')), findsOneWidget);

    final button = tester.widget<AppButton>(find.byKey(const Key('payout_continue')));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Payout collection page shows required keys', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const PayoutCollectionVerificationPage(),
      ),
    );

    expect(find.byKey(const Key('payout_collection_due_total')), findsOneWidget);
    expect(find.byKey(const Key('payout_collection_paid_total')), findsOneWidget);
    expect(find.byKey(const Key('payout_collection_short_total')), findsOneWidget);
    expect(find.byKey(const Key('payout_collection_verify')), findsOneWidget);

    final button =
        tester.widget<AppButton>(find.byKey(const Key('payout_collection_verify')));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Payout approvals page toggles approvals', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const PayoutApprovalsPage()),
    );

    expect(find.byKey(const Key('payout_treasurer_note')), findsOneWidget);
    expect(find.byKey(const Key('payout_treasurer_approve')), findsOneWidget);
    expect(find.byKey(const Key('payout_auditor_note')), findsOneWidget);
    expect(find.byKey(const Key('payout_auditor_approve')), findsOneWidget);
    expect(find.byKey(const Key('payout_approval_status')), findsOneWidget);

    expect(find.text('Pending'), findsOneWidget);

    await tester.tap(find.byKey(const Key('payout_treasurer_approve')));
    await tester.pumpAndSettle();
    expect(find.text('Pending'), findsOneWidget);

    await tester.tap(find.byKey(const Key('payout_auditor_approve')));
    await tester.pumpAndSettle();
    expect(find.text('Approved for payout'), findsOneWidget);
  });

  testWidgets('Payout proof requires proof reference', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const PayoutProofPage()),
    );

    expect(find.byKey(const Key('payout_winner_label')), findsOneWidget);
    expect(find.byKey(const Key('payout_amount_label')), findsOneWidget);
    expect(find.byKey(const Key('payout_proof_ref')), findsOneWidget);
    expect(find.byKey(const Key('payout_mark_paid')), findsOneWidget);

    final initialButton =
        tester.widget<AppButton>(find.byKey(const Key('payout_mark_paid')));
    expect(initialButton.onPressed, isNull);

    await tester.enterText(find.byKey(const Key('payout_proof_ref')), 'trx-1');
    await tester.pumpAndSettle();

    final enabledButton =
        tester.widget<AppButton>(find.byKey(const Key('payout_mark_paid')));
    expect(enabledButton.onPressed, isNotNull);
  });
}


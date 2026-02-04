import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/components/app_button.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_snapshot.dart';
import 'package:tan_shomiti/src/features/shares/presentation/models/shares_ui_state.dart';
import 'package:tan_shomiti/src/features/shares/presentation/providers/shares_providers.dart';
import 'package:tan_shomiti/src/features/shares/presentation/shares_page.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(theme: AppTheme.light(), home: const SharesPage()),
      ),
    );
    await tester.pump();
  }

  RuleSetSnapshot demoRules({
    int memberCount = 3,
    int cycleLengthMonths = 4,
    int shareValueBdt = 1000,
    int maxSharesPerPerson = 2,
  }) {
    return RuleSetSnapshot(
      schemaVersion: 1,
      shomitiName: 'Demo',
      startDate: DateTime(2026, 1, 1),
      groupType: GroupTypePolicy.open,
      memberCount: memberCount,
      shareValueBdt: shareValueBdt,
      maxSharesPerPerson: maxSharesPerPerson,
      allowShareTransfers: false,
      cycleLengthMonths: cycleLengthMonths,
      meetingSchedule: 'Every month',
      paymentDeadline: 'Day 5',
      payoutMethod: PayoutMethod.cash,
      groupChannel: null,
      missedPaymentPolicy: MissedPaymentPolicy.postponePayout,
      gracePeriodDays: null,
      lateFeeBdtPerDay: null,
      feesEnabled: false,
      feeAmountBdt: null,
      feePayerModel: FeePayerModel.everyoneEqually,
      ruleChangeAfterStartRequiresUnanimous: true,
    );
  }

  List<Member> demoMembers() {
    return [
      Member(
        id: 'm1',
        shomitiId: 's1',
        position: 1,
        fullName: 'Alice',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: null,
      ),
      Member(
        id: 'm2',
        shomitiId: 's1',
        position: 2,
        fullName: 'Bob',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: null,
      ),
      Member(
        id: 'm3',
        shomitiId: 's1',
        position: 3,
        fullName: 'Chandra',
        phone: null,
        addressOrWorkplace: null,
        emergencyContactName: null,
        emergencyContactPhone: null,
        nidOrPassport: null,
        notes: null,
        isActive: true,
        createdAt: DateTime(2026, 1, 1),
        updatedAt: null,
      ),
    ];
  }

  testWidgets('Shares page shows loading state', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        sharesUiStateProvider.overrideWithValue(const AsyncValue.loading()),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
  });

  testWidgets('Shares page shows error state', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        sharesUiStateProvider.overrideWithValue(
          AsyncValue.error(Exception('boom'), StackTrace.empty),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load shares.'), findsOneWidget);
  });

  testWidgets('Shares page shows empty state when no shomiti', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        sharesUiStateProvider.overrideWithValue(const AsyncValue.data(null)),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('No Shomiti found'), findsOneWidget);
  });

  testWidgets('Shares page shows rows and enables review when valid', (
    tester,
  ) async {
    final rules = demoRules();
    final members = demoMembers();
    final state = SharesUiState.from(
      shomitiId: 's1',
      ruleSetVersionId: 'v1',
      rules: rules,
      members: members,
      sharesByMemberId: const {'m1': 2, 'm2': 1, 'm3': 1},
    );

    await pumpPage(
      tester,
      overrides: [
        sharesUiStateProvider.overrideWithValue(AsyncValue.data(state)),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('shares_row_1')), findsOneWidget);
    expect(find.text('Alice'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byKey(const Key('shares_review')),
      300,
    );
    await tester.pumpAndSettle();

    final reviewButton = tester.widget<AppButton>(
      find.byKey(const Key('shares_review')),
    );
    expect(reviewButton.onPressed, isNotNull);

    await tester.tap(find.byKey(const Key('shares_review')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('shares_review_dialog')), findsOneWidget);
  });

  testWidgets('Shares page disables increment when no shares remaining', (
    tester,
  ) async {
    final state = SharesUiState.from(
      shomitiId: 's1',
      ruleSetVersionId: 'v1',
      rules: demoRules(),
      members: demoMembers(),
      sharesByMemberId: const {'m1': 2, 'm2': 1, 'm3': 1},
    );

    await pumpPage(
      tester,
      overrides: [
        sharesUiStateProvider.overrideWithValue(AsyncValue.data(state)),
      ],
    );

    await tester.pumpAndSettle();
    final inc = tester.widget<IconButton>(
      find.byKey(const Key('shares_increment_2')),
    );
    expect(inc.onPressed, isNull);
  });
}

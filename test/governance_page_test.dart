import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/ui/theme/app_theme.dart';
import 'package:tan_shomiti/src/features/members/presentation/governance/governance_page.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_snapshot.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_version.dart';
import 'package:tan_shomiti/src/features/rules/domain/repositories/rules_repository.dart';
import 'package:tan_shomiti/src/features/rules/presentation/providers/rules_providers.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/domain/entities/shomiti.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/presentation/providers/shomiti_setup_providers.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester, {
    List<Override> overrides = const [],
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const GovernancePage(),
        ),
      ),
    );
    await tester.pump();
  }

  Shomiti createShomiti({String ruleSetVersionId = 'rsv_test'}) {
    final now = DateTime(2024, 1, 1);
    return Shomiti(
      id: activeShomitiId,
      name: 'Test Shomiti',
      startDate: now,
      createdAt: now,
      activeRuleSetVersionId: ruleSetVersionId,
    );
  }

  RuleSetVersion createRules({int memberCount = 3, String id = 'rsv_test'}) {
    return RuleSetVersion(
      id: id,
      createdAt: DateTime(2024, 1, 1),
      snapshot: RuleSetSnapshot(
        schemaVersion: 1,
        shomitiName: 'Test Shomiti',
        startDate: DateTime(2024, 1, 1),
        groupType: GroupTypePolicy.closed,
        memberCount: memberCount,
        shareValueBdt: 1000,
        maxSharesPerPerson: 1,
        allowShareTransfers: false,
        cycleLengthMonths: memberCount,
        meetingSchedule: 'Monthly',
        paymentDeadline: '5th',
        payoutMethod: PayoutMethod.cash,
        groupChannel: null,
        missedPaymentPolicy: MissedPaymentPolicy.postponePayout,
        gracePeriodDays: null,
        lateFeeBdtPerDay: null,
        feesEnabled: false,
        feeAmountBdt: null,
        feePayerModel: FeePayerModel.everyoneEqually,
        ruleChangeAfterStartRequiresUnanimous: true,
      ),
    );
  }

  testWidgets('Governance page shows loading state', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        activeShomitiProvider.overrideWith(
          (ref) => Stream.value(createShomiti()),
        ),
        rulesRepositoryProvider.overrideWith(
          (ref) => _LoadingRulesRepository(),
        ),
      ],
    );

    expect(find.text('Loading…'), findsOneWidget);
  });

  testWidgets('Governance page shows empty state when no shomiti', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        activeShomitiProvider.overrideWith((ref) => Stream.value(null)),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('No governance setup yet'), findsOneWidget);
  });

  testWidgets('Governance page shows error state when rules fail to load', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        activeShomitiProvider.overrideWith(
          (ref) => Stream.value(createShomiti()),
        ),
        rulesRepositoryProvider.overrideWith(
          (ref) => _ThrowingRulesRepository(),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load governance.'), findsOneWidget);
  });

  testWidgets('Governance page shows roles/sign-off tiles when data is loaded', (tester) async {
    await pumpPage(
      tester,
      overrides: [
        activeShomitiProvider.overrideWith(
          (ref) => Stream.value(createShomiti()),
        ),
        rulesRepositoryProvider.overrideWith(
          (ref) => _FakeRulesRepository(createRules(memberCount: 2)),
        ),
      ],
    );

    await tester.pumpAndSettle();
    expect(find.byKey(const Key('governance_roles_tile')), findsOneWidget);
    expect(find.byKey(const Key('governance_signoff_tile')), findsOneWidget);
    expect(find.textContaining('0/2 signed'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}

class _LoadingRulesRepository implements RulesRepository {
  final _completer = Completer<RuleSetVersion?>();

  @override
  Future<RuleSetVersion?> getById(String id) => _completer.future;

  @override
  Future<void> upsert(RuleSetVersion version) async {}
}

class _ThrowingRulesRepository implements RulesRepository {
  @override
  Future<RuleSetVersion?> getById(String id) => Future.error(Exception('boom'));

  @override
  Future<void> upsert(RuleSetVersion version) async {}
}

class _FakeRulesRepository implements RulesRepository {
  _FakeRulesRepository(this._version);

  final RuleSetVersion _version;

  @override
  Future<RuleSetVersion?> getById(String id) async => _version;

  @override
  Future<void> upsert(RuleSetVersion version) async {}
}

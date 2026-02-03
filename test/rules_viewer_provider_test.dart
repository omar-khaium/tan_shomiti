import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_snapshot.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_version.dart';
import 'package:tan_shomiti/src/features/rules/domain/repositories/rules_repository.dart';
import 'package:tan_shomiti/src/features/rules/presentation/providers/rules_providers.dart';
import 'package:tan_shomiti/src/features/rules/presentation/providers/rules_viewer_providers.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/domain/entities/shomiti.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/presentation/providers/shomiti_setup_providers.dart';

void main() {
  test('rulesViewerProvider returns null when no active shomiti', () async {
    final container = ProviderContainer(
      overrides: [
        activeShomitiProvider.overrideWith((ref) => Stream.value(null)),
      ],
    );
    addTearDown(container.dispose);

    final version = await container.read(rulesViewerProvider.future);
    expect(version, isNull);
  });

  test('rulesViewerProvider loads active rule set version', () async {
    final shomiti = Shomiti(
      id: activeShomitiId,
      name: 'My Shomiti',
      startDate: DateTime(2026, 1, 1),
      createdAt: DateTime(2026, 1, 1),
      activeRuleSetVersionId: 'rsv_123',
    );

    final expected = RuleSetVersion(
      id: 'rsv_123',
      createdAt: DateTime(2026, 1, 1),
      snapshot: RuleSetSnapshot(
        schemaVersion: 1,
        shomitiName: 'My Shomiti',
        startDate: DateTime(2026, 1, 1),
        groupType: GroupTypePolicy.closed,
        memberCount: 2,
        shareValueBdt: 1000,
        maxSharesPerPerson: 1,
        allowShareTransfers: false,
        cycleLengthMonths: 2,
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

    final container = ProviderContainer(
      overrides: [
        activeShomitiProvider.overrideWith((ref) => Stream.value(shomiti)),
        rulesRepositoryProvider.overrideWith((ref) => _FakeRulesRepository(expected)),
      ],
    );
    addTearDown(container.dispose);

    final version = await container.read(rulesViewerProvider.future);
    expect(version, isNotNull);
    expect(version!.id, expected.id);
    expect(version.snapshot.memberCount, 2);
  });
}

class _FakeRulesRepository implements RulesRepository {
  _FakeRulesRepository(this._version);

  final RuleSetVersion _version;

  @override
  Future<RuleSetVersion?> getById(String id) async => _version;

  @override
  Future<void> upsert(RuleSetVersion version) async {}
}


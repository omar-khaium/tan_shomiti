import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/audit/data/drift_audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/rules/data/drift_rules_repository.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_snapshot.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/data/drift_shomiti_repository.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/domain/entities/shomiti.dart';
import 'package:tan_shomiti/src/features/shomiti_setup/domain/usecases/create_shomiti.dart';

void main() {
  RuleSetSnapshot validSnapshot({
    String shomitiName = 'My Shomiti',
    bool ruleChangeAfterStartRequiresUnanimous = true,
  }) {
    return RuleSetSnapshot(
      schemaVersion: 1,
      shomitiName: shomitiName,
      startDate: DateTime(2026, 1, 1),
      groupType: GroupTypePolicy.closed,
      memberCount: 10,
      shareValueBdt: 1000,
      maxSharesPerPerson: 1,
      allowShareTransfers: false,
      cycleLengthMonths: 10,
      meetingSchedule: 'Every month, Friday 8pm',
      paymentDeadline: '5th day of the month',
      payoutMethod: PayoutMethod.mobileWallet,
      groupChannel: null,
      missedPaymentPolicy: MissedPaymentPolicy.postponePayout,
      gracePeriodDays: null,
      lateFeeBdtPerDay: null,
      feesEnabled: false,
      feeAmountBdt: null,
      feePayerModel: FeePayerModel.everyoneEqually,
      ruleChangeAfterStartRequiresUnanimous: ruleChangeAfterStartRequiresUnanimous,
    );
  }

  test('CreateShomiti throws when name is missing', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);

    final shomitiRepo = DriftShomitiRepository(db);
    final rulesRepo = DriftRulesRepository(db);
    final auditRepo = DriftAuditRepository(db);

    final usecase = CreateShomiti(
      shomitiRepository: shomitiRepo,
      rulesRepository: rulesRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
      random: Random(0),
    );

    await expectLater(
      usecase(validSnapshot(shomitiName: ' ')),
      throwsA(isA<CreateShomitiValidationException>()),
    );
  });

  test('CreateShomiti persists shomiti + rules + audit', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);

    final shomitiRepo = DriftShomitiRepository(db);
    final rulesRepo = DriftRulesRepository(db);
    final auditRepo = DriftAuditRepository(db);

    final usecase = CreateShomiti(
      shomitiRepository: shomitiRepo,
      rulesRepository: rulesRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
      random: Random(0),
    );

    final snapshot = validSnapshot();
    final created = await usecase(snapshot);

    expect(created.id, activeShomitiId);
    expect(created.name, snapshot.shomitiName);
    expect(created.activeRuleSetVersionId, isNotEmpty);

    final storedShomiti = await shomitiRepo.getActive();
    expect(storedShomiti, isNotNull);
    expect(storedShomiti!.activeRuleSetVersionId, created.activeRuleSetVersionId);

    final storedRuleSet = await rulesRepo.getById(created.activeRuleSetVersionId);
    expect(storedRuleSet, isNotNull);
    expect(storedRuleSet!.snapshot.memberCount, snapshot.memberCount);
    expect(storedRuleSet.snapshot.shareValueBdt, snapshot.shareValueBdt);

    final auditEvents = await auditRepo.watchLatest(limit: 10).first;
    expect(auditEvents, hasLength(1));
    expect(auditEvents.first.action, 'created_shomiti');
  });

  test('CreateShomiti enforces unanimous rule-change after start', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);

    final shomitiRepo = DriftShomitiRepository(db);
    final rulesRepo = DriftRulesRepository(db);
    final auditRepo = DriftAuditRepository(db);

    final usecase = CreateShomiti(
      shomitiRepository: shomitiRepo,
      rulesRepository: rulesRepo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
      random: Random(0),
    );

    await expectLater(
      usecase(validSnapshot(ruleChangeAfterStartRequiresUnanimous: false)),
      throwsA(isA<CreateShomitiValidationException>()),
    );
  });
}


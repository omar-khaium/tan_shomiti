import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/data/local/app_database.dart';
import 'package:tan_shomiti/src/features/contributions/data/drift_monthly_dues_repository.dart';
import 'package:tan_shomiti/src/features/contributions/domain/entities/due_month.dart';
import 'package:tan_shomiti/src/features/contributions/domain/entities/monthly_due.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';

void main() {
  test('DriftMonthlyDuesRepository stores and reads month dues', () async {
    final db = AppDatabase.memory();
    addTearDown(db.close);

    final now = DateTime.utc(2026, 2, 5);

    await db.into(db.shomitis).insert(
      ShomitisCompanion.insert(
        id: 'active',
        name: 'Demo',
        startDate: now,
        createdAt: now,
        activeRuleSetVersionId: 'rsv_1',
      ),
    );

    await db.into(db.ruleSetVersions).insert(
      RuleSetVersionsCompanion.insert(
        id: 'rsv_1',
        createdAt: now,
        json: '{}',
      ),
    );

    await db.batch((b) {
      b.insertAll(db.members, [
        MembersCompanion.insert(
          id: 'm_active_1',
          shomitiId: 'active',
          position: 1,
          displayName: 'Member 1',
          createdAt: now,
        ),
        MembersCompanion.insert(
          id: 'm_active_2',
          shomitiId: 'active',
          position: 2,
          displayName: 'Member 2',
          createdAt: now,
        ),
      ]);
    });

    final repo = DriftMonthlyDuesRepository(db);
    const month = BillingMonth(year: 2026, month: 2);

    await repo.upsertDueMonth(
      DueMonth(
        shomitiId: 'active',
        month: month,
        ruleSetVersionId: 'rsv_1',
        generatedAt: now,
      ),
    );

    await repo.replaceMonthlyDues(
      shomitiId: 'active',
      month: month,
      dues: [
        MonthlyDue(
          shomitiId: 'active',
          month: month,
          memberId: 'm_active_1',
          shares: 2,
          shareValueBdt: 1000,
          dueAmountBdt: 2000,
          createdAt: now,
        ),
      ],
    );

    final loaded = await repo.getDueMonth(shomitiId: 'active', month: month);
    expect(loaded, isNotNull);
    expect(loaded!.ruleSetVersionId, 'rsv_1');

    final dues = await repo.listMonthlyDues(shomitiId: 'active', month: month);
    expect(dues.single.memberId, 'm_active_1');
    expect(dues.single.dueAmountBdt, 2000);
  });
}

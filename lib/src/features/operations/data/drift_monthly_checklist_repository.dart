import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../domain/entities/monthly_checklist_completion.dart';
import '../domain/repositories/monthly_checklist_repository.dart';
import '../domain/value_objects/monthly_checklist_step.dart';

class DriftMonthlyChecklistRepository implements MonthlyChecklistRepository {
  DriftMonthlyChecklistRepository(this.db);

  final AppDatabase db;

  @override
  Future<List<MonthlyChecklistCompletion>> getMonth({
    required String shomitiId,
    required BillingMonth month,
  }) {
    return _selectMonth(shomitiId: shomitiId, month: month);
  }

  Future<List<MonthlyChecklistCompletion>> _selectMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final rows = await (db.select(db.monthlyChecklistItems)
          ..where(
            (t) =>
                t.shomitiId.equals(shomitiId) &
                t.billingMonthKey.equals(month.key),
          ))
        .get();

    final byKey = <String, DateTime?>{
      for (final row in rows) row.itemKey: row.completedAt,
    };

    return [
      for (final item in MonthlyChecklistStep.values)
        MonthlyChecklistCompletion(
          item: item,
          completedAt: byKey[item.key],
        ),
    ];
  }

  @override
  Future<void> setCompletion({
    required String shomitiId,
    required BillingMonth month,
    required MonthlyChecklistStep item,
    required bool isCompleted,
    required DateTime now,
  }) async {
    final companion = MonthlyChecklistItemsCompanion.insert(
      id: '${shomitiId}_${month.key}_${item.key}',
      shomitiId: shomitiId,
      billingMonthKey: month.key,
      itemKey: item.key,
      completedAt: Value(isCompleted ? now : null),
      updatedAt: now,
    );

    await db
        .into(db.monthlyChecklistItems)
        .insertOnConflictUpdate(companion);
  }
}

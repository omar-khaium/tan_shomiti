import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/due_month.dart';
import '../domain/entities/monthly_due.dart';
import '../domain/repositories/monthly_dues_repository.dart';
import '../domain/value_objects/billing_month.dart';

class DriftMonthlyDuesRepository implements MonthlyDuesRepository {
  DriftMonthlyDuesRepository(this._db);

  final AppDatabase _db;

  @override
  Future<DueMonth?> getDueMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final row =
        await (_db.select(_db.dueMonths)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..where((t) => t.monthKey.equals(month.key)))
            .getSingleOrNull();
    return row == null ? null : _mapDueMonth(row);
  }

  @override
  Future<void> upsertDueMonth(DueMonth dueMonth) async {
    await _db
        .into(_db.dueMonths)
        .insertOnConflictUpdate(
          DueMonthsCompanion.insert(
            shomitiId: dueMonth.shomitiId,
            monthKey: dueMonth.month.key,
            ruleSetVersionId: dueMonth.ruleSetVersionId,
            generatedAt: dueMonth.generatedAt,
          ),
        );
  }

  @override
  Future<void> replaceMonthlyDues({
    required String shomitiId,
    required BillingMonth month,
    required List<MonthlyDue> dues,
  }) async {
    await _db.transaction(() async {
      await (_db.delete(_db.monthlyDues)
            ..where((t) => t.shomitiId.equals(shomitiId))
            ..where((t) => t.monthKey.equals(month.key)))
          .go();

      if (dues.isEmpty) return;

      await _db.batch((batch) {
        batch.insertAll(
          _db.monthlyDues,
          dues.map(_toCompanion).toList(growable: false),
        );
      });
    });
  }

  @override
  Stream<List<MonthlyDue>> watchMonthlyDues({
    required String shomitiId,
    required BillingMonth month,
  }) {
    return (_db.select(_db.monthlyDues)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..where((t) => t.monthKey.equals(month.key))
          ..orderBy([(t) => OrderingTerm.asc(t.memberId)]))
        .watch()
        .map((rows) => rows.map(_mapMonthlyDue).toList(growable: false));
  }

  @override
  Future<List<MonthlyDue>> listMonthlyDues({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final rows =
        await (_db.select(_db.monthlyDues)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..where((t) => t.monthKey.equals(month.key))
              ..orderBy([(t) => OrderingTerm.asc(t.memberId)]))
            .get();
    return rows.map(_mapMonthlyDue).toList(growable: false);
  }

  static DueMonth _mapDueMonth(DueMonthRow row) {
    return DueMonth(
      shomitiId: row.shomitiId,
      month: BillingMonth.fromKey(row.monthKey),
      ruleSetVersionId: row.ruleSetVersionId,
      generatedAt: row.generatedAt,
    );
  }

  static MonthlyDue _mapMonthlyDue(MonthlyDueRow row) {
    return MonthlyDue(
      shomitiId: row.shomitiId,
      month: BillingMonth.fromKey(row.monthKey),
      memberId: row.memberId,
      shares: row.shares,
      shareValueBdt: row.shareValueBdt,
      dueAmountBdt: row.dueAmountBdt,
      createdAt: row.createdAt,
    );
  }

  static MonthlyDuesCompanion _toCompanion(MonthlyDue due) {
    return MonthlyDuesCompanion.insert(
      shomitiId: due.shomitiId,
      monthKey: due.month.key,
      memberId: due.memberId,
      shares: due.shares,
      shareValueBdt: due.shareValueBdt,
      dueAmountBdt: due.dueAmountBdt,
      createdAt: due.createdAt,
    );
  }
}


import 'dart:convert';

import '../../../core/data/local/app_database.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../domain/entities/monthly_statement.dart';
import '../domain/repositories/statements_repository.dart';

class DriftStatementsRepository implements StatementsRepository {
  DriftStatementsRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<MonthlyStatement?> watchStatement({
    required String shomitiId,
    required BillingMonth month,
  }) {
    final query = _db.select(_db.monthlyStatements)
      ..where((t) => t.shomitiId.equals(shomitiId))
      ..where((t) => t.monthKey.equals(month.key));

    return query.watchSingleOrNull().map(
          (row) => row == null ? null : _mapRow(row),
        );
  }

  @override
  Future<MonthlyStatement?> getStatement({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final row = await (_db.select(_db.monthlyStatements)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..where((t) => t.monthKey.equals(month.key)))
        .getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  @override
  Future<void> upsertStatement(MonthlyStatement statement) async {
    await _db.into(_db.monthlyStatements).insertOnConflictUpdate(
          MonthlyStatementsCompanion.insert(
            shomitiId: statement.shomitiId,
            monthKey: statement.month.key,
            ruleSetVersionId: statement.ruleSetVersionId,
            json: jsonEncode(statement.toJson()),
            generatedAt: statement.generatedAt,
          ),
        );
  }

  static MonthlyStatement _mapRow(MonthlyStatementRow row) {
    final json = jsonDecode(row.json);
    if (json is! Map<String, Object?>) {
      throw const FormatException('Invalid statement json');
    }
    return MonthlyStatement.fromJson(json);
  }
}

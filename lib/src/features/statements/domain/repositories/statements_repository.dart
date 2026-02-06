import '../../../contributions/domain/value_objects/billing_month.dart';
import '../entities/monthly_statement.dart';

abstract class StatementsRepository {
  Stream<MonthlyStatement?> watchStatement({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<MonthlyStatement?> getStatement({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<void> upsertStatement(MonthlyStatement statement);
}


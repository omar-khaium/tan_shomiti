import '../entities/due_month.dart';
import '../entities/monthly_due.dart';
import '../value_objects/billing_month.dart';

abstract class MonthlyDuesRepository {
  Future<DueMonth?> getDueMonth({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<void> upsertDueMonth(DueMonth dueMonth);

  Future<void> replaceMonthlyDues({
    required String shomitiId,
    required BillingMonth month,
    required List<MonthlyDue> dues,
  });

  Stream<List<MonthlyDue>> watchMonthlyDues({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<List<MonthlyDue>> listMonthlyDues({
    required String shomitiId,
    required BillingMonth month,
  });
}


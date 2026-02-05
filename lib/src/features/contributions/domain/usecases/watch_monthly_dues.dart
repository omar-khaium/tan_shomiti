import '../entities/monthly_due.dart';
import '../repositories/monthly_dues_repository.dart';
import '../value_objects/billing_month.dart';

class WatchMonthlyDues {
  const WatchMonthlyDues(this._repository);

  final MonthlyDuesRepository _repository;

  Stream<List<MonthlyDue>> call({
    required String shomitiId,
    required BillingMonth month,
  }) {
    return _repository.watchMonthlyDues(shomitiId: shomitiId, month: month);
  }
}


import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';

import '../entities/monthly_checklist_completion.dart';
import '../value_objects/monthly_checklist_step.dart';

abstract interface class MonthlyChecklistRepository {
  Future<List<MonthlyChecklistCompletion>> getMonth({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<void> setCompletion({
    required String shomitiId,
    required BillingMonth month,
    required MonthlyChecklistStep item,
    required bool isCompleted,
    required DateTime now,
  });
}

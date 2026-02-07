import 'package:flutter/foundation.dart';

import '../value_objects/monthly_checklist_step.dart';

@immutable
class MonthlyChecklistCompletion {
  const MonthlyChecklistCompletion({
    required this.item,
    required this.completedAt,
  });

  final MonthlyChecklistStep item;
  final DateTime? completedAt;

  bool get isCompleted => completedAt != null;
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../shomiti_setup/domain/entities/shomiti.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../data/drift_monthly_checklist_repository.dart';
import '../../domain/entities/monthly_checklist_completion.dart';
import '../../domain/repositories/monthly_checklist_repository.dart';
import '../../domain/usecases/set_monthly_checklist_item_completion.dart';

final monthlyChecklistRepositoryProvider = Provider<MonthlyChecklistRepository>(
  (ref) => DriftMonthlyChecklistRepository(ref.watch(appDatabaseProvider)),
);

final setMonthlyChecklistItemCompletionProvider =
    Provider<SetMonthlyChecklistItemCompletion>(
  (ref) => SetMonthlyChecklistItemCompletion(
    repository: ref.watch(monthlyChecklistRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  ),
);

final monthlyChecklistForMonthProvider =
    FutureProvider.autoDispose.family<List<MonthlyChecklistCompletion>, BillingMonth>(
  (ref, month) async {
    return ref.watch(monthlyChecklistRepositoryProvider).getMonth(
          shomitiId: activeShomitiId,
          month: month,
        );
  },
);

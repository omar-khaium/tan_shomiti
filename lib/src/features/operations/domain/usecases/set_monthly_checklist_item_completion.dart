import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';

import '../repositories/monthly_checklist_repository.dart';
import '../value_objects/monthly_checklist_step.dart';

class SetMonthlyChecklistItemCompletion {
  const SetMonthlyChecklistItemCompletion({
    required this.repository,
    required this.appendAuditEvent,
  });

  final MonthlyChecklistRepository repository;
  final AppendAuditEvent appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required BillingMonth month,
    required MonthlyChecklistStep item,
    required bool isCompleted,
    required DateTime now,
  }) async {
    await repository.setCompletion(
      shomitiId: shomitiId,
      month: month,
      item: item,
      isCompleted: isCompleted,
      now: now,
    );

    await appendAuditEvent(
      NewAuditEvent(
        action: isCompleted
            ? 'monthly_checklist_item_completed'
            : 'monthly_checklist_item_uncompleted',
        occurredAt: now,
        message: isCompleted
            ? 'Monthly checklist item completed.'
            : 'Monthly checklist item marked incomplete.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'billingMonthKey': month.key,
          'itemKey': item.key,
        }),
      ),
    );
  }
}

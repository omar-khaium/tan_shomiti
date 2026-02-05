import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/due_month.dart';
import '../entities/monthly_due.dart';
import '../repositories/monthly_dues_repository.dart';
import '../value_objects/billing_month.dart';

class GenerateMonthlyDues {
  GenerateMonthlyDues({
    required MonthlyDuesRepository monthlyDuesRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _monthlyDuesRepository = monthlyDuesRepository,
       _appendAuditEvent = appendAuditEvent;

  final MonthlyDuesRepository _monthlyDuesRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String ruleSetVersionId,
    required BillingMonth month,
    required int shareValueBdt,
    required Map<String, int> sharesByMemberId,
    DateTime? now,
  }) async {
    final ts = now ?? DateTime.now();

    final dueMonth = DueMonth(
      shomitiId: shomitiId,
      month: month,
      ruleSetVersionId: ruleSetVersionId,
      generatedAt: ts,
    );

    final dues = [
      for (final entry in sharesByMemberId.entries)
        MonthlyDue(
          shomitiId: shomitiId,
          month: month,
          memberId: entry.key,
          shares: entry.value,
          shareValueBdt: shareValueBdt,
          dueAmountBdt: entry.value * shareValueBdt,
          createdAt: ts,
        ),
    ];

    await _monthlyDuesRepository.upsertDueMonth(dueMonth);
    await _monthlyDuesRepository.replaceMonthlyDues(
      shomitiId: shomitiId,
      month: month,
      dues: dues,
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'monthly_dues_generated',
        occurredAt: ts,
        message: 'Generated monthly dues.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'ruleSetVersionId': ruleSetVersionId,
          'month': month.key,
          'shareValueBdt': shareValueBdt,
        }),
      ),
    );
  }
}


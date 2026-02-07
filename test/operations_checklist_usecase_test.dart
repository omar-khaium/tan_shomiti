import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/operations/domain/entities/monthly_checklist_completion.dart';
import 'package:tan_shomiti/src/features/operations/domain/repositories/monthly_checklist_repository.dart';
import 'package:tan_shomiti/src/features/operations/domain/usecases/set_monthly_checklist_item_completion.dart';
import 'package:tan_shomiti/src/features/operations/domain/value_objects/monthly_checklist_step.dart';

void main() {
  test('SetMonthlyChecklistItemCompletion writes repo + audit event', () async {
    final repo = _FakeChecklistRepository();
    final auditRepo = _FakeAuditRepository();
    final usecase = SetMonthlyChecklistItemCompletion(
      repository: repo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    final now = DateTime(2026, 2, 7, 12, 0);
    final month = BillingMonth(year: 2026, month: 2);

    await usecase(
      shomitiId: 'active',
      month: month,
      item: MonthlyChecklistStep.attendance,
      isCompleted: true,
      now: now,
    );

    expect(repo.lastSet?.shomitiId, 'active');
    expect(repo.lastSet?.month, month);
    expect(repo.lastSet?.item, MonthlyChecklistStep.attendance);
    expect(repo.lastSet?.isCompleted, true);
    expect(repo.lastSet?.now, now);

    expect(auditRepo.appended.length, 1);
    expect(auditRepo.appended.single.action, 'monthly_checklist_item_completed');
    expect(auditRepo.appended.single.occurredAt, now);
    expect(auditRepo.appended.single.metadataJson, isNotNull);
    expect(auditRepo.appended.single.metadataJson, contains(month.key));
    expect(auditRepo.appended.single.metadataJson, contains('attendance'));

    await usecase(
      shomitiId: 'active',
      month: month,
      item: MonthlyChecklistStep.attendance,
      isCompleted: false,
      now: now,
    );
    expect(auditRepo.appended.last.action, 'monthly_checklist_item_uncompleted');
  });
}

class _FakeChecklistRepository implements MonthlyChecklistRepository {
  _SetCall? lastSet;

  @override
  Future<List<MonthlyChecklistCompletion>> getMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    return [
      for (final step in MonthlyChecklistStep.values)
        MonthlyChecklistCompletion(item: step, completedAt: null),
    ];
  }

  @override
  Future<void> setCompletion({
    required String shomitiId,
    required BillingMonth month,
    required MonthlyChecklistStep item,
    required bool isCompleted,
    required DateTime now,
  }) async {
    lastSet = _SetCall(
      shomitiId: shomitiId,
      month: month,
      item: item,
      isCompleted: isCompleted,
      now: now,
    );
  }
}

class _SetCall {
  const _SetCall({
    required this.shomitiId,
    required this.month,
    required this.item,
    required this.isCompleted,
    required this.now,
  });

  final String shomitiId;
  final BillingMonth month;
  final MonthlyChecklistStep item;
  final bool isCompleted;
  final DateTime now;
}

class _FakeAuditRepository implements AuditRepository {
  final List<NewAuditEvent> appended = [];

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) => const Stream.empty();

  @override
  Future<void> append(NewAuditEvent event) async {
    appended.add(event);
  }
}


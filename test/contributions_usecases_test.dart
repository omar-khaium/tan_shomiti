import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/contributions/domain/entities/due_month.dart';
import 'package:tan_shomiti/src/features/contributions/domain/entities/monthly_due.dart';
import 'package:tan_shomiti/src/features/contributions/domain/repositories/monthly_dues_repository.dart';
import 'package:tan_shomiti/src/features/contributions/domain/usecases/generate_monthly_dues.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';

class _FakeAuditRepository implements AuditRepository {
  final List<NewAuditEvent> appended = [];

  @override
  Future<void> append(NewAuditEvent event) async {
    appended.add(event);
  }

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) async* {
    yield const [];
  }
}

class _FakeMonthlyDuesRepository implements MonthlyDuesRepository {
  DueMonth? dueMonth;
  final List<MonthlyDue> dues = [];

  @override
  Future<DueMonth?> getDueMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final dm = dueMonth;
    if (dm == null) return null;
    if (dm.shomitiId != shomitiId) return null;
    if (dm.month != month) return null;
    return dm;
  }

  @override
  Future<void> upsertDueMonth(DueMonth dueMonth) async {
    this.dueMonth = dueMonth;
  }

  @override
  Future<void> replaceMonthlyDues({
    required String shomitiId,
    required BillingMonth month,
    required List<MonthlyDue> dues,
  }) async {
    this.dues
      ..clear()
      ..addAll(dues);
  }

  @override
  Stream<List<MonthlyDue>> watchMonthlyDues({
    required String shomitiId,
    required BillingMonth month,
  }) async* {
    yield dues;
  }

  @override
  Future<List<MonthlyDue>> listMonthlyDues({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    return dues;
  }
}

void main() {
  test('BillingMonth next/previous work across years', () {
    const jan = BillingMonth(year: 2026, month: 1);
    const dec = BillingMonth(year: 2025, month: 12);

    expect(jan.previous(), dec);
    expect(dec.next(), jan);
    expect(BillingMonth.fromKey('2026-02').key, '2026-02');
  });

  test('GenerateMonthlyDues persists month + dues and appends audit', () async {
    final repo = _FakeMonthlyDuesRepository();
    final auditRepo = _FakeAuditRepository();
    final generate = GenerateMonthlyDues(
      monthlyDuesRepository: repo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
    );

    final now = DateTime.utc(2026, 2, 5);
    await generate(
      shomitiId: 's1',
      ruleSetVersionId: 'rsv_1',
      month: const BillingMonth(year: 2026, month: 2),
      shareValueBdt: 1000,
      sharesByMemberId: const {'m1': 2, 'm2': 1},
      now: now,
    );

    expect(repo.dueMonth, isNotNull);
    expect(repo.dueMonth!.month.key, '2026-02');
    expect(repo.dueMonth!.ruleSetVersionId, 'rsv_1');
    expect(repo.dues, hasLength(2));

    final total = repo.dues.fold<int>(0, (sum, d) => sum + d.dueAmountBdt);
    expect(total, 3000);

    expect(auditRepo.appended.single.action, 'monthly_dues_generated');
  });
}


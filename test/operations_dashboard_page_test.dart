import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/app/router/app_router.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/audit/presentation/providers/audit_providers.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/operations/domain/entities/monthly_checklist_completion.dart';
import 'package:tan_shomiti/src/features/operations/domain/repositories/monthly_checklist_repository.dart';
import 'package:tan_shomiti/src/features/operations/domain/value_objects/monthly_checklist_step.dart';
import 'package:tan_shomiti/src/features/operations/presentation/providers/operations_providers.dart';

import 'helpers/test_app.dart';

void main() {
  testWidgets('Dashboard checklist can toggle items (persisted)',
      (tester) async {
    final fakeRepo = _FakeMonthlyChecklistRepository();
    await tester.pumpWidget(
      createTestApp(
        overrides: [
          shomitiConfiguredProvider.overrideWith((ref) => true),
          monthlyChecklistRepositoryProvider.overrideWith((ref) => fakeRepo),
          appendAuditEventProvider.overrideWith(
            (ref) => AppendAuditEvent(_FakeAuditRepository()),
          ),
        ],
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('Monthly checklist (Rules §17)'), findsOneWidget);
    expect(find.text('0/6 completed'), findsOneWidget);

    await tester.tap(find.byKey(const Key('ops_check_attendance')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('1/6 completed'), findsOneWidget);

    await tester.tap(find.byKey(const Key('ops_month_next')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text('0/6 completed'), findsOneWidget);
  });
}

class _FakeAuditRepository implements AuditRepository {
  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) => const Stream.empty();

  @override
  Future<void> append(NewAuditEvent event) async {}
}

class _FakeMonthlyChecklistRepository implements MonthlyChecklistRepository {
  final Map<String, Map<String, DateTime?>> _states = {};

  String _stateKey(String shomitiId, BillingMonth month) => '$shomitiId|${month.key}';

  List<MonthlyChecklistCompletion> _snapshot(String key) {
    final state = _states[key] ?? const <String, DateTime?>{};
    return [
      for (final step in MonthlyChecklistStep.values)
        MonthlyChecklistCompletion(
          item: step,
          completedAt: state[step.key],
        ),
    ];
  }

  @override
  Future<List<MonthlyChecklistCompletion>> getMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    return _snapshot(_stateKey(shomitiId, month));
  }

  @override
  Future<void> setCompletion({
    required String shomitiId,
    required BillingMonth month,
    required MonthlyChecklistStep item,
    required bool isCompleted,
    required DateTime now,
  }) async {
    final key = _stateKey(shomitiId, month);
    final next = Map<String, DateTime?>.from(_states[key] ?? const {});
    next[item.key] = isCompleted ? now : null;
    _states[key] = next;
  }
}

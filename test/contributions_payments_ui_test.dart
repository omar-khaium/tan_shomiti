import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/contributions/presentation/contributions_page.dart';
import 'package:tan_shomiti/src/features/contributions/presentation/models/contributions_ui_state.dart';
import 'package:tan_shomiti/src/features/contributions/presentation/providers/contributions_providers.dart';
import 'package:tan_shomiti/src/features/payments/domain/entities/payment.dart';
import 'package:tan_shomiti/src/features/payments/domain/repositories/payments_repository.dart';
import 'package:tan_shomiti/src/features/payments/presentation/providers/payments_domain_providers.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/presentation/providers/audit_providers.dart';
import 'package:tan_shomiti/src/features/contributions/domain/entities/collection_resolution.dart';
import 'package:tan_shomiti/src/features/contributions/domain/repositories/monthly_collection_repository.dart';
import 'package:tan_shomiti/src/features/contributions/presentation/providers/contributions_domain_providers.dart';
import 'package:tan_shomiti/src/features/rules/domain/entities/rule_set_snapshot.dart';

void main() {
  testWidgets('Contributions page can record payment and show receipt', (
    tester,
  ) async {
    final month = BillingMonth.fromDate(DateTime.now());
    final paymentsRepo = _FakePaymentsRepository();
    final collectionRepo = _FakeMonthlyCollectionRepository();
    final ui = ContributionsUiState(
      shomitiId: 's1',
      month: month,
      paymentDeadline: '28th day of the month',
      gracePeriodDays: 3,
      lateFeeBdtPerDay: 50,
      missedPaymentPolicy: MissedPaymentPolicy.postponePayout,
      totalDueBdt: 2000,
      rows: const [
        MonthlyDueRow(
          memberId: 'm1',
          position: 1,
          displayName: 'Member 1',
          shares: 2,
          dueAmountBdt: 2000,
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          contributionsUiStateProvider.overrideWithValue(
            AsyncValue.data(ui),
          ),
          paymentsRepositoryProvider.overrideWithValue(paymentsRepo),
          auditRepositoryProvider.overrideWithValue(_FakeAuditRepository()),
          monthlyCollectionRepositoryProvider.overrideWithValue(collectionRepo),
        ],
        child: const MaterialApp(home: Scaffold(body: ContributionsPage())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Unpaid'), findsOneWidget);
    expect(find.text('Not eligible'), findsOneWidget);
    expect(find.text('Late fee: -'), findsOneWidget);
    await tester.tap(find.byKey(const Key('dues_record_payment_1')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('payment_reference')), 'trx-1');
    await tester.tap(find.byKey(const Key('payment_confirm')));
    await tester.pumpAndSettle();

    expect(find.text('Paid'), findsOneWidget);
    expect(find.text('Eligible'), findsOneWidget);
    expect(find.text('Late fee: 0 BDT'), findsOneWidget);
    expect(find.byKey(const Key('dues_view_receipt_1')), findsOneWidget);

    await tester.tap(find.byKey(const Key('dues_view_receipt_1')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('receipt_dialog')), findsOneWidget);
    expect(find.byKey(const Key('receipt_number')), findsOneWidget);
    expect(find.textContaining('RCT-'), findsOneWidget);
  });
}

class _FakePaymentsRepository implements PaymentsRepository {
  final Map<String, Payment> _byId = {};
  final StreamController<void> _updates = StreamController<void>.broadcast();

  @override
  Stream<List<Payment>> watchPaymentsForMonth({
    required String shomitiId,
    required BillingMonth month,
  }) async* {
    yield _currentForMonth(shomitiId, month);
    await for (final _ in _updates.stream) {
      yield _currentForMonth(shomitiId, month);
    }
  }

  @override
  Future<Payment?> getPayment({required String id}) async => _byId[id];

  @override
  Future<Payment?> getPaymentForMember({
    required String shomitiId,
    required BillingMonth month,
    required String memberId,
  }) async {
    final id = 'payment_${shomitiId}_${month.key}_$memberId';
    return _byId[id];
  }

  @override
  Future<void> upsertPayment(Payment payment) async {
    _byId[payment.id] = payment;
    _updates.add(null);
  }

  List<Payment> _currentForMonth(String shomitiId, BillingMonth month) {
    return _byId.values
        .where((p) => p.shomitiId == shomitiId && p.month == month)
        .toList(growable: false);
  }
}

class _FakeAuditRepository implements AuditRepository {
  @override
  Future<void> append(NewAuditEvent event) async {}

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) async* {
    yield const [];
  }
}

class _FakeMonthlyCollectionRepository implements MonthlyCollectionRepository {
  @override
  Future<CollectionResolution?> getResolution({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    return null;
  }

  @override
  Future<void> upsertResolution(CollectionResolution resolution) async {}

  @override
  Stream<CollectionResolution?> watchResolution({
    required String shomitiId,
    required BillingMonth month,
  }) {
    return const Stream<CollectionResolution?>.empty();
  }
}

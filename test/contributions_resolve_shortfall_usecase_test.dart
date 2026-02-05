import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/core/domain/money_bdt.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/contributions/domain/entities/collection_resolution.dart';
import 'package:tan_shomiti/src/features/contributions/domain/repositories/monthly_collection_repository.dart';
import 'package:tan_shomiti/src/features/contributions/domain/usecases/resolve_shortfall.dart';
import 'package:tan_shomiti/src/features/contributions/domain/value_objects/billing_month.dart';
import 'package:tan_shomiti/src/features/ledger/domain/entities/ledger_entry.dart';
import 'package:tan_shomiti/src/features/ledger/domain/repositories/ledger_repository.dart';
import 'package:tan_shomiti/src/features/ledger/domain/usecases/append_ledger_entry.dart';

class _FakeMonthlyCollectionRepository implements MonthlyCollectionRepository {
  CollectionResolution? resolution;

  @override
  Stream<CollectionResolution?> watchResolution({
    required String shomitiId,
    required BillingMonth month,
  }) async* {
    yield resolution;
  }

  @override
  Future<CollectionResolution?> getResolution({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    return resolution;
  }

  @override
  Future<void> upsertResolution(CollectionResolution resolution) async {
    this.resolution = resolution;
  }
}

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

class _FakeLedgerRepository implements LedgerRepository {
  final List<NewLedgerEntry> appended = [];

  @override
  Future<void> append(NewLedgerEntry entry) async {
    appended.add(entry);
  }

  @override
  Stream<List<LedgerEntry>> watchLatest({int limit = 100}) async* {
    yield const [];
  }
}

void main() {
  test('ResolveShortfall writes resolution + audit + ledger (reserve)', () async {
    final repo = _FakeMonthlyCollectionRepository();
    final auditRepo = _FakeAuditRepository();
    final ledgerRepo = _FakeLedgerRepository();

    final usecase = ResolveShortfall(
      repository: repo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
      appendLedgerEntry: AppendLedgerEntry(ledgerRepo),
    );

    const month = BillingMonth(year: 2026, month: 2);
    final now = DateTime.utc(2026, 2, 5);
    await usecase(
      shomitiId: 's1',
      month: month,
      method: CollectionResolutionMethod.reserve,
      amountBdt: 1000,
      now: now,
    );

    expect(repo.resolution, isNotNull);
    expect(repo.resolution!.amountBdt, 1000);
    expect(auditRepo.appended.single.action, 'reserve_cover_recorded');
    expect(ledgerRepo.appended.single.amount.minorUnits, MoneyBdt.fromTaka(1000).minorUnits);
    expect(ledgerRepo.appended.single.direction, LedgerDirection.outgoing);
  });

  test('ResolveShortfall is idempotent when already resolved', () async {
    final repo = _FakeMonthlyCollectionRepository()
      ..resolution = CollectionResolution(
        shomitiId: 's1',
        month: const BillingMonth(year: 2026, month: 2),
        method: CollectionResolutionMethod.reserve,
        amountBdt: 500,
        note: null,
        createdAt: DateTime.utc(2026, 2, 1),
      );
    final auditRepo = _FakeAuditRepository();
    final ledgerRepo = _FakeLedgerRepository();

    final usecase = ResolveShortfall(
      repository: repo,
      appendAuditEvent: AppendAuditEvent(auditRepo),
      appendLedgerEntry: AppendLedgerEntry(ledgerRepo),
    );

    await usecase(
      shomitiId: 's1',
      month: const BillingMonth(year: 2026, month: 2),
      method: CollectionResolutionMethod.reserve,
      amountBdt: 1000,
    );

    expect(auditRepo.appended, isEmpty);
    expect(ledgerRepo.appended, isEmpty);
    expect(repo.resolution!.amountBdt, 500);
  });
}


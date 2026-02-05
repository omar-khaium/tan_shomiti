import 'dart:convert';

import '../../../../core/domain/money_bdt.dart';
import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../ledger/domain/entities/ledger_entry.dart';
import '../../../ledger/domain/usecases/append_ledger_entry.dart';
import '../entities/collection_resolution.dart';
import '../repositories/monthly_collection_repository.dart';
import '../value_objects/billing_month.dart';

class ResolveShortfall {
  const ResolveShortfall({
    required MonthlyCollectionRepository repository,
    required AppendAuditEvent appendAuditEvent,
    required AppendLedgerEntry appendLedgerEntry,
  }) : _repository = repository,
       _appendAuditEvent = appendAuditEvent,
       _appendLedgerEntry = appendLedgerEntry;

  final MonthlyCollectionRepository _repository;
  final AppendAuditEvent _appendAuditEvent;
  final AppendLedgerEntry _appendLedgerEntry;

  Future<void> call({
    required String shomitiId,
    required BillingMonth month,
    required CollectionResolutionMethod method,
    required int amountBdt,
    String? note,
    DateTime? now,
  }) async {
    if (amountBdt <= 0) return;

    final existing = await _repository.getResolution(
      shomitiId: shomitiId,
      month: month,
    );
    if (existing != null) return;

    final ts = (now ?? DateTime.now()).toUtc();
    final resolution = CollectionResolution(
      shomitiId: shomitiId,
      month: month,
      method: method,
      amountBdt: amountBdt,
      note: note?.trim().isEmpty == true ? null : note?.trim(),
      createdAt: ts,
    );

    await _repository.upsertResolution(resolution);

    final action = switch (method) {
      CollectionResolutionMethod.reserve => 'reserve_cover_recorded',
      CollectionResolutionMethod.guarantor => 'guarantor_cover_recorded',
    };

    await _appendAuditEvent(
      NewAuditEvent(
        action: action,
        occurredAt: ts,
        message: 'Resolved shortfall.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'month': month.key,
          'method': method.name,
          'amountBdt': amountBdt,
        }),
      ),
    );

    // Bookkeeping: reflect the cover in the ledger.
    final ledgerDirection = switch (method) {
      CollectionResolutionMethod.reserve => LedgerDirection.outgoing,
      CollectionResolutionMethod.guarantor => LedgerDirection.incoming,
    };
    final category = switch (method) {
      CollectionResolutionMethod.reserve => 'reserve_cover',
      CollectionResolutionMethod.guarantor => 'guarantor_cover',
    };

    await _appendLedgerEntry(
      NewLedgerEntry(
        amount: MoneyBdt.fromTaka(amountBdt),
        direction: ledgerDirection,
        occurredAt: ts,
        category: category,
        note: 'Shortfall cover for ${month.key} (shomiti=$shomitiId)',
      ),
    );
  }
}


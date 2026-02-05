import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../contributions/domain/repositories/monthly_collection_repository.dart';
import '../../../contributions/domain/repositories/monthly_dues_repository.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../../../core/domain/money_bdt.dart';
import '../../../draw/domain/repositories/draw_records_repository.dart';
import '../../../ledger/domain/entities/ledger_entry.dart';
import '../../../ledger/domain/usecases/append_ledger_entry.dart';
import '../../../payments/domain/repositories/payments_repository.dart';
import '../../domain/entities/payout_approval_role.dart';
import '../../domain/entities/payout_record.dart';
import '../repositories/payout_repository.dart';
import 'payout_exceptions.dart';

class MarkPayoutPaid {
  MarkPayoutPaid({
    required PayoutRepository payoutRepository,
    required DrawRecordsRepository drawRecordsRepository,
    required MonthlyDuesRepository monthlyDuesRepository,
    required PaymentsRepository paymentsRepository,
    required MonthlyCollectionRepository monthlyCollectionRepository,
    required AppendLedgerEntry appendLedgerEntry,
    required AppendAuditEvent appendAuditEvent,
  }) : _payoutRepository = payoutRepository,
       _drawRecordsRepository = drawRecordsRepository,
       _monthlyDuesRepository = monthlyDuesRepository,
       _paymentsRepository = paymentsRepository,
       _monthlyCollectionRepository = monthlyCollectionRepository,
       _appendLedgerEntry = appendLedgerEntry,
       _appendAuditEvent = appendAuditEvent;

  final PayoutRepository _payoutRepository;
  final DrawRecordsRepository _drawRecordsRepository;
  final MonthlyDuesRepository _monthlyDuesRepository;
  final PaymentsRepository _paymentsRepository;
  final MonthlyCollectionRepository _monthlyCollectionRepository;
  final AppendLedgerEntry _appendLedgerEntry;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String ruleSetVersionId,
    required BillingMonth month,
    required String proofReference,
    String? markedPaidByMemberId,
    DateTime? now,
  }) async {
    final ts = now ?? DateTime.now();
    final proof = proofReference.trim();
    if (proof.isEmpty) {
      throw const PayoutValidationException('Proof reference is required.');
    }

    final existing = await _payoutRepository.getPayoutRecord(
      shomitiId: shomitiId,
      month: month,
    );
    if (existing?.isPaid ?? false) {
      throw const PayoutValidationException('Payout is already marked paid.');
    }

    final draw = await _drawRecordsRepository.getEffectiveForMonth(
      shomitiId: shomitiId,
      month: month,
    );
    if (draw == null) {
      throw const PayoutNotFoundException('Draw record not found for month.');
    }
    if (!draw.isFinalized) {
      throw const PayoutValidationException(
        'Draw must be finalized before payout.',
      );
    }

    final verification = await _payoutRepository.getCollectionVerification(
      shomitiId: shomitiId,
      month: month,
    );
    if (verification == null) {
      throw const PayoutValidationException(
        'Collection must be verified before payout.',
      );
    }

    final approvals = await _payoutRepository.listApprovals(
      shomitiId: shomitiId,
      month: month,
    );
    final hasTreasurer = approvals.any(
      (a) => a.role == PayoutApprovalRole.treasurer,
    );
    final hasAuditor = approvals.any((a) => a.role == PayoutApprovalRole.auditor);
    if (!hasTreasurer || !hasAuditor) {
      throw const PayoutValidationException(
        'Treasurer and auditor approvals are required.',
      );
    }

    final dues = await _monthlyDuesRepository.listMonthlyDues(
      shomitiId: shomitiId,
      month: month,
    );
    final totalDue = dues.fold<int>(0, (sum, d) => sum + d.dueAmountBdt);
    if (totalDue <= 0) {
      throw const PayoutValidationException(
        'Monthly dues are not generated yet.',
      );
    }

    final payments = await _paymentsRepository
        .watchPaymentsForMonth(shomitiId: shomitiId, month: month)
        .first;
    final collected = payments.fold<int>(0, (sum, p) => sum + p.amountBdt);
    final resolution = await _monthlyCollectionRepository.getResolution(
      shomitiId: shomitiId,
      month: month,
    );
    final covered = resolution?.amountBdt ?? 0;
    final effectiveCollected = collected + covered;
    final shortfall = (totalDue - effectiveCollected).clamp(0, totalDue);

    if (shortfall > 0) {
      throw const PayoutValidationException(
        'Collection is short. Payout must be postponed.',
      );
    }

    final payout = PayoutRecord(
      shomitiId: shomitiId,
      month: month,
      drawId: draw.id,
      ruleSetVersionId: ruleSetVersionId,
      winnerMemberId: draw.winnerMemberId,
      winnerShareIndex: draw.winnerShareIndex,
      amountBdt: totalDue,
      proofReference: proof,
      markedPaidByMemberId: markedPaidByMemberId,
      paidAt: ts,
      recordedAt: existing?.recordedAt ?? ts,
    );

    await _payoutRepository.upsertPayoutRecord(payout);

    await _appendLedgerEntry(
      NewLedgerEntry(
        amount: MoneyBdt.fromTaka(totalDue),
        direction: LedgerDirection.outgoing,
        category: 'payout',
        note: 'Payout for ${month.key}',
        occurredAt: ts,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'payout_marked_paid',
        occurredAt: ts,
        message: 'Recorded payout proof and marked paid.',
        actor: markedPaidByMemberId,
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'monthKey': month.key,
          'drawId': draw.id,
          'amountBdt': totalDue,
          'proofReference': proof,
          'collectedBdt': collected,
          'coveredBdt': covered,
          'shortfallBdt': shortfall,
        }),
      ),
    );
  }
}

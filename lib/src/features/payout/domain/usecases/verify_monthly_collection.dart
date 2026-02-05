import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../contributions/domain/repositories/monthly_collection_repository.dart';
import '../../../contributions/domain/repositories/monthly_dues_repository.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../../payments/domain/repositories/payments_repository.dart';
import '../../domain/entities/payout_collection_verification.dart';
import '../repositories/payout_repository.dart';
import 'payout_exceptions.dart';

class VerifyMonthlyCollection {
  VerifyMonthlyCollection({
    required PayoutRepository payoutRepository,
    required MonthlyDuesRepository monthlyDuesRepository,
    required PaymentsRepository paymentsRepository,
    required MonthlyCollectionRepository monthlyCollectionRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _payoutRepository = payoutRepository,
       _monthlyDuesRepository = monthlyDuesRepository,
       _paymentsRepository = paymentsRepository,
       _monthlyCollectionRepository = monthlyCollectionRepository,
       _appendAuditEvent = appendAuditEvent;

  final PayoutRepository _payoutRepository;
  final MonthlyDuesRepository _monthlyDuesRepository;
  final PaymentsRepository _paymentsRepository;
  final MonthlyCollectionRepository _monthlyCollectionRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String ruleSetVersionId,
    required BillingMonth month,
    required String verifiedByMemberId,
    String? note,
    DateTime? now,
  }) async {
    final ts = now ?? DateTime.now();

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

    final verification = PayoutCollectionVerification(
      shomitiId: shomitiId,
      month: month,
      ruleSetVersionId: ruleSetVersionId,
      verifiedByMemberId: verifiedByMemberId,
      verifiedAt: ts,
      note: _cleanOptional(note),
    );

    await _payoutRepository.upsertCollectionVerification(verification);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'payout_collection_verified',
        occurredAt: ts,
        message: 'Verified monthly collection for payout.',
        actor: verifiedByMemberId,
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'monthKey': month.key,
          'totalDueBdt': totalDue,
          'collectedBdt': collected,
          'coveredBdt': covered,
          'shortfallBdt': shortfall,
        }),
      ),
    );
  }

  String? _cleanOptional(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

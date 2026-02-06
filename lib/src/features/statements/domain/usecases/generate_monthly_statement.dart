import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../contributions/domain/repositories/monthly_collection_repository.dart';
import '../../../contributions/domain/repositories/monthly_dues_repository.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../../draw/domain/repositories/draw_records_repository.dart';
import '../../../draw/domain/repositories/draw_witness_repository.dart';
import '../../../members/domain/repositories/members_repository.dart';
import '../../../payments/domain/repositories/payments_repository.dart';
import '../../../payout/domain/repositories/payout_repository.dart';
import '../entities/monthly_statement.dart';
import '../repositories/statements_repository.dart';

class GenerateMonthlyStatement {
  GenerateMonthlyStatement({
    required StatementsRepository statementsRepository,
    required MonthlyDuesRepository monthlyDuesRepository,
    required PaymentsRepository paymentsRepository,
    required MonthlyCollectionRepository monthlyCollectionRepository,
    required DrawRecordsRepository drawRecordsRepository,
    required DrawWitnessRepository drawWitnessRepository,
    required MembersRepository membersRepository,
    required PayoutRepository payoutRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _statementsRepository = statementsRepository,
       _monthlyDuesRepository = monthlyDuesRepository,
       _paymentsRepository = paymentsRepository,
       _monthlyCollectionRepository = monthlyCollectionRepository,
       _drawRecordsRepository = drawRecordsRepository,
       _drawWitnessRepository = drawWitnessRepository,
       _membersRepository = membersRepository,
       _payoutRepository = payoutRepository,
       _appendAuditEvent = appendAuditEvent;

  final StatementsRepository _statementsRepository;
  final MonthlyDuesRepository _monthlyDuesRepository;
  final PaymentsRepository _paymentsRepository;
  final MonthlyCollectionRepository _monthlyCollectionRepository;
  final DrawRecordsRepository _drawRecordsRepository;
  final DrawWitnessRepository _drawWitnessRepository;
  final MembersRepository _membersRepository;
  final PayoutRepository _payoutRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<MonthlyStatement> call({
    required String shomitiId,
    required String ruleSetVersionId,
    required BillingMonth month,
    DateTime? now,
  }) async {
    final ts = now ?? DateTime.now();

    final payout = await _payoutRepository.getPayoutRecord(
      shomitiId: shomitiId,
      month: month,
    );
    if (payout == null || !payout.isPaid || payout.proofReference == null) {
      throw const FormatException('Payout is not marked paid for this month.');
    }

    final draw = await _drawRecordsRepository.getEffectiveForMonth(
      shomitiId: shomitiId,
      month: month,
    );
    if (draw == null || !draw.isFinalized) {
      throw const FormatException('Draw is not finalized for this month.');
    }

    final dues = await _monthlyDuesRepository.listMonthlyDues(
      shomitiId: shomitiId,
      month: month,
    );
    final totalDue = dues.fold<int>(0, (sum, d) => sum + d.dueAmountBdt);

    final payments = await _paymentsRepository
        .watchPaymentsForMonth(shomitiId: shomitiId, month: month)
        .first;
    final totalCollected = payments.fold<int>(0, (sum, p) => sum + p.amountBdt);

    final resolution = await _monthlyCollectionRepository.getResolution(
      shomitiId: shomitiId,
      month: month,
    );
    final covered = resolution?.amountBdt ?? 0;
    final shortfall =
        (totalDue - (totalCollected + covered)).clamp(0, totalDue);

    final members = await _membersRepository.listMembers(shomitiId: shomitiId);
    final memberNameById = {for (final m in members) m.id: m.fullName};
    final winnerLabel =
        '${memberNameById[draw.winnerMemberId] ?? draw.winnerMemberId} (share ${draw.winnerShareIndex})';

    final statement = MonthlyStatement(
      shomitiId: shomitiId,
      month: month,
      ruleSetVersionId: ruleSetVersionId,
      generatedAt: ts,
      totalDueBdt: totalDue,
      totalCollectedBdt: totalCollected,
      coveredBdt: covered,
      shortfallBdt: shortfall,
      winnerLabel: winnerLabel,
      drawProofReference: draw.proofReference,
      payoutProofReference: payout.proofReference!,
    );

    await _statementsRepository.upsertStatement(statement);

    final witnesses = await _drawWitnessRepository.listApprovals(drawId: draw.id);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'statement_generated',
        occurredAt: ts,
        message: 'Generated monthly statement snapshot.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'monthKey': month.key,
          'totalDueBdt': totalDue,
          'totalCollectedBdt': totalCollected,
          'coveredBdt': covered,
          'shortfallBdt': shortfall,
          'drawId': draw.id,
          'witnessCount': witnesses.length,
          'payoutProofReference': payout.proofReference,
        }),
      ),
    );

    return statement;
  }
}


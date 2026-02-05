import 'dart:convert';

import '../../../../core/domain/money_bdt.dart';
import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../ledger/domain/entities/ledger_entry.dart';
import '../../../ledger/domain/usecases/append_ledger_entry.dart';
import '../../../risk_controls/domain/repositories/risk_controls_repository.dart';
import '../../../rules/domain/entities/rule_set_snapshot.dart';
import '../entities/default_enforcement_step.dart';
import '../repositories/defaults_repository.dart';
import 'compute_defaults_dashboard.dart';
import 'defaults_exceptions.dart';

class RecordDefaultEnforcementStep {
  const RecordDefaultEnforcementStep({
    required DefaultsRepository defaultsRepository,
    required RiskControlsRepository riskControlsRepository,
    required AppendAuditEvent appendAuditEvent,
    required AppendLedgerEntry appendLedgerEntry,
    required ComputeDefaultsDashboard computeDefaultsDashboard,
  }) : _defaultsRepository = defaultsRepository,
       _riskControlsRepository = riskControlsRepository,
       _appendAuditEvent = appendAuditEvent,
       _appendLedgerEntry = appendLedgerEntry,
       _computeDefaultsDashboard = computeDefaultsDashboard;

  final DefaultsRepository _defaultsRepository;
  final RiskControlsRepository _riskControlsRepository;
  final AppendAuditEvent _appendAuditEvent;
  final AppendLedgerEntry _appendLedgerEntry;
  final ComputeDefaultsDashboard _computeDefaultsDashboard;

  Future<void> call({
    required String shomitiId,
    required String ruleSetVersionId,
    required RuleSetSnapshot ruleSet,
    required String memberId,
    required String episodeKey,
    required DefaultEnforcementStepType stepType,
    DateTime? now,
  }) async {
    final dashboard = await _computeDefaultsDashboard(
      shomitiId: shomitiId,
      ruleSet: ruleSet,
    );
    final summary = dashboard.where((s) => s.memberId == memberId).firstOrNull;
    if (summary == null) {
      throw const DefaultsValidationException('Member not found.');
    }

    if (summary.episodeKey == null || summary.episodeKey != episodeKey) {
      throw const DefaultsValidationException(
        'Default episode is no longer active.',
      );
    }

    if (summary.nextStep != stepType) {
      throw const DefaultsValidationException('Step is not allowed right now.');
    }

    final ts = (now ?? DateTime.now()).toUtc();

    int? amountBdt;
    if (stepType == DefaultEnforcementStepType.guarantorOrDeposit) {
      final guarantor = await _riskControlsRepository.getGuarantor(
        shomitiId: shomitiId,
        memberId: memberId,
      );
      final deposit = await _riskControlsRepository.getSecurityDeposit(
        shomitiId: shomitiId,
        memberId: memberId,
      );

      if (guarantor == null && deposit == null) {
        throw const DefaultsValidationException(
          'No guarantor or deposit is recorded for this member.',
        );
      }

      amountBdt = await _computeConsecutiveMissedAmountBdt(
        shomitiId: shomitiId,
        memberId: memberId,
      );
      if (amountBdt <= 0) {
        throw const DefaultsValidationException('No missed amount to cover.');
      }
    }

    await _defaultsRepository.addEnforcementStep(
      NewDefaultEnforcementStep(
        shomitiId: shomitiId,
        memberId: memberId,
        episodeKey: episodeKey,
        type: stepType,
        recordedAt: ts,
        ruleSetVersionId: ruleSetVersionId,
        amountBdt: amountBdt,
      ),
    );

    final action = switch (stepType) {
      DefaultEnforcementStepType.reminder => 'default_reminder_recorded',
      DefaultEnforcementStepType.notice => 'default_notice_recorded',
      DefaultEnforcementStepType.guarantorOrDeposit =>
        'default_guarantor_or_deposit_applied',
      DefaultEnforcementStepType.dispute => 'default_dispute_opened',
    };

    await _appendAuditEvent(
      NewAuditEvent(
        action: action,
        occurredAt: ts,
        message: 'Recorded default enforcement step.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': memberId,
          'episodeKey': episodeKey,
          'stepType': stepType.name,
          'amountBdt': amountBdt,
          'ruleSetVersionId': ruleSetVersionId,
        }),
      ),
    );

    if (stepType == DefaultEnforcementStepType.guarantorOrDeposit &&
        amountBdt != null) {
      await _appendLedgerEntry(
        NewLedgerEntry(
          amount: MoneyBdt.fromTaka(amountBdt),
          direction: LedgerDirection.incoming,
          occurredAt: ts,
          category: 'default_cover',
          note: 'Default cover applied (member=$memberId, episode=$episodeKey)',
        ),
      );
    }
  }

  Future<int> _computeConsecutiveMissedAmountBdt({
    required String shomitiId,
    required String memberId,
  }) async {
    final dues = await _defaultsRepository.listMemberDuePayments(
      shomitiId: shomitiId,
    );
    final rows = dues
        .where((r) => r.memberId == memberId)
        .toList(growable: false)
      ..sort((a, b) => a.monthKey.compareTo(b.monthKey));

    int consecutiveMissed = 0;
    for (final row in rows.reversed) {
      if (row.hasPayment) break;
      consecutiveMissed += 1;
    }
    if (consecutiveMissed == 0) return 0;

    final startIndex = rows.length - consecutiveMissed;
    final streak = rows.sublist(startIndex);

    return streak.where((r) => !r.hasPayment).fold<int>(
          0,
          (sum, r) => sum + r.dueAmountBdt,
        );
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

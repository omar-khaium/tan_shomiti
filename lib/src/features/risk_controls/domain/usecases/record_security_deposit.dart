import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/security_deposit.dart';
import '../repositories/risk_controls_repository.dart';
import 'risk_controls_exceptions.dart';

class RecordSecurityDeposit {
  RecordSecurityDeposit({
    required RiskControlsRepository riskControlsRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _riskControlsRepository = riskControlsRepository,
       _appendAuditEvent = appendAuditEvent;

  final RiskControlsRepository _riskControlsRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String memberId,
    required int amountBdt,
    required String heldBy,
    String? proofRef,
    DateTime? now,
  }) async {
    final cleanHeldBy = heldBy.trim();
    final cleanProof = _cleanOptional(proofRef);

    if (amountBdt <= 0) {
      throw const RiskControlValidationException('Amount must be positive.');
    }
    if (cleanHeldBy.isEmpty) {
      throw const RiskControlValidationException('Held by is required.');
    }

    final ts = now ?? DateTime.now();

    await _riskControlsRepository.upsertSecurityDeposit(
      SecurityDeposit(
        shomitiId: shomitiId,
        memberId: memberId,
        amountBdt: amountBdt,
        heldBy: cleanHeldBy,
        proofRef: cleanProof,
        recordedAt: ts,
        returnedAt: null,
        updatedAt: ts,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'security_deposit_recorded',
        occurredAt: ts,
        message: 'Recorded security deposit.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': memberId,
          'amountBdt': amountBdt,
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

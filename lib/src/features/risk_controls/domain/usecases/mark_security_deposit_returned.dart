import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../repositories/risk_controls_repository.dart';

class MarkSecurityDepositReturned {
  MarkSecurityDepositReturned({
    required RiskControlsRepository riskControlsRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _riskControlsRepository = riskControlsRepository,
       _appendAuditEvent = appendAuditEvent;

  final RiskControlsRepository _riskControlsRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String memberId,
    String? proofRef,
    DateTime? now,
  }) async {
    final ts = now ?? DateTime.now();
    final cleanProof = _cleanOptional(proofRef);

    await _riskControlsRepository.markSecurityDepositReturned(
      shomitiId: shomitiId,
      memberId: memberId,
      returnedAt: ts,
      proofRef: cleanProof,
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'security_deposit_returned',
        occurredAt: ts,
        message: 'Marked security deposit returned.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': memberId,
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

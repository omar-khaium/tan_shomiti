import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/guarantor.dart';
import '../repositories/risk_controls_repository.dart';
import 'risk_controls_exceptions.dart';

class RecordGuarantor {
  RecordGuarantor({
    required RiskControlsRepository riskControlsRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _riskControlsRepository = riskControlsRepository,
       _appendAuditEvent = appendAuditEvent;

  final RiskControlsRepository _riskControlsRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String memberId,
    required String name,
    required String phone,
    String? relationship,
    String? proofRef,
    DateTime? now,
  }) async {
    final cleanName = name.trim();
    final cleanPhone = phone.trim();
    final cleanRelationship = _cleanOptional(relationship);
    final cleanProof = _cleanOptional(proofRef);

    if (cleanName.isEmpty) {
      throw const RiskControlValidationException('Guarantor name is required.');
    }
    if (cleanPhone.isEmpty) {
      throw const RiskControlValidationException(
        'Guarantor phone is required.',
      );
    }

    final ts = now ?? DateTime.now();

    await _riskControlsRepository.upsertGuarantor(
      Guarantor(
        shomitiId: shomitiId,
        memberId: memberId,
        name: cleanName,
        phone: cleanPhone,
        relationship: cleanRelationship,
        proofRef: cleanProof,
        recordedAt: ts,
        updatedAt: ts,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'guarantor_recorded',
        occurredAt: ts,
        message: 'Recorded guarantor.',
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

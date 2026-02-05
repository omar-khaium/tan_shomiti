import 'dart:convert';
import 'dart:math';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../domain/entities/draw_record.dart';
import '../../domain/repositories/draw_records_repository.dart';
import '../../domain/usecases/draw_exceptions.dart';
import '../../domain/value_objects/draw_method.dart';

class RecordDrawResult {
  RecordDrawResult({
    required DrawRecordsRepository drawRecordsRepository,
    required AppendAuditEvent appendAuditEvent,
    Random? random,
  }) : _drawRecordsRepository = drawRecordsRepository,
       _appendAuditEvent = appendAuditEvent,
       _random = random ?? Random();

  final DrawRecordsRepository _drawRecordsRepository;
  final AppendAuditEvent _appendAuditEvent;
  final Random _random;

  Future<DrawRecord> call({
    required String shomitiId,
    required String ruleSetVersionId,
    required BillingMonth month,
    required DrawMethod method,
    required String proofReference,
    required String? notes,
    required String winnerMemberId,
    required int winnerShareIndex,
    required List<String> eligibleShareKeys,
    String? redoOfDrawId,
    required DateTime now,
  }) async {
    if (eligibleShareKeys.isEmpty) {
      throw const DrawRecordingException('No eligible entries for this month.');
    }
    if (proofReference.trim().isEmpty) {
      throw const DrawRecordingException('Proof reference is required.');
    }
    if (winnerShareIndex <= 0) {
      throw const DrawRecordingException('Winner share index must be >= 1.');
    }

    final winnerShareKey = '$winnerMemberId#$winnerShareIndex';
    if (!eligibleShareKeys.contains(winnerShareKey)) {
      throw const DrawRecordingException('Winner must be an eligible entry.');
    }

    final existing = await _drawRecordsRepository.getEffectiveForMonth(
      shomitiId: shomitiId,
      month: month,
    );
    if (existing != null) {
      throw const DrawRecordingException('A draw is already recorded for this month.');
    }

    if (redoOfDrawId != null) {
      final redoOf = await _drawRecordsRepository.getById(id: redoOfDrawId);
      if (redoOf == null) {
        throw const DrawRecordingException('Redo reference not found.');
      }
      if (!redoOf.isInvalidated) {
        throw const DrawRecordingException('Redo reference must be invalidated.');
      }
      if (redoOf.shomitiId != shomitiId || redoOf.month != month) {
        throw const DrawRecordingException('Redo reference must match month and shomiti.');
      }
    }

    final id = _newDrawId(month: month, now: now);
    final record = DrawRecord(
      id: id,
      shomitiId: shomitiId,
      month: month,
      ruleSetVersionId: ruleSetVersionId,
      method: method,
      proofReference: proofReference.trim(),
      notes: notes?.trim().isEmpty == true ? null : notes?.trim(),
      winnerMemberId: winnerMemberId,
      winnerShareIndex: winnerShareIndex,
      eligibleShareKeys: List.unmodifiable(eligibleShareKeys),
      redoOfDrawId: redoOfDrawId,
      invalidatedAt: null,
      invalidatedReason: null,
      finalizedAt: null,
      recordedAt: now,
    );

    await _drawRecordsRepository.upsert(record);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'draw_recorded',
        occurredAt: now,
        message: 'Draw recorded for ${month.key}.',
        metadataJson: jsonEncode({
          'monthKey': month.key,
          'method': method.value,
          'proofReference': record.proofReference,
          'winnerShareKey': record.winnerShareKey,
          'eligibleCount': eligibleShareKeys.length,
          'redoOfDrawId': redoOfDrawId,
        }),
      ),
    );

    return record;
  }

  String _newDrawId({required BillingMonth month, required DateTime now}) {
    final ts = now.microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36).padLeft(7, '0');
    return 'draw_${month.key}_${ts}_$rand';
  }
}

import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../repositories/statement_signoffs_repository.dart';

class DeleteStatementSignoff {
  const DeleteStatementSignoff({
    required StatementSignoffsRepository repository,
    required AppendAuditEvent appendAuditEvent,
  }) : _repository = repository,
       _appendAuditEvent = appendAuditEvent;

  final StatementSignoffsRepository _repository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required BillingMonth month,
    required String signerMemberId,
    required DateTime now,
  }) async {
    await _repository.delete(
      shomitiId: shomitiId,
      month: month,
      signerMemberId: signerMemberId,
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'statement_signoff_removed',
        occurredAt: now,
        message: 'Statement sign-off removed.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'monthKey': month.key,
          'signerMemberId': signerMemberId,
        }),
      ),
    );
  }
}


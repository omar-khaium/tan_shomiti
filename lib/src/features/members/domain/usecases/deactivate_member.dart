import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../repositories/members_repository.dart';
import 'member_write_exceptions.dart';

class DeactivateMember {
  DeactivateMember({
    required MembersRepository membersRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _membersRepository = membersRepository,
       _appendAuditEvent = appendAuditEvent;

  final MembersRepository _membersRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<void> call({
    required String shomitiId,
    required String memberId,
  }) async {
    final existing = await _membersRepository.getById(
      shomitiId: shomitiId,
      memberId: memberId,
    );
    if (existing == null) {
      throw MemberNotFoundException(memberId);
    }
    if (!existing.isActive) return;

    final now = DateTime.now();
    final updated = existing.copyWith(isActive: false, updatedAt: now);
    await _membersRepository.upsert(updated);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'deactivated_member',
        occurredAt: now,
        message: 'Deactivated member.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': memberId,
        }),
      ),
    );
  }
}

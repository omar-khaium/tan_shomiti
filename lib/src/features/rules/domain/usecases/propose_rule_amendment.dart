import 'dart:convert';
import 'dart:math';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../members/domain/repositories/members_repository.dart';
import '../../../shomiti_setup/domain/repositories/shomiti_repository.dart';
import '../entities/rule_amendment.dart';
import '../entities/rule_set_snapshot.dart';
import '../entities/rule_set_version.dart';
import '../repositories/rule_amendments_repository.dart';
import '../repositories/rules_repository.dart';
import 'rule_amendment_exceptions.dart';

class ProposeRuleAmendment {
  ProposeRuleAmendment({
    required ShomitiRepository shomitiRepository,
    required RulesRepository rulesRepository,
    required RuleAmendmentsRepository amendmentsRepository,
    required MembersRepository membersRepository,
    required AppendAuditEvent appendAuditEvent,
    Random? random,
  }) : _shomitiRepository = shomitiRepository,
       _rulesRepository = rulesRepository,
       _amendmentsRepository = amendmentsRepository,
       _membersRepository = membersRepository,
       _appendAuditEvent = appendAuditEvent,
       _random = random ?? Random();

  final ShomitiRepository _shomitiRepository;
  final RulesRepository _rulesRepository;
  final RuleAmendmentsRepository _amendmentsRepository;
  final MembersRepository _membersRepository;
  final AppendAuditEvent _appendAuditEvent;
  final Random _random;

  Future<String> call({
    required String shomitiId,
    required RuleSetSnapshot proposedSnapshot,
    required String note,
    required String? sharedReference,
    required DateTime now,
  }) async {
    final trimmedNote = note.trim();
    if (trimmedNote.isEmpty) {
      throw const RuleAmendmentException('Amendment note is required.');
    }

    final shomiti = await _shomitiRepository.getActive();
    if (shomiti == null) {
      throw const RuleAmendmentException('No active Shomiti found.');
    }
    if (shomiti.id != shomitiId) {
      throw const RuleAmendmentException('Invalid Shomiti context.');
    }

    final pending =
        await _amendmentsRepository.watchPending(shomitiId: shomitiId).first;
    if (pending != null) {
      throw const RuleAmendmentException(
        'A rule change is already pending consent.',
      );
    }

    final activeMemberCount = (await _membersRepository.listMembers(
      shomitiId: shomitiId,
    ))
        .where((m) => m.isActive)
        .length;
    if (activeMemberCount <= 0) {
      throw const RuleAmendmentException('No active members found.');
    }

    final proposedRuleSetVersionId = _newRuleSetVersionId(now);
    await _rulesRepository.upsert(
      RuleSetVersion(
        id: proposedRuleSetVersionId,
        createdAt: now,
        snapshot: proposedSnapshot,
      ),
    );

    final amendmentId = _newRuleAmendmentId(now);
    await _amendmentsRepository.upsert(
      RuleAmendment(
        id: amendmentId,
        shomitiId: shomitiId,
        baseRuleSetVersionId: shomiti.activeRuleSetVersionId,
        proposedRuleSetVersionId: proposedRuleSetVersionId,
        status: RuleAmendmentStatus.pendingConsent,
        note: trimmedNote,
        sharedReference: sharedReference?.trim().isEmpty == true
            ? null
            : sharedReference?.trim(),
        createdAt: now,
        appliedAt: null,
      ),
    );

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'rule_change_proposed',
        occurredAt: now,
        message: 'Rule change proposed.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'baseRuleSetVersionId': shomiti.activeRuleSetVersionId,
          'proposedRuleSetVersionId': proposedRuleSetVersionId,
          'amendmentId': amendmentId,
        }),
      ),
    );

    return amendmentId;
  }

  String _newRuleSetVersionId(DateTime now) {
    final ts = now.microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36).padLeft(7, '0');
    return 'rsv_${ts}_$rand';
  }

  String _newRuleAmendmentId(DateTime now) {
    final ts = now.microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36).padLeft(7, '0');
    return 'ram_${ts}_$rand';
  }
}


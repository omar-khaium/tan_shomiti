import 'dart:convert';
import 'dart:math';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../../../rules/domain/entities/rule_set_snapshot.dart';
import '../../../rules/domain/entities/rule_set_version.dart';
import '../../../rules/domain/repositories/rules_repository.dart';
import '../entities/shomiti.dart';
import '../repositories/shomiti_repository.dart';

class CreateShomitiValidationException implements Exception {
  const CreateShomitiValidationException(this.message);

  final String message;

  @override
  String toString() => 'CreateShomitiValidationException($message)';
}

class CreateShomiti {
  CreateShomiti({
    required ShomitiRepository shomitiRepository,
    required RulesRepository rulesRepository,
    required AppendAuditEvent appendAuditEvent,
    Random? random,
  })  : _shomitiRepository = shomitiRepository,
        _rulesRepository = rulesRepository,
        _appendAuditEvent = appendAuditEvent,
        _random = random ?? Random.secure();

  final ShomitiRepository _shomitiRepository;
  final RulesRepository _rulesRepository;
  final AppendAuditEvent _appendAuditEvent;
  final Random _random;

  Future<Shomiti> call(RuleSetSnapshot snapshot) async {
    _validate(snapshot);

    final now = DateTime.now();
    final ruleSetVersionId = _newRuleSetVersionId(now);

    final ruleSetVersion = RuleSetVersion(
      id: ruleSetVersionId,
      createdAt: now,
      snapshot: snapshot,
    );

    await _rulesRepository.upsert(ruleSetVersion);

    final shomiti = Shomiti(
      id: activeShomitiId,
      name: snapshot.shomitiName,
      startDate: snapshot.startDate,
      createdAt: now,
      activeRuleSetVersionId: ruleSetVersionId,
    );

    await _shomitiRepository.upsert(shomiti);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'created_shomiti',
        occurredAt: now,
        message: 'Created Shomiti and initial rules snapshot.',
        metadataJson: jsonEncode({
          'shomitiId': shomiti.id,
          'ruleSetVersionId': ruleSetVersionId,
        }),
      ),
    );

    return shomiti;
  }

  void _validate(RuleSetSnapshot snapshot) {
    if (snapshot.shomitiName.trim().isEmpty) {
      throw const CreateShomitiValidationException('Shomiti name is required.');
    }
    if (snapshot.memberCount <= 0) {
      throw const CreateShomitiValidationException('Member count must be > 0.');
    }
    if (snapshot.shareValueBdt <= 0) {
      throw const CreateShomitiValidationException('Share value must be > 0.');
    }
    if (snapshot.maxSharesPerPerson <= 0) {
      throw const CreateShomitiValidationException(
        'Max shares per person must be > 0.',
      );
    }
    if (snapshot.cycleLengthMonths <= 0) {
      throw const CreateShomitiValidationException(
        'Cycle length must be > 0.',
      );
    }
    if (snapshot.meetingSchedule.trim().isEmpty) {
      throw const CreateShomitiValidationException(
        'Meeting schedule is required.',
      );
    }
    if (snapshot.paymentDeadline.trim().isEmpty) {
      throw const CreateShomitiValidationException(
        'Payment deadline is required.',
      );
    }
    final grace = snapshot.gracePeriodDays;
    if (grace != null && grace < 0) {
      throw const CreateShomitiValidationException(
        'Grace period cannot be negative.',
      );
    }
    final lateFee = snapshot.lateFeeBdtPerDay;
    if (lateFee != null && lateFee <= 0) {
      throw const CreateShomitiValidationException(
        'Late fee must be > 0 when provided.',
      );
    }
    if (snapshot.feesEnabled) {
      final amount = snapshot.feeAmountBdt;
      if (amount == null || amount <= 0) {
        throw const CreateShomitiValidationException(
          'Fee amount must be > 0 when fees are enabled.',
        );
      }
    }
    if (!snapshot.ruleChangeAfterStartRequiresUnanimous) {
      throw const CreateShomitiValidationException(
        'After start, rule changes require unanimous consent.',
      );
    }
  }

  String _newRuleSetVersionId(DateTime now) {
    final ts = now.microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36).padLeft(7, '0');
    return 'rsv_${ts}_$rand';
  }
}


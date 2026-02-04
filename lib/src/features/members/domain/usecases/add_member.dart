import 'dart:convert';
import 'dart:math';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/member.dart';
import '../entities/member_profile_input.dart';
import '../policies/member_identity_normalizer.dart';
import '../repositories/members_repository.dart';
import 'member_write_exceptions.dart';

class AddMember {
  AddMember({
    required MembersRepository membersRepository,
    required AppendAuditEvent appendAuditEvent,
    Random? random,
  }) : _membersRepository = membersRepository,
       _appendAuditEvent = appendAuditEvent,
       _random = random ?? Random.secure();

  final MembersRepository _membersRepository;
  final AppendAuditEvent _appendAuditEvent;
  final Random _random;

  Future<Member> call({
    required String shomitiId,
    required MemberProfileInput profile,
    required bool isJoiningClosed,
  }) async {
    if (isJoiningClosed) {
      throw const MemberJoiningClosedException();
    }

    final sanitized = _sanitize(profile);
    _validate(sanitized);

    final existing = await _membersRepository.listMembers(shomitiId: shomitiId);
    _assertNoDuplicates(existing, sanitized);

    final now = DateTime.now();
    final nextPosition = existing.isEmpty
        ? 1
        : existing.map((m) => m.position).reduce(max) + 1;

    final member = Member(
      id: _newMemberId(now),
      shomitiId: shomitiId,
      position: nextPosition,
      fullName: sanitized.fullName,
      phone: sanitized.phone,
      addressOrWorkplace: sanitized.addressOrWorkplace,
      emergencyContactName: sanitized.emergencyContactName,
      emergencyContactPhone: sanitized.emergencyContactPhone,
      nidOrPassport: sanitized.nidOrPassport,
      notes: sanitized.notes,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );

    await _membersRepository.upsert(member);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'added_member',
        occurredAt: now,
        message: 'Added member profile.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': member.id,
          'position': member.position,
        }),
      ),
    );

    return member;
  }

  MemberProfileInput _sanitize(MemberProfileInput profile) {
    String cleanRequired(String value) => value.trim();
    String? cleanOptional(String? value) {
      if (value == null) return null;
      final trimmed = value.trim();
      return trimmed.isEmpty ? null : trimmed;
    }

    return MemberProfileInput(
      fullName: cleanRequired(profile.fullName),
      phone: cleanRequired(profile.phone),
      addressOrWorkplace: cleanRequired(profile.addressOrWorkplace),
      emergencyContactName: cleanRequired(profile.emergencyContactName),
      emergencyContactPhone: cleanRequired(profile.emergencyContactPhone),
      nidOrPassport: cleanOptional(profile.nidOrPassport),
      notes: cleanOptional(profile.notes),
    );
  }

  void _validate(MemberProfileInput profile) {
    if (profile.fullName.isEmpty) {
      throw const MemberValidationException('Full name is required.');
    }
    if (profile.phone.isEmpty) {
      throw const MemberValidationException('Phone is required.');
    }
    if (profile.addressOrWorkplace.isEmpty) {
      throw const MemberValidationException('Address/workplace is required.');
    }
    if (profile.emergencyContactName.isEmpty) {
      throw const MemberValidationException(
        'Emergency contact name is required.',
      );
    }
    if (profile.emergencyContactPhone.isEmpty) {
      throw const MemberValidationException(
        'Emergency contact phone is required.',
      );
    }
  }

  void _assertNoDuplicates(List<Member> existing, MemberProfileInput profile) {
    final phoneKey = MemberIdentityNormalizer.normalizePhone(profile.phone);
    final nidKey = MemberIdentityNormalizer.normalizeNidOrPassport(
      profile.nidOrPassport,
    );

    for (final member in existing) {
      if (phoneKey != null) {
        final existingPhone = MemberIdentityNormalizer.normalizePhone(
          member.phone,
        );
        if (existingPhone != null && existingPhone == phoneKey) {
          throw MemberDuplicateException(
            field: MemberDuplicateField.phone,
            conflictingMemberId: member.id,
          );
        }
      }

      if (nidKey != null) {
        final existingNid = MemberIdentityNormalizer.normalizeNidOrPassport(
          member.nidOrPassport,
        );
        if (existingNid != null && existingNid == nidKey) {
          throw MemberDuplicateException(
            field: MemberDuplicateField.nidOrPassport,
            conflictingMemberId: member.id,
          );
        }
      }
    }
  }

  String _newMemberId(DateTime now) {
    final ts = now.microsecondsSinceEpoch.toRadixString(36);
    final rand = _random.nextInt(1 << 32).toRadixString(36).padLeft(7, '0');
    return 'm_${ts}_$rand';
  }
}

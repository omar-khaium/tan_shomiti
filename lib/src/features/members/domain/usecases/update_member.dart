import 'dart:convert';

import '../../../audit/domain/entities/audit_event.dart';
import '../../../audit/domain/usecases/append_audit_event.dart';
import '../entities/member.dart';
import '../entities/member_profile_input.dart';
import '../policies/member_identity_normalizer.dart';
import '../repositories/members_repository.dart';
import 'member_write_exceptions.dart';

class UpdateMember {
  UpdateMember({
    required MembersRepository membersRepository,
    required AppendAuditEvent appendAuditEvent,
  }) : _membersRepository = membersRepository,
       _appendAuditEvent = appendAuditEvent;

  final MembersRepository _membersRepository;
  final AppendAuditEvent _appendAuditEvent;

  Future<Member> call({
    required String shomitiId,
    required String memberId,
    required MemberProfileInput profile,
  }) async {
    final existing = await _membersRepository.getById(
      shomitiId: shomitiId,
      memberId: memberId,
    );
    if (existing == null) {
      throw MemberNotFoundException(memberId);
    }

    final sanitized = _sanitize(profile);
    _validate(sanitized);

    final all = await _membersRepository.listMembers(shomitiId: shomitiId);
    _assertNoDuplicates(all, memberId: memberId, profile: sanitized);

    final now = DateTime.now();
    final updated = existing.copyWith(
      fullName: sanitized.fullName,
      phone: sanitized.phone,
      addressOrWorkplace: sanitized.addressOrWorkplace,
      emergencyContactName: sanitized.emergencyContactName,
      emergencyContactPhone: sanitized.emergencyContactPhone,
      nidOrPassport: sanitized.nidOrPassport,
      notes: sanitized.notes,
      updatedAt: now,
    );

    await _membersRepository.upsert(updated);

    await _appendAuditEvent(
      NewAuditEvent(
        action: 'updated_member',
        occurredAt: now,
        message: 'Updated member profile.',
        metadataJson: jsonEncode({
          'shomitiId': shomitiId,
          'memberId': memberId,
        }),
      ),
    );

    return updated;
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

  void _assertNoDuplicates(
    List<Member> existing, {
    required String memberId,
    required MemberProfileInput profile,
  }) {
    final phoneKey = MemberIdentityNormalizer.normalizePhone(profile.phone);
    final nidKey = MemberIdentityNormalizer.normalizeNidOrPassport(
      profile.nidOrPassport,
    );

    for (final member in existing) {
      if (member.id == memberId) continue;

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
}

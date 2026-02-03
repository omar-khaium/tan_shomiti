import 'package:flutter_test/flutter_test.dart';
import 'package:tan_shomiti/src/features/audit/domain/entities/audit_event.dart';
import 'package:tan_shomiti/src/features/audit/domain/repositories/audit_repository.dart';
import 'package:tan_shomiti/src/features/audit/domain/usecases/append_audit_event.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/governance_role.dart';
import 'package:tan_shomiti/src/features/members/domain/entities/member_consent.dart';
import 'package:tan_shomiti/src/features/members/domain/policies/governance_readiness.dart';
import 'package:tan_shomiti/src/features/members/domain/repositories/member_consents_repository.dart';
import 'package:tan_shomiti/src/features/members/domain/usecases/record_member_consent.dart';

void main() {
  test('GovernanceReadiness requires Treasurer and Auditor', () {
    final readiness = GovernanceReadiness(requiredMemberCount: 3);

    final isReady = readiness.isReady(
      roleAssignments: const {
        GovernanceRole.coordinator: null,
        GovernanceRole.treasurer: null,
        GovernanceRole.auditor: 'm_auditor',
      },
      signedMemberIds: const {'m1', 'm2', 'm3'},
    );

    expect(isReady, isFalse);
  });

  test('GovernanceReadiness requires member sign-off count', () {
    final readiness = GovernanceReadiness(requiredMemberCount: 3);

    final isReady = readiness.isReady(
      roleAssignments: const {
        GovernanceRole.coordinator: null,
        GovernanceRole.treasurer: 'm_treasurer',
        GovernanceRole.auditor: 'm_auditor',
      },
      signedMemberIds: const {'m1', 'm2'},
    );

    expect(isReady, isFalse);
  });

  test('RecordMemberConsent stores proof reference and timestamp', () async {
    final consentsRepository = _FakeMemberConsentsRepository();
    final auditRepository = _FakeAuditRepository();

    final usecase = RecordMemberConsent(
      consentsRepository: consentsRepository,
      appendAuditEvent: AppendAuditEvent(auditRepository),
    );

    final start = DateTime.now();
    await usecase(
      shomitiId: 's1',
      memberId: 'm1',
      ruleSetVersionId: 'rsv1',
      proofType: ConsentProofType.chatReference,
      proofReference: 'chat://message/123',
    );
    final end = DateTime.now();

    final stored = consentsRepository.lastUpserted;
    expect(stored, isNotNull);
    expect(stored!.shomitiId, 's1');
    expect(stored.memberId, 'm1');
    expect(stored.ruleSetVersionId, 'rsv1');
    expect(stored.proofType, ConsentProofType.chatReference);
    expect(stored.proofReference, 'chat://message/123');
    expect(stored.signedAt.isAfter(start.subtract(const Duration(milliseconds: 1))), isTrue);
    expect(stored.signedAt.isBefore(end.add(const Duration(seconds: 1))), isTrue);

    expect(auditRepository.appended, hasLength(1));
    expect(auditRepository.appended.single.action, 'recorded_member_consent');
  });
}

class _FakeMemberConsentsRepository implements MemberConsentsRepository {
  MemberConsent? lastUpserted;

  @override
  Future<void> upsert(MemberConsent consent) async {
    lastUpserted = consent;
  }

  @override
  Stream<List<MemberConsent>> watchConsents({
    required String shomitiId,
    required String ruleSetVersionId,
  }) {
    return const Stream.empty();
  }
}

class _FakeAuditRepository implements AuditRepository {
  final List<NewAuditEvent> appended = [];

  @override
  Future<void> append(NewAuditEvent event) async {
    appended.add(event);
  }

  @override
  Stream<List<AuditEvent>> watchLatest({int limit = 50}) {
    return const Stream.empty();
  }
}


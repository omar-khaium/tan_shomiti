import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../members/presentation/governance/providers/governance_providers.dart';
import '../../../members/presentation/providers/members_providers.dart';
import '../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import '../../data/drift_rule_amendments_repository.dart';
import '../../domain/entities/rule_amendment.dart';
import '../../../members/domain/entities/member_consent.dart';
import '../../domain/repositories/rule_amendments_repository.dart';
import '../../domain/usecases/apply_rule_amendment.dart';
import '../../domain/usecases/propose_rule_amendment.dart';
import '../../domain/usecases/record_rule_amendment_consent.dart';
import 'rules_providers.dart';

final ruleAmendmentsRepositoryProvider = Provider<RuleAmendmentsRepository>((ref) {
  return DriftRuleAmendmentsRepository(ref.watch(appDatabaseProvider));
});

final proposeRuleAmendmentProvider = Provider<ProposeRuleAmendment>((ref) {
  return ProposeRuleAmendment(
    shomitiRepository: ref.watch(shomitiRepositoryProvider),
    rulesRepository: ref.watch(rulesRepositoryProvider),
    amendmentsRepository: ref.watch(ruleAmendmentsRepositoryProvider),
    membersRepository: ref.watch(membersRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final applyRuleAmendmentProvider = Provider<ApplyRuleAmendment>((ref) {
  return ApplyRuleAmendment(
    shomitiRepository: ref.watch(shomitiRepositoryProvider),
    amendmentsRepository: ref.watch(ruleAmendmentsRepositoryProvider),
    membersRepository: ref.watch(membersRepositoryProvider),
    memberConsentsRepository: ref.watch(memberConsentsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final recordRuleAmendmentConsentProvider = Provider<RecordRuleAmendmentConsent>((
  ref,
) {
  return RecordRuleAmendmentConsent(
    consentsRepository: ref.watch(memberConsentsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final ruleAmendmentsProvider =
    StreamProvider.autoDispose<List<RuleAmendment>>((ref) async* {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) {
    yield const [];
    return;
  }

  yield* ref
      .watch(ruleAmendmentsRepositoryProvider)
      .watchAll(shomitiId: shomiti.id);
});

final pendingRuleAmendmentProvider =
    StreamProvider.autoDispose<RuleAmendment?>((ref) async* {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) {
    yield null;
    return;
  }

  yield* ref
      .watch(ruleAmendmentsRepositoryProvider)
      .watchPending(shomitiId: shomiti.id);
});

final ruleAmendmentByIdProvider =
    FutureProvider.autoDispose.family<RuleAmendment?, String>((ref, id) async {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) return null;

  return ref.watch(ruleAmendmentsRepositoryProvider).getById(
        shomitiId: shomiti.id,
        amendmentId: id,
      );
});

final ruleAmendmentConsentsProvider =
    StreamProvider.autoDispose.family<List<MemberConsent>, String>((
  ref,
  ruleSetVersionId,
) async* {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) {
    yield const [];
    return;
  }

  yield* ref
      .watch(memberConsentsRepositoryProvider)
      .watchConsents(
        shomitiId: shomiti.id,
        ruleSetVersionId: ruleSetVersionId,
      );
});

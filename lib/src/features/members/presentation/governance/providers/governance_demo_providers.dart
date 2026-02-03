import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../rules/domain/entities/rule_set_version.dart';
import '../../../../rules/presentation/providers/rules_providers.dart';
import '../../../../shomiti_setup/domain/entities/shomiti.dart';
import '../../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';

final governanceDemoControllerProvider = AutoDisposeAsyncNotifierProvider<
    GovernanceDemoController,
    GovernanceDemoState?>(
  GovernanceDemoController.new,
);

class GovernanceDemoController
    extends AutoDisposeAsyncNotifier<GovernanceDemoState?> {
  @override
  FutureOr<GovernanceDemoState?> build() async {
    final shomiti = await ref.watch(activeShomitiProvider.future);
    if (shomiti == null) return null;

    final ruleSetVersion =
        await _loadRuleSetVersion(shomiti: shomiti, ref: ref);
    if (ruleSetVersion == null) return null;

    final members = List<GovernanceDemoMember>.generate(
      ruleSetVersion.snapshot.memberCount,
      (index) => GovernanceDemoMember(
        name: 'Member ${index + 1}',
        consent: const GovernanceMemberConsent.pending(),
      ),
    );

    return GovernanceDemoState(
      ruleSetVersionId: ruleSetVersion.id,
      members: members,
      roleAssignments: const {
        GovernanceRole.coordinator: null,
        GovernanceRole.treasurer: null,
        GovernanceRole.auditor: null,
      },
    );
  }

  Future<RuleSetVersion?> _loadRuleSetVersion({
    required Shomiti shomiti,
    required Ref ref,
  }) async {
    return ref
        .watch(rulesRepositoryProvider)
        .getById(shomiti.activeRuleSetVersionId);
  }

  void assignRole({
    required GovernanceRole role,
    required int? memberIndex,
  }) {
    final current = state.valueOrNull;
    if (current == null) return;

    final updated = Map<GovernanceRole, int?>.from(current.roleAssignments);
    updated[role] = memberIndex;
    state = AsyncData(current.copyWith(roleAssignments: updated));
  }

  void recordConsent({
    required int memberIndex,
    required ConsentProofType proofType,
    required String proofReference,
    DateTime? signedAt,
  }) {
    final current = state.valueOrNull;
    if (current == null) return;
    if (memberIndex < 0 || memberIndex >= current.members.length) return;

    final members = [...current.members];
    members[memberIndex] = members[memberIndex].copyWith(
      consent: GovernanceMemberConsent.signed(
        proofType: proofType,
        proofReference: proofReference,
        signedAt: signedAt ?? DateTime.now(),
      ),
    );

    state = AsyncData(current.copyWith(members: members));
  }
}

enum GovernanceRole {
  coordinator,
  treasurer,
  auditor,
}

enum ConsentProofType {
  signature,
  otp,
  chatReference,
}

@immutable
class GovernanceDemoState {
  const GovernanceDemoState({
    required this.ruleSetVersionId,
    required this.members,
    required this.roleAssignments,
  });

  final String ruleSetVersionId;
  final List<GovernanceDemoMember> members;
  final Map<GovernanceRole, int?> roleAssignments;

  int get signedCount =>
      members.where((member) => member.consent.isSigned).length;

  bool get hasTreasurer => roleAssignments[GovernanceRole.treasurer] != null;
  bool get hasAuditor => roleAssignments[GovernanceRole.auditor] != null;

  bool get isGovernanceReady =>
      hasTreasurer && hasAuditor && signedCount >= members.length;

  GovernanceDemoState copyWith({
    List<GovernanceDemoMember>? members,
    Map<GovernanceRole, int?>? roleAssignments,
  }) {
    return GovernanceDemoState(
      ruleSetVersionId: ruleSetVersionId,
      members: members ?? this.members,
      roleAssignments: roleAssignments ?? this.roleAssignments,
    );
  }
}

@immutable
class GovernanceDemoMember {
  const GovernanceDemoMember({
    required this.name,
    required this.consent,
  });

  final String name;
  final GovernanceMemberConsent consent;

  GovernanceDemoMember copyWith({
    String? name,
    GovernanceMemberConsent? consent,
  }) {
    return GovernanceDemoMember(
      name: name ?? this.name,
      consent: consent ?? this.consent,
    );
  }
}

@immutable
class GovernanceMemberConsent {
  const GovernanceMemberConsent._({
    required this.isSigned,
    this.proofType,
    this.proofReference,
    this.signedAt,
  });

  const GovernanceMemberConsent.pending() : this._(isSigned: false);

  const GovernanceMemberConsent.signed({
    required ConsentProofType proofType,
    required String proofReference,
    required DateTime signedAt,
  }) : this._(
          isSigned: true,
          proofType: proofType,
          proofReference: proofReference,
          signedAt: signedAt,
        );

  final bool isSigned;
  final ConsentProofType? proofType;
  final String? proofReference;
  final DateTime? signedAt;
}

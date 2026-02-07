import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/statement_signoff_ui_model.dart';
import '../../domain/policies/statement_signoff_policy.dart';
import 'statements_domain_providers.dart';
import '../../../members/presentation/providers/members_providers.dart';

enum StatementSignoffStatusUi { notSigned, partiallySigned, signed }

final statementSignoffStatusProvider = Provider.autoDispose
    .family<StatementSignoffStatusUi, StatementMonthArgs>((ref, args) {
      final signoffs =
          ref.watch(statementSignoffsByMonthProvider(args)).valueOrNull ??
          const [];
      final status = ref
          .watch(statementSignoffPolicyProvider)
          .statusOf(signoffs);
      return switch (status) {
        StatementSignoffStatus.notSigned => StatementSignoffStatusUi.notSigned,
        StatementSignoffStatus.partiallySigned =>
          StatementSignoffStatusUi.partiallySigned,
        StatementSignoffStatus.signed => StatementSignoffStatusUi.signed,
      };
    });

final statementSignoffsUiModelsProvider = Provider.autoDispose
    .family<List<StatementSignoffUiModel>, StatementMonthArgs>((ref, args) {
      final signoffs =
          ref.watch(statementSignoffsByMonthProvider(args)).valueOrNull ??
          const [];
      final members =
          ref.watch(membersUiStateProvider).valueOrNull?.members ?? const [];
      final nameById = {for (final m in members) m.id: m.fullName};

      return [
        for (final s in signoffs)
          StatementSignoffUiModel(
            signerMemberId: s.signerMemberId,
            signerName: nameById[s.signerMemberId] ?? 'Member',
            role: s.role,
            proofReference: s.proofReference,
            signedAt: s.signedAt,
          ),
      ];
    });

final statementSignoffEligibleSignersProvider = Provider.autoDispose
    .family<List<StatementSignerUi>, StatementMonthArgs>((ref, args) {
      final members =
          ref.watch(membersUiStateProvider).valueOrNull?.members ?? const [];
      final active = [
        for (final m in members)
          if (m.isActive) m,
      ];
      active.sort((a, b) => a.position.compareTo(b.position));

      return [
        for (final m in active) StatementSignerUi(id: m.id, name: m.fullName),
      ];
    });

class StatementSignerUi {
  const StatementSignerUi({required this.id, required this.name});

  final String id;
  final String name;
}

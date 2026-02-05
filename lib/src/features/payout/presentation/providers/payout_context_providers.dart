import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../members/presentation/providers/members_providers.dart';
import '../../../rules/domain/entities/rule_set_snapshot.dart';
import '../../../rules/presentation/providers/rules_providers.dart';
import '../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';

class PayoutContext {
  const PayoutContext({
    required this.shomitiId,
    required this.ruleSetVersionId,
    required this.rules,
  });

  final String shomitiId;
  final String ruleSetVersionId;
  final RuleSetSnapshot rules;

  bool get allowShortfallCoverage =>
      rules.missedPaymentPolicy != MissedPaymentPolicy.postponePayout;
}

final payoutContextProvider = FutureProvider.autoDispose<PayoutContext?>((ref) async {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) return null;

  final version = await ref
      .watch(rulesRepositoryProvider)
      .getById(shomiti.activeRuleSetVersionId);
  if (version == null) return null;

  await ref.watch(seedMembersProvider)(
    shomitiId: shomiti.id,
    memberCount: version.snapshot.memberCount,
  );

  return PayoutContext(
    shomitiId: shomiti.id,
    ruleSetVersionId: version.id,
    rules: version.snapshot,
  );
});


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../members/data/drift_members_repository.dart';
import '../../../members/domain/repositories/members_repository.dart';
import '../../../members/domain/usecases/seed_members.dart';
import '../../../rules/domain/entities/rule_set_snapshot.dart';
import '../../../rules/presentation/providers/rules_providers.dart';
import '../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';

final sharesMembersRepositoryProvider = Provider<MembersRepository>((ref) {
  return DriftMembersRepository(ref.watch(appDatabaseProvider));
});

final sharesSeedMembersProvider = Provider<SeedMembers>((ref) {
  return SeedMembers(ref.watch(sharesMembersRepositoryProvider));
});

class SharesContext {
  const SharesContext({
    required this.shomitiId,
    required this.ruleSetVersionId,
    required this.rules,
  });

  final String shomitiId;
  final String ruleSetVersionId;
  final RuleSetSnapshot rules;
}

final sharesContextProvider = FutureProvider.autoDispose<SharesContext?>((
  ref,
) async {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) return null;

  final version = await ref
      .watch(rulesRepositoryProvider)
      .getById(shomiti.activeRuleSetVersionId);
  if (version == null) return null;

  await ref.watch(sharesSeedMembersProvider)(
    shomitiId: shomiti.id,
    memberCount: version.snapshot.memberCount,
  );

  return SharesContext(
    shomitiId: shomiti.id,
    ruleSetVersionId: version.id,
    rules: version.snapshot,
  );
});

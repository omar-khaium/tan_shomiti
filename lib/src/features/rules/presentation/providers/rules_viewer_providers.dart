import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/rule_set_version.dart';
import '../../../shomiti_setup/presentation/providers/shomiti_setup_providers.dart';
import 'rules_providers.dart';

final rulesViewerProvider = FutureProvider.autoDispose<RuleSetVersion?>((ref) async {
  final shomiti = await ref.watch(activeShomitiProvider.future);
  if (shomiti == null) return null;

  return ref
      .watch(rulesRepositoryProvider)
      .getById(shomiti.activeRuleSetVersionId);
});

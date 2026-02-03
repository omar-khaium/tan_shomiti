import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../data/drift_rules_repository.dart';
import '../../domain/repositories/rules_repository.dart';

final rulesRepositoryProvider = Provider<RulesRepository>((ref) {
  return DriftRulesRepository(ref.watch(appDatabaseProvider));
});


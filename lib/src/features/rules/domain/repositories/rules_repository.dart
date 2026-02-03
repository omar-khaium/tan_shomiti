import '../entities/rule_set_version.dart';

abstract class RulesRepository {
  Future<void> upsert(RuleSetVersion version);

  Future<RuleSetVersion?> getById(String id);
}


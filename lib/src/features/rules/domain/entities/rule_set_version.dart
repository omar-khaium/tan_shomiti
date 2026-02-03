import 'rule_set_snapshot.dart';

class RuleSetVersion {
  const RuleSetVersion({
    required this.id,
    required this.createdAt,
    required this.snapshot,
  });

  final String id;
  final DateTime createdAt;
  final RuleSetSnapshot snapshot;
}

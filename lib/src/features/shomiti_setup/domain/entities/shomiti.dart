const activeShomitiId = 'active';

class Shomiti {
  const Shomiti({
    required this.id,
    required this.name,
    required this.startDate,
    required this.createdAt,
    required this.activeRuleSetVersionId,
  });

  final String id;
  final String name;
  final DateTime startDate;
  final DateTime createdAt;
  final String activeRuleSetVersionId;
}

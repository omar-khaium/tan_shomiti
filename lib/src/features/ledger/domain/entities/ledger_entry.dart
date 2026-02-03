import '../../../../core/domain/money_bdt.dart';

class LedgerEntry {
  const LedgerEntry({
    required this.id,
    required this.amount,
    required this.direction,
    required this.occurredAt,
    this.category,
    this.note,
  });

  final int id;
  final MoneyBdt amount;
  final LedgerDirection direction;
  final DateTime occurredAt;
  final String? category;
  final String? note;
}

class NewLedgerEntry {
  const NewLedgerEntry({
    required this.amount,
    required this.direction,
    required this.occurredAt,
    this.category,
    this.note,
  });

  final MoneyBdt amount;
  final LedgerDirection direction;
  final DateTime occurredAt;
  final String? category;
  final String? note;
}

enum LedgerDirection {
  incoming,
  outgoing,
}


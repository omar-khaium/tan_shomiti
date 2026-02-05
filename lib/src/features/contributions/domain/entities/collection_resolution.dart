import '../value_objects/billing_month.dart';

enum CollectionResolutionMethod { reserve, guarantor }

class CollectionResolution {
  const CollectionResolution({
    required this.shomitiId,
    required this.month,
    required this.method,
    required this.amountBdt,
    required this.note,
    required this.createdAt,
  });

  final String shomitiId;
  final BillingMonth month;
  final CollectionResolutionMethod method;
  final int amountBdt;
  final String? note;
  final DateTime createdAt;
}


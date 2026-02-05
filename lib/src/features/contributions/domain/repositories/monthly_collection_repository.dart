import '../entities/collection_resolution.dart';
import '../value_objects/billing_month.dart';

abstract class MonthlyCollectionRepository {
  Stream<CollectionResolution?> watchResolution({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<CollectionResolution?> getResolution({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<void> upsertResolution(CollectionResolution resolution);
}


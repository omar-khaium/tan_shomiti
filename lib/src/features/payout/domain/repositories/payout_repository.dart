import '../../../contributions/domain/value_objects/billing_month.dart';
import '../entities/payout_approval.dart';
import '../entities/payout_collection_verification.dart';
import '../entities/payout_record.dart';

abstract class PayoutRepository {
  Stream<PayoutCollectionVerification?> watchCollectionVerification({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<PayoutCollectionVerification?> getCollectionVerification({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<void> upsertCollectionVerification(
    PayoutCollectionVerification verification,
  );

  Stream<List<PayoutApproval>> watchApprovals({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<List<PayoutApproval>> listApprovals({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<void> upsertApproval(PayoutApproval approval);

  Stream<PayoutRecord?> watchPayoutRecord({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<PayoutRecord?> getPayoutRecord({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<void> upsertPayoutRecord(PayoutRecord record);
}


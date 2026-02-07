import '../../../contributions/domain/value_objects/billing_month.dart';
import '../entities/statement_signoff.dart';

abstract class StatementSignoffsRepository {
  Stream<List<StatementSignoff>> watchForMonth({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<List<StatementSignoff>> listForMonth({
    required String shomitiId,
    required BillingMonth month,
  });

  /// Idempotent by primary key (shomitiId + monthKey + signerMemberId).
  Future<void> upsert(StatementSignoff signoff);

  Future<void> delete({
    required String shomitiId,
    required BillingMonth month,
    required String signerMemberId,
  });
}


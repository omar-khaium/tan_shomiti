import '../../../contributions/domain/value_objects/billing_month.dart';
import '../entities/draw_record.dart';

abstract class DrawRecordsRepository {
  Future<DrawRecord?> getById({
    required String id,
  });

  Future<DrawRecord?> getEffectiveForMonth({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<List<DrawRecord>> listForMonth({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<List<DrawRecord>> listAll({
    required String shomitiId,
  });

  Future<void> upsert(DrawRecord record);
}

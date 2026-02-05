import '../../../contributions/domain/value_objects/billing_month.dart';
import '../entities/draw_record.dart';

abstract class DrawRecordsRepository {
  Future<DrawRecord?> getForMonth({
    required String shomitiId,
    required BillingMonth month,
  });

  Future<List<DrawRecord>> listAll({
    required String shomitiId,
  });

  Future<void> upsert(DrawRecord record);
}


import '../entities/rule_amendment.dart';

abstract class RuleAmendmentsRepository {
  Stream<List<RuleAmendment>> watchAll({required String shomitiId});

  Stream<RuleAmendment?> watchPending({required String shomitiId});

  Future<RuleAmendment?> getById({
    required String shomitiId,
    required String amendmentId,
  });

  Future<void> upsert(RuleAmendment amendment);
}


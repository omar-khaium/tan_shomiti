import '../entities/member_consent.dart';

abstract class MemberConsentsRepository {
  Stream<List<MemberConsent>> watchConsents({
    required String shomitiId,
    required String ruleSetVersionId,
  });

  Future<void> upsert(MemberConsent consent);
}


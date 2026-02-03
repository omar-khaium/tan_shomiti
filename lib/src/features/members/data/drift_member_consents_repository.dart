import '../../../core/data/local/app_database.dart';
import '../domain/entities/member_consent.dart';
import '../domain/repositories/member_consents_repository.dart';

class DriftMemberConsentsRepository implements MemberConsentsRepository {
  DriftMemberConsentsRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<MemberConsent>> watchConsents({
    required String shomitiId,
    required String ruleSetVersionId,
  }) {
    final query = (_db.select(_db.memberConsents)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..where((t) => t.ruleSetVersionId.equals(ruleSetVersionId)))
        .watch();

    return query.map(
      (rows) => rows
          .map(
            (row) => MemberConsent(
              shomitiId: row.shomitiId,
              memberId: row.memberId,
              ruleSetVersionId: row.ruleSetVersionId,
              proofType: ConsentProofType.values.byName(row.proofType),
              proofReference: row.proofReference,
              signedAt: row.signedAt,
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<void> upsert(MemberConsent consent) async {
    await _db.into(_db.memberConsents).insertOnConflictUpdate(
          MemberConsentsCompanion.insert(
            memberId: consent.memberId,
            ruleSetVersionId: consent.ruleSetVersionId,
            shomitiId: consent.shomitiId,
            proofType: consent.proofType.name,
            proofReference: consent.proofReference,
            signedAt: consent.signedAt,
          ),
        );
  }
}

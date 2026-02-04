import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/guarantor.dart';
import '../domain/entities/security_deposit.dart';
import '../domain/repositories/risk_controls_repository.dart';

class DriftRiskControlsRepository implements RiskControlsRepository {
  DriftRiskControlsRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Guarantor?> getGuarantor({
    required String shomitiId,
    required String memberId,
  }) async {
    final row =
        await (_db.select(_db.guarantors)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..where((t) => t.memberId.equals(memberId)))
            .getSingleOrNull();
    return row == null ? null : _mapGuarantor(row);
  }

  @override
  Future<SecurityDeposit?> getSecurityDeposit({
    required String shomitiId,
    required String memberId,
  }) async {
    final row =
        await (_db.select(_db.securityDeposits)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..where((t) => t.memberId.equals(memberId)))
            .getSingleOrNull();
    return row == null ? null : _mapDeposit(row);
  }

  @override
  Future<List<Guarantor>> listGuarantors({required String shomitiId}) async {
    final rows =
        await (_db.select(_db.guarantors)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..orderBy([(t) => OrderingTerm.asc(t.memberId)]))
            .get();

    return rows.map(_mapGuarantor).toList(growable: false);
  }

  @override
  Future<List<SecurityDeposit>> listSecurityDeposits({
    required String shomitiId,
  }) async {
    final rows =
        await (_db.select(_db.securityDeposits)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..orderBy([(t) => OrderingTerm.asc(t.memberId)]))
            .get();

    return rows.map(_mapDeposit).toList(growable: false);
  }

  @override
  Future<void> upsertGuarantor(Guarantor guarantor) {
    return _db
        .into(_db.guarantors)
        .insertOnConflictUpdate(
          GuarantorsCompanion.insert(
            shomitiId: guarantor.shomitiId,
            memberId: guarantor.memberId,
            name: guarantor.name,
            phone: guarantor.phone,
            relationship: Value(guarantor.relationship),
            proofRef: Value(guarantor.proofRef),
            recordedAt: guarantor.recordedAt,
            updatedAt: Value(guarantor.updatedAt),
          ),
        );
  }

  @override
  Future<void> upsertSecurityDeposit(SecurityDeposit deposit) {
    return _db
        .into(_db.securityDeposits)
        .insertOnConflictUpdate(
          SecurityDepositsCompanion.insert(
            shomitiId: deposit.shomitiId,
            memberId: deposit.memberId,
            amountBdt: deposit.amountBdt,
            heldBy: deposit.heldBy,
            proofRef: Value(deposit.proofRef),
            recordedAt: deposit.recordedAt,
            returnedAt: Value(deposit.returnedAt),
            updatedAt: Value(deposit.updatedAt),
          ),
        );
  }

  @override
  Future<void> markSecurityDepositReturned({
    required String shomitiId,
    required String memberId,
    required DateTime returnedAt,
    String? proofRef,
  }) async {
    await (_db.update(_db.securityDeposits)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..where((t) => t.memberId.equals(memberId)))
        .write(
          SecurityDepositsCompanion(
            returnedAt: Value(returnedAt),
            proofRef: Value(proofRef),
            updatedAt: Value(returnedAt),
          ),
        );
  }

  static Guarantor _mapGuarantor(GuarantorRow row) {
    return Guarantor(
      shomitiId: row.shomitiId,
      memberId: row.memberId,
      name: row.name,
      phone: row.phone,
      relationship: row.relationship,
      proofRef: row.proofRef,
      recordedAt: row.recordedAt,
      updatedAt: row.updatedAt,
    );
  }

  static SecurityDeposit _mapDeposit(SecurityDepositRow row) {
    return SecurityDeposit(
      shomitiId: row.shomitiId,
      memberId: row.memberId,
      amountBdt: row.amountBdt,
      heldBy: row.heldBy,
      proofRef: row.proofRef,
      recordedAt: row.recordedAt,
      returnedAt: row.returnedAt,
      updatedAt: row.updatedAt,
    );
  }
}

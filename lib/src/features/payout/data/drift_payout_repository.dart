import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../../contributions/domain/value_objects/billing_month.dart';
import '../domain/entities/payout_approval.dart';
import '../domain/entities/payout_approval_role.dart';
import '../domain/entities/payout_collection_verification.dart';
import '../domain/entities/payout_record.dart';
import '../domain/repositories/payout_repository.dart';

class DriftPayoutRepository implements PayoutRepository {
  DriftPayoutRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<PayoutCollectionVerification?> watchCollectionVerification({
    required String shomitiId,
    required BillingMonth month,
  }) {
    final query = _db.select(_db.payoutCollectionVerifications)
      ..where((t) => t.shomitiId.equals(shomitiId))
      ..where((t) => t.monthKey.equals(month.key));

    return query.watchSingleOrNull().map(
          (row) => row == null ? null : _mapVerification(row),
        );
  }

  @override
  Future<PayoutCollectionVerification?> getCollectionVerification({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final row = await (_db.select(_db.payoutCollectionVerifications)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..where((t) => t.monthKey.equals(month.key)))
        .getSingleOrNull();
    return row == null ? null : _mapVerification(row);
  }

  @override
  Future<void> upsertCollectionVerification(
    PayoutCollectionVerification verification,
  ) async {
    await _db
        .into(_db.payoutCollectionVerifications)
        .insertOnConflictUpdate(
          PayoutCollectionVerificationsCompanion.insert(
            shomitiId: verification.shomitiId,
            monthKey: verification.month.key,
            ruleSetVersionId: verification.ruleSetVersionId,
            verifiedByMemberId: verification.verifiedByMemberId,
            note: Value(verification.note),
            verifiedAt: verification.verifiedAt,
          ),
        );
  }

  @override
  Stream<List<PayoutApproval>> watchApprovals({
    required String shomitiId,
    required BillingMonth month,
  }) {
    final query = _db.select(_db.payoutApprovals)
      ..where((t) => t.shomitiId.equals(shomitiId))
      ..where((t) => t.monthKey.equals(month.key))
      ..orderBy([
        (t) => OrderingTerm.asc(t.role),
        (t) => OrderingTerm.desc(t.approvedAt),
        (t) => OrderingTerm.asc(t.approverMemberId),
      ]);

    return query.watch().map(
          (rows) => rows.map(_mapApproval).toList(growable: false),
        );
  }

  @override
  Future<List<PayoutApproval>> listApprovals({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final rows = await (_db.select(_db.payoutApprovals)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..where((t) => t.monthKey.equals(month.key))
          ..orderBy([
            (t) => OrderingTerm.asc(t.role),
            (t) => OrderingTerm.desc(t.approvedAt),
            (t) => OrderingTerm.asc(t.approverMemberId),
          ]))
        .get();
    return rows.map(_mapApproval).toList(growable: false);
  }

  @override
  Future<void> upsertApproval(PayoutApproval approval) async {
    await _db.into(_db.payoutApprovals).insertOnConflictUpdate(
          PayoutApprovalsCompanion.insert(
            shomitiId: approval.shomitiId,
            monthKey: approval.month.key,
            role: approval.role.name,
            approverMemberId: approval.approverMemberId,
            ruleSetVersionId: approval.ruleSetVersionId,
            note: Value(approval.note),
            approvedAt: approval.approvedAt,
          ),
        );
  }

  @override
  Stream<PayoutRecord?> watchPayoutRecord({
    required String shomitiId,
    required BillingMonth month,
  }) {
    final query = _db.select(_db.payoutRecords)
      ..where((t) => t.shomitiId.equals(shomitiId))
      ..where((t) => t.monthKey.equals(month.key));

    return query.watchSingleOrNull().map(
          (row) => row == null ? null : _mapRecord(row),
        );
  }

  @override
  Future<PayoutRecord?> getPayoutRecord({
    required String shomitiId,
    required BillingMonth month,
  }) async {
    final row = await (_db.select(_db.payoutRecords)
          ..where((t) => t.shomitiId.equals(shomitiId))
          ..where((t) => t.monthKey.equals(month.key)))
        .getSingleOrNull();
    return row == null ? null : _mapRecord(row);
  }

  @override
  Future<void> upsertPayoutRecord(PayoutRecord record) async {
    await _db.into(_db.payoutRecords).insertOnConflictUpdate(
          PayoutRecordsCompanion.insert(
            shomitiId: record.shomitiId,
            monthKey: record.month.key,
            drawId: record.drawId,
            ruleSetVersionId: record.ruleSetVersionId,
            winnerMemberId: record.winnerMemberId,
            winnerShareIndex: record.winnerShareIndex,
            amountBdt: record.amountBdt,
            proofReference: Value(record.proofReference),
            markedPaidByMemberId: Value(record.markedPaidByMemberId),
            paidAt: Value(record.paidAt),
            recordedAt: record.recordedAt,
          ),
        );
  }

  static PayoutCollectionVerification _mapVerification(
    PayoutCollectionVerificationRow row,
  ) {
    return PayoutCollectionVerification(
      shomitiId: row.shomitiId,
      month: BillingMonth.fromKey(row.monthKey),
      ruleSetVersionId: row.ruleSetVersionId,
      verifiedByMemberId: row.verifiedByMemberId,
      note: row.note,
      verifiedAt: row.verifiedAt,
    );
  }

  static PayoutApproval _mapApproval(PayoutApprovalRow row) {
    return PayoutApproval(
      shomitiId: row.shomitiId,
      month: BillingMonth.fromKey(row.monthKey),
      role: PayoutApprovalRole.values.byName(row.role),
      approverMemberId: row.approverMemberId,
      ruleSetVersionId: row.ruleSetVersionId,
      note: row.note,
      approvedAt: row.approvedAt,
    );
  }

  static PayoutRecord _mapRecord(PayoutRecordRow row) {
    return PayoutRecord(
      shomitiId: row.shomitiId,
      month: BillingMonth.fromKey(row.monthKey),
      drawId: row.drawId,
      ruleSetVersionId: row.ruleSetVersionId,
      winnerMemberId: row.winnerMemberId,
      winnerShareIndex: row.winnerShareIndex,
      amountBdt: row.amountBdt,
      proofReference: row.proofReference,
      markedPaidByMemberId: row.markedPaidByMemberId,
      paidAt: row.paidAt,
      recordedAt: row.recordedAt,
    );
  }
}


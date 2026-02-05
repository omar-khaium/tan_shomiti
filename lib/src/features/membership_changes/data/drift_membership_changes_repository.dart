import 'package:drift/drift.dart';

import '../../../core/data/local/app_database.dart';
import '../domain/entities/membership_change_approval.dart';
import '../domain/entities/membership_change_request.dart';
import '../domain/repositories/membership_changes_repository.dart';

class DriftMembershipChangesRepository implements MembershipChangesRepository {
  DriftMembershipChangesRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<MembershipChangeRequest>> listRequests({
    required String shomitiId,
  }) async {
    final rows =
        await (_db.select(_db.membershipChangeRequests)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..orderBy([(t) => OrderingTerm.desc(t.requestedAt)]))
            .get();

    return rows.map(_mapRequest).toList(growable: false);
  }

  @override
  Future<MembershipChangeRequest?> getOpenRequestForMember({
    required String shomitiId,
    required String outgoingMemberId,
  }) async {
    final row =
        await (_db.select(_db.membershipChangeRequests)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..where((t) => t.outgoingMemberId.equals(outgoingMemberId))
              ..where((t) => t.finalizedAt.isNull())
              ..orderBy([(t) => OrderingTerm.desc(t.requestedAt)])
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _mapRequest(row);
  }

  @override
  Future<MembershipChangeRequest?> getById({
    required String shomitiId,
    required String requestId,
  }) async {
    final row =
        await (_db.select(_db.membershipChangeRequests)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..where((t) => t.id.equals(requestId)))
            .getSingleOrNull();
    return row == null ? null : _mapRequest(row);
  }

  @override
  Future<void> upsertRequest(MembershipChangeRequest request) {
    return _db
        .into(_db.membershipChangeRequests)
        .insertOnConflictUpdate(
          MembershipChangeRequestsCompanion.insert(
            id: request.id,
            shomitiId: request.shomitiId,
            outgoingMemberId: request.outgoingMemberId,
            type: request.type.name,
            requiresReplacement: Value(request.requiresReplacement),
            replacementCandidateName: Value(request.replacementCandidateName),
            replacementCandidatePhone: Value(request.replacementCandidatePhone),
            removalReasonCode: Value(request.removalReasonCode),
            removalReasonDetails: Value(request.removalReasonDetails),
            requestedAt: request.requestedAt,
            updatedAt: Value(request.updatedAt),
            finalizedAt: Value(request.finalizedAt),
          ),
        );
  }

  @override
  Future<List<MembershipChangeApproval>> listApprovals({
    required String shomitiId,
    required String requestId,
  }) async {
    final rows =
        await (_db.select(_db.membershipChangeApprovals)
              ..where((t) => t.shomitiId.equals(shomitiId))
              ..where((t) => t.requestId.equals(requestId))
              ..orderBy([(t) => OrderingTerm.asc(t.approvedAt)]))
            .get();
    return rows.map(_mapApproval).toList(growable: false);
  }

  @override
  Future<void> upsertApproval(MembershipChangeApproval approval) {
    return _db
        .into(_db.membershipChangeApprovals)
        .insertOnConflictUpdate(
          MembershipChangeApprovalsCompanion.insert(
            shomitiId: approval.shomitiId,
            requestId: approval.requestId,
            approverMemberId: approval.approverMemberId,
            approvedAt: approval.approvedAt,
            note: Value(approval.note),
          ),
        );
  }

  static MembershipChangeRequest _mapRequest(MembershipChangeRequestRow row) {
    return MembershipChangeRequest(
      id: row.id,
      shomitiId: row.shomitiId,
      outgoingMemberId: row.outgoingMemberId,
      type: MembershipChangeType.values.byName(row.type),
      requiresReplacement: row.requiresReplacement,
      replacementCandidateName: row.replacementCandidateName,
      replacementCandidatePhone: row.replacementCandidatePhone,
      removalReasonCode: row.removalReasonCode,
      removalReasonDetails: row.removalReasonDetails,
      requestedAt: row.requestedAt,
      updatedAt: row.updatedAt,
      finalizedAt: row.finalizedAt,
    );
  }

  static MembershipChangeApproval _mapApproval(
    MembershipChangeApprovalRow row,
  ) {
    return MembershipChangeApproval(
      shomitiId: row.shomitiId,
      requestId: row.requestId,
      approverMemberId: row.approverMemberId,
      approvedAt: row.approvedAt,
      note: row.note,
    );
  }
}

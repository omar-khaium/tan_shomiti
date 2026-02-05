import '../entities/membership_change_approval.dart';
import '../entities/membership_change_request.dart';

abstract class MembershipChangesRepository {
  Future<List<MembershipChangeRequest>> listRequests({required String shomitiId});

  Future<MembershipChangeRequest?> getById({
    required String shomitiId,
    required String requestId,
  });

  Future<MembershipChangeRequest?> getOpenRequestForMember({
    required String shomitiId,
    required String outgoingMemberId,
  });

  Future<void> upsertRequest(MembershipChangeRequest request);

  Future<List<MembershipChangeApproval>> listApprovals({
    required String shomitiId,
    required String requestId,
  });

  Future<void> upsertApproval(MembershipChangeApproval approval);
}

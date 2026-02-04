import '../entities/guarantor.dart';
import '../entities/security_deposit.dart';

abstract class RiskControlsRepository {
  Future<Guarantor?> getGuarantor({
    required String shomitiId,
    required String memberId,
  });

  Future<SecurityDeposit?> getSecurityDeposit({
    required String shomitiId,
    required String memberId,
  });

  Future<List<Guarantor>> listGuarantors({required String shomitiId});

  Future<List<SecurityDeposit>> listSecurityDeposits({
    required String shomitiId,
  });

  Future<void> upsertGuarantor(Guarantor guarantor);

  Future<void> upsertSecurityDeposit(SecurityDeposit deposit);

  Future<void> markSecurityDepositReturned({
    required String shomitiId,
    required String memberId,
    required DateTime returnedAt,
    String? proofRef,
  });
}

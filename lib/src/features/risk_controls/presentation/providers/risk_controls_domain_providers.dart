import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../data/drift_risk_controls_repository.dart';
import '../../domain/repositories/risk_controls_repository.dart';
import '../../domain/usecases/mark_security_deposit_returned.dart';
import '../../domain/usecases/record_guarantor.dart';
import '../../domain/usecases/record_security_deposit.dart';

final riskControlsRepositoryProvider = Provider<RiskControlsRepository>((ref) {
  return DriftRiskControlsRepository(ref.watch(appDatabaseProvider));
});

final recordGuarantorProvider = Provider<RecordGuarantor>((ref) {
  return RecordGuarantor(
    riskControlsRepository: ref.watch(riskControlsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final recordSecurityDepositProvider = Provider<RecordSecurityDeposit>((ref) {
  return RecordSecurityDeposit(
    riskControlsRepository: ref.watch(riskControlsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final markSecurityDepositReturnedProvider =
    Provider<MarkSecurityDepositReturned>((ref) {
      return MarkSecurityDepositReturned(
        riskControlsRepository: ref.watch(riskControlsRepositoryProvider),
        appendAuditEvent: ref.watch(appendAuditEventProvider),
      );
    });

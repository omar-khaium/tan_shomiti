import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../contributions/presentation/providers/contributions_domain_providers.dart';
import '../../../members/presentation/providers/members_providers.dart';
import '../../../payments/presentation/providers/payments_domain_providers.dart';
import '../../../payments/presentation/providers/payments_policy_providers.dart';
import '../../data/drift_draw_records_repository.dart';
import '../../data/drift_draw_witness_repository.dart';
import '../../domain/repositories/draw_records_repository.dart';
import '../../domain/repositories/draw_witness_repository.dart';
import '../../domain/usecases/compute_draw_eligibility.dart';
import '../../domain/usecases/finalize_draw_record.dart';
import '../../domain/usecases/invalidate_draw_record.dart';
import '../../domain/usecases/record_draw_witness_approval.dart';
import '../../domain/usecases/record_draw_result.dart';

final drawRecordsRepositoryProvider = Provider<DrawRecordsRepository>((ref) {
  return DriftDrawRecordsRepository(ref.watch(appDatabaseProvider));
});

final drawWitnessRepositoryProvider = Provider<DrawWitnessRepository>((ref) {
  return DriftDrawWitnessRepository(ref.watch(appDatabaseProvider));
});

final computeDrawEligibilityProvider = Provider<ComputeDrawEligibility>((ref) {
  return ComputeDrawEligibility(
    monthlyDuesRepository: ref.watch(monthlyDuesRepositoryProvider),
    membersRepository: ref.watch(membersRepositoryProvider),
    paymentsRepository: ref.watch(paymentsRepositoryProvider),
    drawRecordsRepository: ref.watch(drawRecordsRepositoryProvider),
    computePaymentCompliance: ref.watch(computePaymentComplianceProvider),
  );
});

final recordDrawResultProvider = Provider<RecordDrawResult>((ref) {
  return RecordDrawResult(
    drawRecordsRepository: ref.watch(drawRecordsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final recordDrawWitnessApprovalProvider =
    Provider<RecordDrawWitnessApproval>((ref) {
      return RecordDrawWitnessApproval(
        repository: ref.watch(drawWitnessRepositoryProvider),
        appendAuditEvent: ref.watch(appendAuditEventProvider),
      );
    });

final finalizeDrawRecordProvider = Provider<FinalizeDrawRecord>((ref) {
  return FinalizeDrawRecord(
    drawRecordsRepository: ref.watch(drawRecordsRepositoryProvider),
    drawWitnessRepository: ref.watch(drawWitnessRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final invalidateDrawRecordProvider = Provider<InvalidateDrawRecord>((ref) {
  return InvalidateDrawRecord(
    drawRecordsRepository: ref.watch(drawRecordsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../contributions/presentation/providers/contributions_domain_providers.dart';
import '../../../members/presentation/providers/members_providers.dart';
import '../../../payments/presentation/providers/payments_domain_providers.dart';
import '../../../payments/presentation/providers/payments_policy_providers.dart';
import '../../data/drift_draw_records_repository.dart';
import '../../domain/repositories/draw_records_repository.dart';
import '../../domain/usecases/compute_draw_eligibility.dart';
import '../../domain/usecases/record_draw_result.dart';

final drawRecordsRepositoryProvider = Provider<DrawRecordsRepository>((ref) {
  return DriftDrawRecordsRepository(ref.watch(appDatabaseProvider));
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


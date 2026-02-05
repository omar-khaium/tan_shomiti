import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../ledger/presentation/providers/ledger_providers.dart';
import '../../../risk_controls/presentation/providers/risk_controls_domain_providers.dart';
import '../../data/drift_defaults_repository.dart';
import '../../domain/repositories/defaults_repository.dart';
import '../../domain/usecases/compute_defaults_dashboard.dart';
import '../../domain/usecases/record_default_enforcement_step.dart';

final defaultsRepositoryProvider = Provider<DefaultsRepository>((ref) {
  return DriftDefaultsRepository(ref.watch(appDatabaseProvider));
});

final computeDefaultsDashboardProvider = Provider<ComputeDefaultsDashboard>((ref) {
  return ComputeDefaultsDashboard(ref.watch(defaultsRepositoryProvider));
});

final recordDefaultEnforcementStepProvider = Provider<RecordDefaultEnforcementStep>((ref) {
  return RecordDefaultEnforcementStep(
    defaultsRepository: ref.watch(defaultsRepositoryProvider),
    riskControlsRepository: ref.watch(riskControlsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
    appendLedgerEntry: ref.watch(appendLedgerEntryProvider),
    computeDefaultsDashboard: ref.watch(computeDefaultsDashboardProvider),
  );
});


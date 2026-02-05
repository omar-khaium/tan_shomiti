import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../contributions/presentation/providers/contributions_domain_providers.dart';
import '../../../draw/presentation/providers/draw_domain_providers.dart';
import '../../../ledger/presentation/providers/ledger_providers.dart';
import '../../../members/presentation/governance/providers/governance_providers.dart';
import '../../../payments/presentation/providers/payments_domain_providers.dart';
import '../../data/drift_payout_repository.dart';
import '../../domain/repositories/payout_repository.dart';
import '../../domain/usecases/mark_payout_paid.dart';
import '../../domain/usecases/record_payout_approval.dart';
import '../../domain/usecases/verify_monthly_collection.dart';

final payoutRepositoryProvider = Provider<PayoutRepository>((ref) {
  return DriftPayoutRepository(ref.watch(appDatabaseProvider));
});

final verifyMonthlyCollectionProvider = Provider<VerifyMonthlyCollection>((ref) {
  return VerifyMonthlyCollection(
    payoutRepository: ref.watch(payoutRepositoryProvider),
    monthlyDuesRepository: ref.watch(monthlyDuesRepositoryProvider),
    paymentsRepository: ref.watch(paymentsRepositoryProvider),
    monthlyCollectionRepository: ref.watch(monthlyCollectionRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final recordPayoutApprovalProvider = Provider<RecordPayoutApproval>((ref) {
  return RecordPayoutApproval(
    payoutRepository: ref.watch(payoutRepositoryProvider),
    rolesRepository: ref.watch(rolesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final markPayoutPaidProvider = Provider<MarkPayoutPaid>((ref) {
  return MarkPayoutPaid(
    payoutRepository: ref.watch(payoutRepositoryProvider),
    drawRecordsRepository: ref.watch(drawRecordsRepositoryProvider),
    monthlyDuesRepository: ref.watch(monthlyDuesRepositoryProvider),
    paymentsRepository: ref.watch(paymentsRepositoryProvider),
    monthlyCollectionRepository: ref.watch(monthlyCollectionRepositoryProvider),
    appendLedgerEntry: ref.watch(appendLedgerEntryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

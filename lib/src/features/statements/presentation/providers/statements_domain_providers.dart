import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../../contributions/presentation/providers/contributions_domain_providers.dart';
import '../../../draw/presentation/providers/draw_domain_providers.dart';
import '../../../members/presentation/providers/members_providers.dart';
import '../../../payments/presentation/providers/payments_domain_providers.dart';
import '../../../payout/presentation/providers/payout_domain_providers.dart';
import '../../../members/presentation/governance/providers/governance_providers.dart';
import '../../data/drift_statements_repository.dart';
import '../../data/drift_statement_signoffs_repository.dart';
import '../../../contributions/domain/value_objects/billing_month.dart';
import '../../domain/repositories/statements_repository.dart';
import '../../domain/entities/monthly_statement.dart';
import '../../domain/usecases/generate_monthly_statement.dart';
import '../../domain/entities/statement_signoff.dart';
import '../../domain/repositories/statement_signoffs_repository.dart';
import '../../domain/usecases/record_statement_signoff.dart';
import '../../domain/usecases/delete_statement_signoff.dart';
import '../../domain/policies/statement_signoff_policy.dart';

final statementsRepositoryProvider = Provider<StatementsRepository>((ref) {
  return DriftStatementsRepository(ref.watch(appDatabaseProvider));
});

final generateMonthlyStatementProvider = Provider<GenerateMonthlyStatement>((
  ref,
) {
  return GenerateMonthlyStatement(
    statementsRepository: ref.watch(statementsRepositoryProvider),
    monthlyDuesRepository: ref.watch(monthlyDuesRepositoryProvider),
    paymentsRepository: ref.watch(paymentsRepositoryProvider),
    monthlyCollectionRepository: ref.watch(monthlyCollectionRepositoryProvider),
    drawRecordsRepository: ref.watch(drawRecordsRepositoryProvider),
    drawWitnessRepository: ref.watch(drawWitnessRepositoryProvider),
    membersRepository: ref.watch(membersRepositoryProvider),
    payoutRepository: ref.watch(payoutRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final statementByMonthProvider = StreamProvider.autoDispose
    .family<MonthlyStatement?, StatementMonthArgs>((ref, args) {
      return ref
          .watch(statementsRepositoryProvider)
          .watchStatement(shomitiId: args.shomitiId, month: args.month);
    });

final statementSignoffsRepositoryProvider =
    Provider<StatementSignoffsRepository>((ref) {
      return DriftStatementSignoffsRepository(ref.watch(appDatabaseProvider));
    });

final statementSignoffPolicyProvider = Provider<StatementSignoffPolicy>((ref) {
  return const StatementSignoffPolicy();
});

final recordStatementSignoffProvider = Provider<RecordStatementSignoff>((ref) {
  return RecordStatementSignoff(
    statementsRepository: ref.watch(statementsRepositoryProvider),
    signoffsRepository: ref.watch(statementSignoffsRepositoryProvider),
    membersRepository: ref.watch(membersRepositoryProvider),
    rolesRepository: ref.watch(rolesRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final deleteStatementSignoffProvider = Provider<DeleteStatementSignoff>((ref) {
  return DeleteStatementSignoff(
    repository: ref.watch(statementSignoffsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final statementSignoffsByMonthProvider = StreamProvider.autoDispose
    .family<List<StatementSignoff>, StatementMonthArgs>((ref, args) {
      return ref
          .watch(statementSignoffsRepositoryProvider)
          .watchForMonth(shomitiId: args.shomitiId, month: args.month);
    });

class StatementMonthArgs {
  const StatementMonthArgs({required this.shomitiId, required this.month});

  final String shomitiId;
  final BillingMonth month;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatementMonthArgs &&
          shomitiId == other.shomitiId &&
          month == other.month;

  @override
  int get hashCode => Object.hash(shomitiId, month);
}

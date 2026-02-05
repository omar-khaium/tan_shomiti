import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/data/local/app_database_provider.dart';
import '../../../audit/presentation/providers/audit_providers.dart';
import '../../data/drift_payments_repository.dart';
import '../../domain/repositories/payments_repository.dart';
import '../../domain/usecases/issue_receipt.dart';
import '../../domain/usecases/record_payment.dart';
import '../../domain/usecases/record_payment_and_issue_receipt.dart';

final paymentsRepositoryProvider = Provider<PaymentsRepository>((ref) {
  return DriftPaymentsRepository(ref.watch(appDatabaseProvider));
});

final recordPaymentProvider = Provider<RecordPayment>((ref) {
  return RecordPayment(
    paymentsRepository: ref.watch(paymentsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final issueReceiptProvider = Provider<IssueReceipt>((ref) {
  return IssueReceipt(
    paymentsRepository: ref.watch(paymentsRepositoryProvider),
    appendAuditEvent: ref.watch(appendAuditEventProvider),
  );
});

final recordPaymentAndIssueReceiptProvider =
    Provider<RecordPaymentAndIssueReceipt>((ref) {
      return RecordPaymentAndIssueReceipt(
        recordPayment: ref.watch(recordPaymentProvider),
        issueReceipt: ref.watch(issueReceiptProvider),
      );
    });


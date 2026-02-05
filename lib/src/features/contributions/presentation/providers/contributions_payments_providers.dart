import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../payments/domain/entities/payment.dart';
import '../../../payments/presentation/providers/payments_domain_providers.dart';
import '../../domain/value_objects/billing_month.dart';

@immutable
class PaymentsMonthArgs {
  const PaymentsMonthArgs({required this.shomitiId, required this.month});

  final String shomitiId;
  final BillingMonth month;

  @override
  bool operator ==(Object other) {
    return other is PaymentsMonthArgs &&
        other.shomitiId == shomitiId &&
        other.month == month;
  }

  @override
  int get hashCode => Object.hash(shomitiId, month);
}

final paymentsByMemberIdForMonthProvider =
    StreamProvider.autoDispose.family<Map<String, Payment>, PaymentsMonthArgs>((
  ref,
  args,
) {
  final repo = ref.watch(paymentsRepositoryProvider);
  return repo
      .watchPaymentsForMonth(shomitiId: args.shomitiId, month: args.month)
      .map((items) {
        return <String, Payment>{
          for (final payment in items) payment.memberId: payment,
        };
      });
});


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/demo_payment_receipt.dart';

class DemoPaymentsController
    extends StateNotifier<Map<DemoPaymentKey, DemoPaymentReceipt>> {
  DemoPaymentsController() : super(const {});

  var _counter = 0;

  Future<void> recordPayment({
    required String memberId,
    required String monthKey,
    required int amountBdt,
    required DemoPaymentMethod method,
    required String reference,
  }) async {
    _counter += 1;
    final key = DemoPaymentKey(memberId: memberId, monthKey: monthKey);
    final receipt = DemoPaymentReceipt(
      receiptNumber: 'R-${_counter.toString().padLeft(4, '0')}',
      amountBdt: amountBdt,
      method: method,
      reference: reference,
      recordedAt: DateTime.now(),
    );

    state = {...state, key: receipt};
  }
}

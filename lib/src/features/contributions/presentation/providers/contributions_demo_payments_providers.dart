import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/demo_payments_controller.dart';
import '../models/demo_payment_receipt.dart';

final demoPaymentsControllerProvider = StateNotifierProvider.autoDispose<
    DemoPaymentsController, Map<DemoPaymentKey, DemoPaymentReceipt>>((ref) {
  return DemoPaymentsController();
});

final demoPaymentReceiptProvider =
    Provider.autoDispose.family<DemoPaymentReceipt?, DemoPaymentKey>((
  ref,
  key,
) {
  return ref.watch(demoPaymentsControllerProvider)[key];
});


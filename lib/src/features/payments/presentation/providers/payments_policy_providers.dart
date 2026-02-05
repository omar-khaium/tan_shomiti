import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/compute_payment_compliance.dart';

final computePaymentComplianceProvider =
    Provider<ComputePaymentCompliance>((ref) => const ComputePaymentCompliance());


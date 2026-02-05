import '../../../contributions/domain/value_objects/billing_month.dart';

class PaymentCompliance {
  const PaymentCompliance({
    required this.isEligible,
    required this.isOnTime,
    required this.lateFeeBdt,
    required this.deadlineDay,
  });

  /// Eligible for monthly draw per rules: confirmed payment within grace window.
  final bool isEligible;

  /// Payment is on time (within grace window). If deadline cannot be parsed, this
  /// is treated as true to avoid false ineligibility.
  final bool isOnTime;

  /// Late fee in BDT (0 if on time or if late fee policy disabled).
  final int lateFeeBdt;

  /// Parsed deadline day-of-month (1..28). `null` when parsing fails.
  final int? deadlineDay;
}

class ComputePaymentCompliance {
  const ComputePaymentCompliance();

  PaymentCompliance call({
    required BillingMonth month,
    required DateTime confirmedAt,
    required String paymentDeadline,
    required int? gracePeriodDays,
    required int? lateFeeBdtPerDay,
  }) {
    final deadlineDay = _parseDeadlineDay(paymentDeadline);
    if (deadlineDay == null) {
      return const PaymentCompliance(
        isEligible: true,
        isOnTime: true,
        lateFeeBdt: 0,
        deadlineDay: null,
      );
    }

    final grace = gracePeriodDays ?? 0;
    final feePerDay = lateFeeBdtPerDay ?? 0;

    final deadlineDateUtc = DateTime.utc(month.year, month.month, deadlineDay);
    final cutoffUtc = deadlineDateUtc.add(Duration(days: grace));
    final confirmedUtc = confirmedAt.toUtc();

    if (!confirmedUtc.isAfter(cutoffUtc)) {
      return PaymentCompliance(
        isEligible: true,
        isOnTime: true,
        lateFeeBdt: 0,
        deadlineDay: deadlineDay,
      );
    }

    final secondsLate = confirmedUtc.difference(cutoffUtc).inSeconds;
    final lateDays = _ceilDiv(secondsLate, 86400).clamp(1, 366);
    final lateFee = lateDays * feePerDay;

    return PaymentCompliance(
      isEligible: false,
      isOnTime: false,
      lateFeeBdt: lateFee,
      deadlineDay: deadlineDay,
    );
  }

  static int _ceilDiv(int num, int den) {
    return (num + den - 1) ~/ den;
  }

  static int? _parseDeadlineDay(String input) {
    final match = RegExp(r'(\d{1,2})').firstMatch(input);
    if (match == null) return null;
    final parsed = int.tryParse(match.group(1) ?? '');
    if (parsed == null) return null;
    if (parsed < 1 || parsed > 28) return null;
    return parsed;
  }
}


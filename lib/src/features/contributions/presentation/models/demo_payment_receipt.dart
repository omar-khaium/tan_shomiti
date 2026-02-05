import '../../domain/value_objects/billing_month.dart';

enum DemoPaymentMethod { cash, bankTransfer, mobileWallet, other }

class DemoPaymentKey {
  const DemoPaymentKey({required this.memberId, required this.monthKey});

  final String memberId;
  final String monthKey;

  BillingMonth get month => BillingMonth.fromKey(monthKey);

  @override
  bool operator ==(Object other) {
    return other is DemoPaymentKey &&
        other.memberId == memberId &&
        other.monthKey == monthKey;
  }

  @override
  int get hashCode => Object.hash(memberId, monthKey);
}

class DemoPaymentReceipt {
  const DemoPaymentReceipt({
    required this.receiptNumber,
    required this.amountBdt,
    required this.method,
    required this.reference,
    required this.recordedAt,
  });

  final String receiptNumber;
  final int amountBdt;
  final DemoPaymentMethod method;
  final String reference;
  final DateTime recordedAt;

  String get methodLabel => switch (method) {
    DemoPaymentMethod.cash => 'Cash',
    DemoPaymentMethod.bankTransfer => 'Bank transfer',
    DemoPaymentMethod.mobileWallet => 'Mobile wallet',
    DemoPaymentMethod.other => 'Other',
  };
}


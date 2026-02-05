enum PaymentMethod { cash, bankTransfer, mobileWallet, other }

extension PaymentMethodStorage on PaymentMethod {
  String get value => switch (this) {
    PaymentMethod.cash => 'cash',
    PaymentMethod.bankTransfer => 'bank_transfer',
    PaymentMethod.mobileWallet => 'mobile_wallet',
    PaymentMethod.other => 'other',
  };

  static PaymentMethod fromValue(String value) => switch (value) {
    'cash' => PaymentMethod.cash,
    'bank_transfer' => PaymentMethod.bankTransfer,
    'mobile_wallet' => PaymentMethod.mobileWallet,
    'other' => PaymentMethod.other,
    _ => PaymentMethod.other,
  };

  String get label => switch (this) {
    PaymentMethod.cash => 'Cash',
    PaymentMethod.bankTransfer => 'Bank transfer',
    PaymentMethod.mobileWallet => 'Mobile wallet',
    PaymentMethod.other => 'Other',
  };
}


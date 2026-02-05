class PaymentValidationException implements Exception {
  const PaymentValidationException(this.message);
  final String message;

  @override
  String toString() => 'PaymentValidationException: $message';
}


class PayoutValidationException implements Exception {
  const PayoutValidationException(this.message);

  final String message;

  @override
  String toString() => message;
}

class PayoutNotFoundException implements Exception {
  const PayoutNotFoundException(this.message);

  final String message;

  @override
  String toString() => message;
}


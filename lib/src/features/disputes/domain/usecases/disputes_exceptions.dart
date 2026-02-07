class DisputesValidationException implements Exception {
  const DisputesValidationException(this.message);

  final String message;

  @override
  String toString() => message;
}


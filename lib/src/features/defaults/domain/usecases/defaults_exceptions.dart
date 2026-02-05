class DefaultsValidationException implements Exception {
  const DefaultsValidationException(this.message);

  final String message;

  @override
  String toString() => 'DefaultsValidationException($message)';
}


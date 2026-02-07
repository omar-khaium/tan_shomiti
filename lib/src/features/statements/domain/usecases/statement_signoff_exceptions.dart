class StatementSignoffException implements Exception {
  const StatementSignoffException(this.message);

  final String message;

  @override
  String toString() => 'StatementSignoffException: $message';
}


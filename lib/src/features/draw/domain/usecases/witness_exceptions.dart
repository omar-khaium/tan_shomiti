class DrawWitnessException implements Exception {
  const DrawWitnessException(this.message);

  final String message;

  @override
  String toString() => 'DrawWitnessException: $message';
}


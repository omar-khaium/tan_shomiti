class RuleAmendmentException implements Exception {
  const RuleAmendmentException(this.message);

  final String message;

  @override
  String toString() => message;
}


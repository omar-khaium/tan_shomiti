sealed class RiskControlException implements Exception {
  const RiskControlException(this.message);

  final String message;

  @override
  String toString() => 'RiskControlException($message)';
}

class RiskControlValidationException extends RiskControlException {
  const RiskControlValidationException(super.message);
}

class RiskControlMissingException extends RiskControlException {
  const RiskControlMissingException({
    required this.missingMemberIds,
    String message = 'Risk control is missing for one or more member(s).',
  }) : super(message);

  final List<String> missingMemberIds;
}

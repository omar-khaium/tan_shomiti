sealed class RiskControlException implements Exception {
  const RiskControlException(this.message);

  final String message;

  @override
  String toString() => 'RiskControlException($message)';
}

class RiskControlValidationException extends RiskControlException {
  const RiskControlValidationException(super.message);
}

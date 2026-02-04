sealed class SharesAllocationException implements Exception {
  const SharesAllocationException(this.message);

  final String message;

  @override
  String toString() => 'SharesAllocationException($message)';
}

class SharesCapExceededException extends SharesAllocationException {
  const SharesCapExceededException(super.message);
}

class SharesTotalExceededException extends SharesAllocationException {
  const SharesTotalExceededException(super.message);
}

class SharesInvalidConfigurationException extends SharesAllocationException {
  const SharesInvalidConfigurationException(super.message);
}

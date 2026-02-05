class DrawEligibilityException implements Exception {
  const DrawEligibilityException(this.message);

  final String message;

  @override
  String toString() => 'DrawEligibilityException: $message';
}

class DrawRecordingException implements Exception {
  const DrawRecordingException(this.message);

  final String message;

  @override
  String toString() => 'DrawRecordingException: $message';
}


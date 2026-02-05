class MembershipChangeValidationException implements Exception {
  const MembershipChangeValidationException(this.message);

  final String message;

  @override
  String toString() => 'MembershipChangeValidationException($message)';
}

class MembershipChangeConflictException implements Exception {
  const MembershipChangeConflictException(this.message);

  final String message;

  @override
  String toString() => 'MembershipChangeConflictException($message)';
}

class MembershipChangeNotFoundException implements Exception {
  const MembershipChangeNotFoundException(this.message);

  final String message;

  @override
  String toString() => 'MembershipChangeNotFoundException($message)';
}


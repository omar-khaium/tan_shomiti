enum MemberDuplicateField { phone, nidOrPassport }

sealed class MemberWriteException implements Exception {
  const MemberWriteException();

  String get message;

  @override
  String toString() => '$runtimeType($message)';
}

class MemberValidationException extends MemberWriteException {
  const MemberValidationException(this.message);

  @override
  final String message;
}

class MemberJoiningClosedException extends MemberWriteException {
  const MemberJoiningClosedException();

  @override
  String get message => 'Joining is closed.';
}

class MemberNotFoundException extends MemberWriteException {
  const MemberNotFoundException(this.memberId);

  final String memberId;

  @override
  String get message => 'Member not found: $memberId';
}

class MemberDuplicateException extends MemberWriteException {
  const MemberDuplicateException({
    required this.field,
    required this.conflictingMemberId,
  });

  final MemberDuplicateField field;
  final String conflictingMemberId;

  @override
  String get message => 'Duplicate member detected for ${field.name}.';
}

import '../entities/member_consent.dart';
import '../repositories/member_consents_repository.dart';

class WatchMemberConsents {
  const WatchMemberConsents(this._consentsRepository);

  final MemberConsentsRepository _consentsRepository;

  Stream<List<MemberConsent>> call({
    required String shomitiId,
    required String ruleSetVersionId,
  }) {
    return _consentsRepository.watchConsents(
      shomitiId: shomitiId,
      ruleSetVersionId: ruleSetVersionId,
    );
  }
}


enum ConsentProofType {
  signature,
  otp,
  chatReference,
}

class MemberConsent {
  const MemberConsent({
    required this.shomitiId,
    required this.memberId,
    required this.ruleSetVersionId,
    required this.proofType,
    required this.proofReference,
    required this.signedAt,
  });

  final String shomitiId;
  final String memberId;
  final String ruleSetVersionId;
  final ConsentProofType proofType;
  final String proofReference;
  final DateTime signedAt;
}


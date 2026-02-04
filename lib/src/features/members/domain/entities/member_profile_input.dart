class MemberProfileInput {
  const MemberProfileInput({
    required this.fullName,
    required this.phone,
    required this.addressOrWorkplace,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.nidOrPassport,
    required this.notes,
  });

  final String fullName;
  final String phone;
  final String addressOrWorkplace;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String? nidOrPassport;
  final String? notes;
}

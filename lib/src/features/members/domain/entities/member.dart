class Member {
  const Member({
    required this.id,
    required this.shomitiId,
    required this.position,
    required this.fullName,
    required this.phone,
    required this.addressOrWorkplace,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.nidOrPassport,
    required this.notes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String shomitiId;
  final int position;
  final String fullName;
  final String? phone;
  final String? addressOrWorkplace;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? nidOrPassport;
  final String? notes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  bool get isProfileComplete =>
      fullName.trim().isNotEmpty &&
      phone?.trim().isNotEmpty == true &&
      addressOrWorkplace?.trim().isNotEmpty == true &&
      emergencyContactName?.trim().isNotEmpty == true &&
      emergencyContactPhone?.trim().isNotEmpty == true;

  static const _unset = Object();

  Member copyWith({
    String? fullName,
    Object? phone = _unset,
    Object? addressOrWorkplace = _unset,
    Object? emergencyContactName = _unset,
    Object? emergencyContactPhone = _unset,
    Object? nidOrPassport = _unset,
    Object? notes = _unset,
    bool? isActive,
    DateTime? updatedAt,
  }) {
    return Member(
      id: id,
      shomitiId: shomitiId,
      position: position,
      fullName: fullName ?? this.fullName,
      phone: phone == _unset ? this.phone : phone as String?,
      addressOrWorkplace: addressOrWorkplace == _unset
          ? this.addressOrWorkplace
          : addressOrWorkplace as String?,
      emergencyContactName: emergencyContactName == _unset
          ? this.emergencyContactName
          : emergencyContactName as String?,
      emergencyContactPhone: emergencyContactPhone == _unset
          ? this.emergencyContactPhone
          : emergencyContactPhone as String?,
      nidOrPassport: nidOrPassport == _unset
          ? this.nidOrPassport
          : nidOrPassport as String?,
      notes: notes == _unset ? this.notes : notes as String?,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

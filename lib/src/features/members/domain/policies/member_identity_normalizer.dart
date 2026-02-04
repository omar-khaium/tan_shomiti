class MemberIdentityNormalizer {
  static String? normalizePhone(String? input) {
    if (input == null) return null;
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    return digits.isEmpty ? null : digits;
  }

  static String? normalizeNidOrPassport(String? input) {
    if (input == null) return null;
    final trimmed = input.trim();
    if (trimmed.isEmpty) return null;

    final normalized = trimmed
        .replaceAll(RegExp(r'[^0-9A-Za-z]'), '')
        .toUpperCase();
    return normalized.isEmpty ? null : normalized;
  }
}

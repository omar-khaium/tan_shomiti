class MemberIdentityNormalizer {
  static String? normalizePhone(String? input) {
    if (input == null) return null;
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return null;

    // Normalize common Bangladesh formats:
    // - Local: 01XXXXXXXXX
    // - Intl: +8801XXXXXXXXX
    if (digits.startsWith('880') && digits.length == 13) {
      return '0${digits.substring(3)}';
    }

    return digits;
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

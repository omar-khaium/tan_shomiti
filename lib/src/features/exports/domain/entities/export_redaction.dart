class ExportRedaction {
  const ExportRedaction({
    required this.includeFreeTextNotes,
    required this.includeMemberNames,
    required this.includeProofReferences,
  });

  /// Default: do not include free-text notes (privacy).
  final bool includeFreeTextNotes;

  /// Default: do not include member names (privacy).
  final bool includeMemberNames;

  /// Default: include references/ids (non-PII, but still sensitive).
  final bool includeProofReferences;

  Map<String, Object?> toJson() => {
        'includeFreeTextNotes': includeFreeTextNotes,
        'includeMemberNames': includeMemberNames,
        'includeProofReferences': includeProofReferences,
      };

  static ExportRedaction defaults() => const ExportRedaction(
        includeFreeTextNotes: false,
        includeMemberNames: false,
        includeProofReferences: true,
      );
}


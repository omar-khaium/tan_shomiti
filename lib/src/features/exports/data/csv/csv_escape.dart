String csvEscape(String value) {
  final needsQuotes =
      value.contains(',') || value.contains('"') || value.contains('\n');
  if (!needsQuotes) return value;
  final escaped = value.replaceAll('"', '""');
  return '"$escaped"';
}

String csvRow(List<String> columns) =>
    '${columns.map(csvEscape).join(',')}\n';


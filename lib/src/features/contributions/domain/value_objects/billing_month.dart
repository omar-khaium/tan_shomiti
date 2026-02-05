import 'package:flutter/foundation.dart';

@immutable
class BillingMonth implements Comparable<BillingMonth> {
  const BillingMonth({required this.year, required this.month})
    : assert(month >= 1 && month <= 12);

  final int year;
  final int month;

  String get key => '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}';

  BillingMonth next() {
    final nextMonth = month == 12 ? 1 : month + 1;
    final nextYear = month == 12 ? year + 1 : year;
    return BillingMonth(year: nextYear, month: nextMonth);
  }

  BillingMonth previous() {
    final prevMonth = month == 1 ? 12 : month - 1;
    final prevYear = month == 1 ? year - 1 : year;
    return BillingMonth(year: prevYear, month: prevMonth);
  }

  static BillingMonth fromDate(DateTime date) =>
      BillingMonth(year: date.year, month: date.month);

  static BillingMonth fromKey(String key) {
    final parts = key.split('-');
    if (parts.length != 2) {
      throw FormatException('Invalid BillingMonth key: $key');
    }
    final y = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    return BillingMonth(year: y, month: m);
  }

  DateTime get asDateTimeLocal => DateTime(year, month);

  @override
  int compareTo(BillingMonth other) {
    if (year != other.year) return year.compareTo(other.year);
    return month.compareTo(other.month);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillingMonth && year == other.year && month == other.month;

  @override
  int get hashCode => Object.hash(year, month);
}


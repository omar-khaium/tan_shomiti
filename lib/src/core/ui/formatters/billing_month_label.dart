import '../../../features/contributions/domain/value_objects/billing_month.dart';

String formatBillingMonthLabel(BillingMonth month) {
  const names = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final m = month.month;
  final monthName = (m >= 1 && m <= 12) ? names[m - 1] : 'Month';
  return '$monthName ${month.year}';
}


/// Utility function to format a DateTime object to a readable string of format like '25th July 2023'.
String formatDate(DateTime? date) {
  if (date == null) return '-';

  final day = date.day;
  const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final month = monthNames[date.month - 1];
  final year = date.year;

  String daySuffix;
  if (day >= 11 && day <= 13) {
    daySuffix = 'th';
  } else {
    switch (day % 10) {
      case 1:
        daySuffix = 'st';
        break;
      case 2:
        daySuffix = 'nd';
        break;
      case 3:
        daySuffix = 'rd';
        break;
      default:
        daySuffix = 'th';
    }
  }

  return '$day$daySuffix $month $year';
}

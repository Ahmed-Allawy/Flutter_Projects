String formatDate(DateTime date) {
  return '${getMonth(date.month)} ${date.day}, ${date.year}';
}

String getMonth(month) {
  List monthName = [
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
    'Dec'
  ];
  return monthName[month - 1];
}

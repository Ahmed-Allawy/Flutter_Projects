import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

String formatDateFromTimestamp(Timestamp timestamp) {
  return DateFormat.yMMMMd().add_EEEE().format(timestamp.toDate());
}

String formatDateFromTimestampHour(Timestamp timestamp) {
  return DateFormat.jm().format(timestamp.toDate());
}

String formatDateFromTimestampDay(Timestamp timestamp) {
  return DateFormat.d().format(timestamp.toDate());
}

import 'package:intl/intl.dart';

class DateUtils {
  static String getDateText(DateTime? date) {
    if (date == null) return 'Today';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDay = DateTime(date.year, date.month, date.day);
    final difference = selectedDay.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference == -1) return 'Yesterday';

    return getFullDate(selectedDay);
  }

  // (Mon, Tue, ...)
  static String getDayOfWeek(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  // (Jan 15, 2024)
  static String getFullDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  // (Jan 15, 3:30 PM)
  static String getDateTimeText(DateTime date) {
    return DateFormat('MMM d, h:mm a').format(date);
  }
}

class DateTimeUtils {
  // Day names
  static const List<String> _dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  // Month abbreviations
  static const List<String> _monthAbbr = [
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

  /// Get the current day name (e.g., "Monday", "Tuesday")
  static String getCurrentDayName() {
    final now = DateTime.now();
    return _dayNames[now.weekday - 1];
  }

  /// Get the current date in "MMM, dd" format (e.g., "Sep, 25")
  static String getCurrentDate() {
    final now = DateTime.now();
    final month = _monthAbbr[now.month - 1];
    final day = now.day.toString().padLeft(2, '0');
    return '$month, $day';
  }

  /// Get greeting based on current time of day
  static String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  /// Get formatted date and time (e.g., "01-12-2024 14:30:45")
  static String getFormattedDateTime() {
    final now = DateTime.now();
    return '${_padZero(now.day)}-${_padZero(now.month)}-${now.year} '
        '${_padZero(now.hour)}:${_padZero(now.minute)}:${_padZero(now.second)}';
  }

  /// Get formatted time (e.g., "14:30")
  static String getCurrentTime() {
    final now = DateTime.now();
    return '${_padZero(now.hour)}:${_padZero(now.minute)}';
  }

  /// Get formatted date (e.g., "01-12-2024")
  static String getFormattedDate() {
    final now = DateTime.now();
    return '${_padZero(now.day)}-${_padZero(now.month)}-${now.year}';
  }

  /// Helper method to pad single digit numbers with zero
  static String _padZero(int value) {
    return value.toString().padLeft(2, '0');
  }

  /// Get today's date (normalized to midnight)
  static DateTime getToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Get tomorrow's date (normalized to midnight)
  static DateTime getTomorrow() {
    return getToday().add(const Duration(days: 1));
  }

  /// Check if a date is today
  static bool isToday(DateTime date) {
    final today = getToday();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  /// Check if a date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = getTomorrow();
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Formats a DateTime into `Mon dd, yyyy` (e.g., `Nov 5, 2025`)
  static String formatDate(DateTime d) {
    final mm = _monthAbbr[d.month - 1];
    return '$mm ${d.day}, ${d.year}';
  }

  /// Formats a DateTime into `dd/MM/yyyy` with leading zeros
  static String formatDMY(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  /// Parses a date string in `dd/MM/yyyy` format into a DateTime
  /// Returns null if the input is null, empty, or invalid
  static DateTime? parseDate(String? ddMMyyyy) {
    if (ddMMyyyy == null || ddMMyyyy.isEmpty) return null;
    final parts = ddMMyyyy.split('/');
    if (parts.length != 3) return null;
    final d = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final y = int.tryParse(parts[2]);
    if (d == null || m == null || y == null) return null;
    return DateTime(y, m, d);
  }
}

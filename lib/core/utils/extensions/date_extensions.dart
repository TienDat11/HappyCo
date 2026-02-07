/// Date/Time Extensions for Happyco App
///
/// Provides utility methods for DateTime operations
/// Vietnamese locale support included
extension DateTimeExtensions on DateTime {
  /// Format date as Vietnamese string
  /// Example: "01/01/2024"
  String toVietnameseDateFormat() {
    final dayStr = day.toString().padLeft(2, '0');
    final monthStr = month.toString().padLeft(2, '0');
    final year = this.year;
    return '$dayStr/$monthStr/$year';
  }

  /// Format date as Vietnamese string with time
  /// Example: "01/01/2024 14:30"
  String toVietnameseDateTimeFormat() {
    final dateStr = toVietnameseDateFormat();
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$dateStr $hourStr:$minuteStr';
  }

  String toVietnameseAmPmDateTimeFormat() {
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    final hourStr = hour12.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';

    final dayStr = day.toString().padLeft(2, '0');
    final monthStr = month.toString().padLeft(2, '0');
    final yearStr = year.toString();

    return '$hourStr:$minuteStr $period, $dayStr/$monthStr/$yearStr';
  }

  /// Format date as Vietnamese long format
  /// Example: "Tháng 1, 2024"
  String toVietnameseLongFormat() {
    return 'Tháng $month, $year';
  }

  /// Format date as Vietnamese day format
  /// Example: "Thứ Hai, 01/01/2024"
  String toVietnameseDayFormat() {
    final weekday = _getVietnameseWeekday();
    final dateStr = toVietnameseDateFormat();
    return '$weekday, $dateStr';
  }

  /// Get Vietnamese weekday name
  String _getVietnameseWeekday() {
    const weekdays = [
      'Thứ Hai', // Monday (1)
      'Thứ Ba', // Tuesday (2)
      'Thứ Tư', // Wednesday (3)
      'Thứ Năm', // Thursday (4)
      'Thứ Sáu', // Friday (5)
      'Thứ Bảy', // Saturday (6)
      'Chủ Nhật', // Sunday (7)
    ];
    // DateTime.weekday returns 1 for Monday, 7 for Sunday
    return weekdays[weekday - 1];
  }

  /// Get relative time string (time ago)
  /// Example: "5 phút trước", "2 giờ trước", "Hôm qua", "2 ngày trước"
  String timeAgo({bool shortFormat = false}) {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return shortFormat ? 'Vừa xong' : '${difference.inSeconds} giây trước';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return shortFormat ? '${mins}p' : '$mins phút trước';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return shortFormat ? '${hours}h' : '$hours giờ trước';
    } else if (difference.inDays == 1) {
      return shortFormat ? 'Hôm qua' : 'Hôm qua';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return shortFormat ? '$days ngày' : '$days ngày trước';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return shortFormat ? '$weeks tuần' : '$weeks tuần trước';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return shortFormat ? '$months tháng' : '$months tháng trước';
    } else {
      final years = (difference.inDays / 365).floor();
      return shortFormat ? '$years năm' : '$years năm trước';
    }
  }

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return day == yesterday.day &&
        month == yesterday.month &&
        year == yesterday.year;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return day == tomorrow.day &&
        month == tomorrow.month &&
        year == tomorrow.year;
  }

  /// Check if date is in the past
  bool get isPast => isBefore(DateTime.now());

  /// Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());

  /// Get start of day
  DateTime get startOfDay => DateTime(year, month, day, 0, 0, 0, 0, 0);

  /// Get end of day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999, 999);

  /// Get start of week (Monday)
  DateTime get startOfWeek {
    final daysToSubtract = weekday - 1;
    return subtract(Duration(days: daysToSubtract)).startOfDay;
  }

  /// Get end of week (Sunday)
  DateTime get endOfWeek {
    final daysToAdd = 7 - weekday;
    return add(Duration(days: daysToAdd)).endOfDay;
  }

  /// Get start of month
  DateTime get startOfMonth => DateTime(year, month, 1, 0, 0, 0, 0, 0);

  /// Get end of month
  DateTime get endOfMonth {
    final nextMonth =
        month == 12 ? DateTime(year + 1, 1) : DateTime(year, month + 1);
    return nextMonth.subtract(const Duration(microseconds: 1)).endOfDay;
  }

  /// Get age from birthdate
  int get age {
    final now = DateTime.now();
    int years = now.year - year;
    final monthDiff = now.month - month;
    if (monthDiff < 0 || (monthDiff == 0 && now.day < day)) {
      years--;
    }
    return years;
  }

  /// Check if date is weekend (Saturday or Sunday)
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Check if date is weekday (Monday to Friday)
  bool get isWeekday => !isWeekend;

  /// Get difference in days (absolute value)
  int daysBetween(DateTime other) {
    final thisDate = DateTime(year, month, day);
    final otherDate = DateTime(other.year, other.month, other.day);
    return thisDate.difference(otherDate).inDays.abs();
  }

  /// Add working days (skipping weekends)
  DateTime addWorkingDays(int days) {
    var result = this;
    var remainingDays = days.abs();
    final step = days >= 0 ? 1 : -1;

    while (remainingDays > 0) {
      result = result.add(Duration(days: step));
      if (!result.isWeekend) {
        remainingDays--;
      }
    }

    return result;
  }

  /// Format to ISO 8601 string
  String toIso8601String() {
    final monthStr = month.toString().padLeft(2, '0');
    final dayStr = day.toString().padLeft(2, '0');
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    final secondStr = second.toString().padLeft(2, '0');
    return '$year-$monthStr-${dayStr}T$hourStr:$minuteStr:$secondStr';
  }

  /// Get quarter of year (1-4)
  int get quarter => ((month - 1) / 3).floor() + 1;

  /// Get week of year (1-53)
  int get weekOfYear {
    final dayOfYear = difference(DateTime(year, 1, 1)).inDays + 1;
    final weekNumber = ((dayOfYear - weekday + 10) / 7).floor();
    return weekNumber > 0 ? weekNumber : 52;
  }

  /// Check if two dates are the same day
  bool isSameDay(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }

  /// Check if two dates are in the same month
  bool isSameMonth(DateTime other) {
    return month == other.month && year == other.year;
  }

  /// Check if two dates are in the same year
  bool isSameYear(DateTime other) {
    return year == other.year;
  }
}

/// Nullable DateTime Extensions
extension NullableDateTimeExtensions on DateTime? {
  /// Returns true if datetime is null
  bool get isNullOrEmpty => this == null;

  /// Returns false if datetime is null
  bool get isNotNullOrEmpty => this != null;

  /// Returns current DateTime if null, otherwise the original DateTime
  DateTime get orNow => this ?? DateTime.now();

  /// Returns defaultValue if null, otherwise the original DateTime
  DateTime orDefault(DateTime defaultValue) {
    return this ?? defaultValue;
  }

  /// Format to Vietnamese string, or empty string if null
  String toVietnameseDateFormatOrNull() {
    return this?.toVietnameseDateFormat() ?? '';
  }

  /// Get time ago string, or empty string if null
  String timeAgoOrNull({bool shortFormat = false}) {
    return this?.timeAgo(shortFormat: shortFormat) ?? '';
  }
}

/// Duration Extensions for human-readable output
extension DurationExtensions on Duration {
  /// Format duration as human-readable string
  /// Example: "1h 30m 45s"
  String toHumanReadable({bool abbreviate = true}) {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    final buffer = StringBuffer();

    if (hours > 0) {
      buffer.write('$hours${abbreviate ? 'h' : ' giờ '}');
    }
    if (minutes > 0) {
      buffer.write('$minutes${abbreviate ? 'p' : ' phút '}');
    }
    if (seconds > 0 || buffer.isEmpty) {
      buffer.write('$seconds${abbreviate ? 's' : ' giây'}');
    }

    return buffer.toString().trim();
  }

  /// Format duration as compact string
  /// Example: "1:30:45" (hours:minutes:seconds)
  String toCompactFormat() {
    final hours = inHours.toString().padLeft(2, '0');
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}

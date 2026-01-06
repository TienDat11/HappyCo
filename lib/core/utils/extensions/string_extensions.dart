import 'dart:typed_data';

/// String Extensions for Happyco App
///
/// Provides utility methods for common string operations
/// Following flutter-architect pattern: Use extensions, not helper classes
extension StringExtensions on String {
  /// Check if string is a valid email address
  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(this);
  }

  /// Check if string is a valid Vietnamese phone number
  /// Supports formats: 0xxxxxxxxx, +84xxxxxxxxx, 84xxxxxxxxx
  bool get isValidPhoneNumber {
    final phoneRegExp = RegExp(r'^(0|\+84|84)[0-9]{9,10}$');
    return phoneRegExp.hasMatch(this);
  }

  /// Check if string contains only numbers
  bool get isNumeric {
    final numericRegExp = RegExp(r'^[0-9]+$');
    return numericRegExp.hasMatch(this);
  }

  /// Format string as currency (Vietnamese Dong)
  /// Example: "5000000" -> "5.000.000 ₫"
  String toCurrency({String symbol = '₫'}) {
    if (isEmpty) return '0 $symbol';
    final numeric = replaceAll(RegExp(r'[^\d]'), '');
    if (numeric.isEmpty) return '0 $symbol';

    final value = int.tryParse(numeric) ?? 0;
    final formatted = value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return '$formatted $symbol';
  }

  /// Format string as price (currency without symbol)
  /// Example: "5000000" -> "5.000.000"
  String toPrice() {
    if (isEmpty) return '0';
    final numeric = replaceAll(RegExp(r'[^\d]'), '');
    if (numeric.isEmpty) return '0';

    final value = int.tryParse(numeric) ?? 0;
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  /// Capitalize first letter of string
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Capitalize first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Truncate string to specified length and add ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return substring(0, maxLength) + suffix;
  }

  /// Remove all whitespace from string
  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Remove all diacritics (accents) from Vietnamese text
  /// Example: "Xin chào" -> "Xin chao"
  String get removeDiacritics {
    const vietnameseMap = {
      'à': 'a', 'á': 'a', 'ả': 'a', 'ã': 'a', 'ạ': 'a',
      'ă': 'a', 'ằ': 'a', 'ắ': 'a', 'ẳ': 'a', 'ẵ': 'a', 'ặ': 'a',
      'â': 'a', 'ầ': 'a', 'ấ': 'a', 'ẩ': 'a', 'ẫ': 'a', 'ậ': 'a',
      'è': 'e', 'é': 'e', 'ẻ': 'e', 'ẽ': 'e', 'ẹ': 'e',
      'ê': 'e', 'ề': 'e', 'ế': 'e', 'ể': 'e', 'ễ': 'e', 'ệ': 'e',
      'ì': 'i', 'í': 'i', 'ỉ': 'i', 'ĩ': 'i', 'ị': 'i',
      'ò': 'o', 'ó': 'o', 'ỏ': 'o', 'õ': 'o', 'ọ': 'o',
      'ô': 'o', 'ồ': 'o', 'ố': 'o', 'ổ': 'o', 'ỗ': 'o', 'ộ': 'o',
      'ơ': 'o', 'ờ': 'o', 'ớ': 'o', 'ở': 'o', 'ỡ': 'o', 'ợ': 'o',
      'ù': 'u', 'ú': 'u', 'ủ': 'u', 'ũ': 'u', 'ụ': 'u',
      'ư': 'u', 'ừ': 'u', 'ứ': 'u', 'ử': 'u', 'ữ': 'u', 'ự': 'u',
      'ỳ': 'y', 'ý': 'y', 'ỷ': 'y', 'ỹ': 'y', 'ỵ': 'y',
      'đ': 'd',
      'À': 'A', 'Á': 'A', 'Ả': 'A', 'Ã': 'A', 'Ạ': 'A',
      'Ă': 'A', 'Ằ': 'A', 'Ắ': 'A', 'Ẳ': 'A', 'Ẵ': 'A', 'Ặ': 'A',
      'Â': 'A', 'Ầ': 'A', 'Ấ': 'A', 'Ẩ': 'A', 'Ẫ': 'A', 'Ậ': 'A',
      'È': 'E', 'É': 'E', 'Ẻ': 'E', 'Ẽ': 'E', 'Ẹ': 'E',
      'Ê': 'E', 'Ề': 'E', 'Ế': 'E', 'Ể': 'E', 'Ễ': 'E', 'Ệ': 'E',
      'Ì': 'I', 'Í': 'I', 'Ỉ': 'I', 'Ĩ': 'I', 'Ị': 'I',
      'Ò': 'O', 'Ó': 'O', 'Ỏ': 'O', 'Õ': 'O', 'Ọ': 'O',
      'Ô': 'O', 'Ồ': 'O', 'Ố': 'O', 'Ổ': 'O', 'Ỗ': 'O', 'Ộ': 'O',
      'Ơ': 'O', 'Ờ': 'O', 'Ớ': 'O', 'Ở': 'O', 'Ỡ': 'O', 'Ợ': 'O',
      'Ù': 'U', 'Ú': 'U', 'Ủ': 'U', 'Ũ': 'U', 'Ụ': 'U',
      'Ư': 'U', 'Ừ': 'U', 'Ứ': 'U', 'Ử': 'U', 'Ữ': 'U', 'Ự': 'U',
      'Ỳ': 'Y', 'Ý': 'Y', 'Ỷ': 'Y', 'Ỹ': 'Y', 'Ỵ': 'Y',
      'Đ': 'D',
    };

    String result = this;
    vietnameseMap.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    return result;
  }

  /// Convert string to URL-safe slug
  /// Example: "Bàn ăn gỗ sồi" -> "ban-an-go-soi"
  String get toSlug {
    return removeDiacritics
        .toLowerCase()
        .removeWhitespace
        .replaceAll(RegExp(r'[^\w\-]+'), '-')
        .replaceAll(RegExp(r'\-+'), '-')
        .replaceAll(RegExp(r'^\-|\-?$'), '');
  }

  /// Mask string for security (e.g., credit card, phone number)
  /// Example: "0123456789".mask(keepLast: 3) -> "******6789"
  String mask({int keepLast = 4, String maskChar = '*'}) {
    if (length <= keepLast) return this;
    final masked = List.filled(length - keepLast, maskChar).join();
    return '$masked${substring(length - keepLast)}';
  }

  /// Get initials from string (for avatars)
  /// Example: "Nguyen Van A" -> "NA"
  String get initials {
    if (isEmpty) return '';
    final parts = trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    return parts.take(2).map((part) => part[0].toUpperCase()).join();
  }

  /// Check if string is empty or only whitespace
  bool get isBlank => trim().isEmpty;

  /// Check if string is not empty and not only whitespace
  bool get isNotBlank => trim().isNotEmpty;

  /// Count words in string
  int get wordCount {
    if (isBlank) return 0;
    return trim().split(RegExp(r'\s+')).length;
  }

  /// Reverse string
  String get reversed => split('').reversed.join('');

  /// Get bytes from string (UTF-8)
  Uint8List get bytes => Uint8List.fromList(codeUnits);

  /// Check if string is a valid URL
  bool get isValidUrl {
    try {
      final uri = Uri.parse(this);
      return uri.hasScheme && uri.hasAuthority;
    } catch (_) {
      return false;
    }
  }

  /// Parse string to int with default value
  int toIntOrDefault({int defaultValue = 0}) {
    return int.tryParse(this) ?? defaultValue;
  }

  /// Parse string to double with default value
  double toDoubleOrDefault({double defaultValue = 0.0}) {
    return double.tryParse(this) ?? defaultValue;
  }

  /// Safe substring - won't throw if index out of bounds
  String safeSubstring(int start, [int? end]) {
    if (start > length) return this;
    if (end == null || end > length) return substring(start);
    return substring(start, end);
  }
}

/// Nullable String Extensions
extension NullableStringExtensions on String? {
  /// Returns true if string is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns false if string is null or empty
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  /// Returns empty string if null, otherwise the original string
  String get orEmpty => this ?? '';

  /// Returns defaultValue if null or empty, otherwise the original string
  String orDefault(String defaultValue) {
    if (isNullOrEmpty) return defaultValue;
    return this!;
  }
}

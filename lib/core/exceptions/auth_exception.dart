class AuthException implements Exception {
  final String message;
  final Map<String, String>? fieldErrors;

  AuthException(this.message, {this.fieldErrors});

  String? getFieldError(String fieldName) => fieldErrors?[fieldName];

  @override
  String toString() => 'AuthException: $message';
}

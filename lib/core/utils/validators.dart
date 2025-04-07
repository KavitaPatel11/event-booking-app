class Validators {
  static String? validateEmail(String? value) {
    if (value == null || !value.contains('@')) return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) return 'Minimum 6 characters';
    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) return 'Required field';
    return null;
  }
}

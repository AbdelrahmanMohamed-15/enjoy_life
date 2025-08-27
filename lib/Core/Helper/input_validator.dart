class InputValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }

    return null;
  }

  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm password is required';
    }

    if (value != originalPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? validateNotEmpty(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  static String? validateInstaPayLink(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'InstaPay link is required';
    }

    final RegExp instapayRegExp = RegExp(
      r'^(https?:\/\/)?(www\.)?instapay\.eg\/\S+$',
    );

    if (!instapayRegExp.hasMatch(value.trim())) {
      return 'Enter a valid InstaPay link';
    }

    return null;
  }

  static String? validateLinkedInLink(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'LinkedIn profile link is required';
    }

    final RegExp linkedInRegExp = RegExp(
      r'^(https?:\/\/)?(www\.)?linkedin\.com\/in\/[A-z0-9_-]+\/?$',
    );

    if (!linkedInRegExp.hasMatch(value.trim())) {
      return 'Enter a valid LinkedIn profile link';
    }

    return null;
  }
}

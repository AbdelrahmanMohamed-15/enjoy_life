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

  // ------------------------
  //     NEW VALIDATORS
  // ------------------------

  /// Validate Name (letters + spaces only)
  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    if (!nameRegExp.hasMatch(value.trim())) {
      return 'Enter a valid $fieldName';
    }

    return null;
  }

  /// Validate Price (must be number, > 0)
  static String? validatePrice(String? value, {String fieldName = 'Price'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final num? price = num.tryParse(value);

    if (price == null) {
      return '$fieldName must be a number';
    }

    if (price <= 0) {
      return '$fieldName must be greater than 0';
    }

    return null;
  }

  /// Validate Time (HH:mm format)
  static String? validateTime(String? value, {String fieldName = 'Time'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final RegExp timeRegExp = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');

    if (!timeRegExp.hasMatch(value.trim())) {
      return 'Enter a valid $fieldName (HH:mm)';
    }

    return null;
  }

  /// Validate Date (YYYY-MM-DD)
  static String? validateDate(String? value, {String fieldName = 'Date'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');

    if (!dateRegExp.hasMatch(value.trim())) {
      return 'Enter a valid $fieldName (YYYY-MM-DD)';
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

  /// Validate numbers only (integer)
  static String? validateNumbers(String? value, {String fieldName = 'Value'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final RegExp numberRegExp = RegExp(r'^[0-9]+$');

    if (!numberRegExp.hasMatch(value.trim())) {
      return '$fieldName must contain numbers only';
    }

    return null;
  }
}

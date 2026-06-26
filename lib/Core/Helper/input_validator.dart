import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

class InputValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationEmailRequired.tr();
    }

    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value.trim())) {
      return LocaleKeys.validationEmailInvalid.tr();
    }

    return null;
  }

  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationPasswordRequired.tr();
    }

    if (value.length < minLength) {
      return LocaleKeys.validationPasswordMinLength.tr(
        namedArgs: {'length': minLength.toString()},
      );
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationConfirmRequired.tr();
    }

    if (value != originalPassword) {
      return LocaleKeys.validationPasswordsMismatch.tr();
    }

    return null;
  }

  static String? validateNotEmpty(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    return null;
  }

  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    if (!nameRegExp.hasMatch(value.trim())) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    return null;
  }

  static String? validatePrice(String? value, {String fieldName = 'Price'}) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    final num? price = num.tryParse(value);

    if (price == null || price <= 0) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    return null;
  }

  static String? validateTime(String? value, {String fieldName = 'Time'}) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    final RegExp timeRegExp = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');

    if (!timeRegExp.hasMatch(value.trim())) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    return null;
  }

  static String? validateDate(String? value, {String fieldName = 'Date'}) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    final RegExp dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');

    if (!dateRegExp.hasMatch(value.trim())) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    return null;
  }

  static String? validateInstaPayLink(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    final RegExp instapayRegExp = RegExp(
      r'^(https?:\/\/)?(www\.)?instapay\.eg\/\S+$',
    );

    if (!instapayRegExp.hasMatch(value.trim())) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    return null;
  }

  static String? validateLinkedInLink(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    final RegExp linkedInRegExp = RegExp(
      r'^(https?:\/\/)?(www\.)?linkedin\.com\/in\/[A-z0-9_-]+\/?$',
    );

    if (!linkedInRegExp.hasMatch(value.trim())) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    return null;
  }

  static String? validateNumbers(String? value, {String fieldName = 'Value'}) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    final RegExp numberRegExp = RegExp(r'^[0-9]+$');

    if (!numberRegExp.hasMatch(value.trim())) {
      return LocaleKeys.validationFieldRequired.tr();
    }

    return null;
  }
}

import 'package:flutter/material.dart';

class AppColors {
  /// Primary color shades derived from base color #FF7900.
  static const primary700 = Color(0xFFE66D00);
  static const primary600 = Color(0xFFF07200);
  static const primary500 = Color(0xFFFF7900); // Base color
  static const primary400 = Color(0xFFFF8C33);
  static const primary300 = Color(0xFFFFA766);
  static const primary200 = Color(0xFFFFC299);
  static const primary100 = Color(0xFFFFDCCC);

  /// Secondary color shades (you can adjust these if needed).
  static const secondary700 = Color(0xFF6BA9D1);
  static const secondary600 = Color(0xFF76B0D6);
  static const secondary500 = Color(0xFF8EC1E0); // Base color
  static const secondary400 = Color(0xFFA3CDE6);
  static const secondary300 = Color(0xFFB8D9EC);
  static const secondary200 = Color(0xFFCCE5F2);
  static const secondary100 = Color(0xFFE1F1F8);

  /// Natural colors (unchanged).
  static const natural700 = Color(0xff262626);
  static const natural600 = Color(0xff515151);
  static const natural500 = Color(0xff7D7D7D);
  static const iconPrimary = primary500;
  static const natural400 = Color(0xffA8A8A8);
  static const grayDark = Color(0xff4E4A4A);
  static const black700 = Color(0xff1C1F28);
  static const natural300 = Color(0xffD4D4D4);
  static const natural200 = Color(0xffE9E9E9);
  static const natural100 = Color(0xffffffff);
  static const slider = Color(0xffDDDDDD);
  static const blue = Color(0xff2675EC);
  static const backgroundColor = Color(0xffF6F9FC);

  /// Round button border color.
  static const Color roundButtonBorderColor = primary500;

  /// Black text color.
  static const textBlack = Colors.black;

  /// Error color.
  static const errorColor = Color(0xffEB5757);
  static const darkRed = Color(0xffFF0E00);

  /// Background colors.
  static const scaffoldBackgroundColor = Color(0xff00072C);
  static const textFieldBackgroundColor = Color(0xffFAFAFA);

  /// Custom Material Color.
  static const MaterialColor primaryMaterialColor =
      MaterialColor(0xFFFF7900, <int, Color>{
        100: primary100,
        200: primary200,
        300: primary300,
        400: primary400,
        500: primary500,
        600: primary600,
        700: primary700,
      });
}

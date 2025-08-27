import 'package:flutter/material.dart';

import '../app_colors.dart';

class InputDecorationThemeStyles {
  static const Radius borderRadius = Radius.circular(5);

  static const InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    labelStyle: TextStyle(
      color: AppColors.natural600,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
    floatingLabelStyle: TextStyle(
      color: AppColors.textBlack,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
    // TextStyle? helperStyle,
    // int? helperMaxLines,
    // TextStyle? hintStyle,
    // TextStyle? errorStyle,
    // int? errorMaxLines,
    // FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.auto,
    // FloatingLabelAlignment floatingLabelAlignment =
    // FloatingLabelAlignment.start,
    // bool isDense = false,
    // EdgeInsetsGeometry? contentPadding,
    // bool isCollapsed = false,
    // Color? iconColor,
    // TextStyle? prefixStyle,
    // Color? prefixIconColor,
    // TextStyle? suffixStyle,
    // Color? suffixIconColor,
    // TextStyle? counterStyle,
    /*filled: true,
    fillColor: AppColors.textFieldBackgroundColor,*/
    // BorderSide? activeIndicatorBorder,
    // BorderSide? outlineBorder,
    // Color? focusColor,
    // Color? hoverColor,
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.textBlack,),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.errorColor,
      ),
      borderRadius: BorderRadius.only(
        topLeft: borderRadius,
        topRight: borderRadius,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.textBlack,
      ),
      borderRadius: BorderRadius.only(
        topLeft: borderRadius,
        topRight: borderRadius,
      ),
    ),
    // InputBorder? focusedErrorBorder,
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.natural300,
      ),
      borderRadius: BorderRadius.only(
        topLeft: borderRadius,
        topRight: borderRadius,
      ),
    ),
    // InputBorder? enabledBorder,
    // bool alignLabelWithHint = false,
    // BoxConstraints? constraints,
  );
}

import 'package:flutter/material.dart';
import '../../Core/Themes/Styles/app_bar_theme_styles.dart';
import '../../Core/Themes/Styles/button_theme_styles.dart';
import '../../Core/Themes/Styles/dialog_theme_styles.dart';
import '../../Core/Themes/Styles/snackbar_theme_styles.dart';
import '../../Core/Themes/Styles/text_theme_styles.dart';
import '../../Core/Themes/app_colors.dart';
import '../Constant/base_constant.dart';

class AppThemes {
  /// --------------------------------------------------------------
  /// DARK THEME (but actually light mode based on your colors)
  /// --------------------------------------------------------------

  static final darkTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.natural100,

    // ----------------------------------
    // COLOR SCHEME
    // ----------------------------------
    colorScheme: ColorScheme.light(
      primary: AppColors.primary500,
      secondary: AppColors.secondary300,
      error: AppColors.errorColor,
      surface: AppColors.natural100,
      onSurface: AppColors.black700,
    ),

    // ----------------------------------
    // GLOBAL COLORS
    // ----------------------------------
    dividerColor: AppColors.natural200,
    focusColor: AppColors.primary100,
    hintColor: AppColors.natural700,
    indicatorColor: AppColors.primary500,
    disabledColor: Colors.grey.shade300,

    // ----------------------------------
    // TEXT THEME
    // ----------------------------------
    textTheme: _buildTextTheme(),

    // ----------------------------------
    // COMPONENT THEMES
    // ----------------------------------
    appBarTheme: AppBarThemeStyles.appBarTheme,
    dialogTheme: DialogThemeStyles.dialogTheme,
    snackBarTheme: SnackbarThemeStyles.snackBarThemeData,
    elevatedButtonTheme: ButtonThemeStyles.elevatedButtonTheme,
    textButtonTheme: ButtonThemeStyles.textButtonTheme,
    outlinedButtonTheme: ButtonThemeStyles.outlinedButtonTheme,
    floatingActionButtonTheme: ButtonThemeStyles.floatingActionButtonTheme,

    // ----------------------------------
    // INPUT FIELD STYLE
    // ----------------------------------
    inputDecorationTheme: _inputDecorationTheme,

    // ----------------------------------
    // FIX DROPDOWN PURPLE HIGHLIGHT
    // ----------------------------------
    highlightColor: AppColors.primary500.withOpacity(0.1),
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );

  /// --------------------------------------------------------------
  /// LIGHT THEME — (prepare for future)
  /// --------------------------------------------------------------
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: AppColors.primary500,
  );

  /// --------------------------------------------------------------
  /// PRIVATE HELPERS
  /// --------------------------------------------------------------

  /// CLEAN TEXT THEME
  static TextTheme _buildTextTheme() {
    return TextTheme(
      displayLarge: TextThemeStyles.displayLarge.copyWith(
        color: AppColors.primary500,
      ),
      displayMedium: TextThemeStyles.displayMedium.copyWith(
        color: AppColors.primary500,
      ),
      displaySmall: TextThemeStyles.displaySmall.copyWith(
        color: AppColors.primary500,
      ),

      headlineLarge: TextThemeStyles.headlineLarge.copyWith(
        color: AppColors.primary500,
      ),
      headlineMedium: TextThemeStyles.headlineMedium.copyWith(
        color: AppColors.primary500,
      ),
      headlineSmall: TextThemeStyles.headlineSmall.copyWith(
        color: AppColors.primary500,
      ),

      titleLarge: TextThemeStyles.titleLarge.copyWith(
        color: AppColors.primary500,
      ),
      titleMedium: TextThemeStyles.titleMedium.copyWith(
        color: AppColors.primary500,
      ),
      titleSmall: TextThemeStyles.titleSmall.copyWith(
        color: AppColors.primary500,
      ),

      bodyLarge: TextThemeStyles.bodyText18.copyWith(
        color: AppColors.primary500,
      ),
      bodyMedium: TextThemeStyles.bodyText14.copyWith(
        color: AppColors.black700,
      ),
      bodySmall: TextThemeStyles.bodyText12.copyWith(color: AppColors.black700),

      labelLarge: TextThemeStyles.labelLarge.copyWith(
        color: AppColors.primary500,
      ),
      labelMedium: TextThemeStyles.labelMedium.copyWith(
        color: AppColors.primary500,
      ),
      labelSmall: TextThemeStyles.labelSmall.copyWith(
        color: AppColors.natural300,
      ),
    );
  }

  /// CLEAN INPUT DECORATION STYLES
  static const _inputDecorationTheme = InputDecorationTheme(
    prefixIconColor: AppColors.secondary300,
    suffixIconColor: AppColors.secondary300,
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    hintStyle: TextStyle(
      fontFamily: BaseConstant.cairoRegular,
      fontSize: 14.0,
      color: AppColors.natural300,
    ),
    labelStyle: TextStyle(
      fontFamily: BaseConstant.cairoBold,
      fontSize: 14.0,
      color: AppColors.natural300,
    ),
    errorStyle: TextStyle(
      fontFamily: BaseConstant.cairoRegular,
      fontSize: 14.0,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.natural500),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.errorColor),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.natural100),
    ),
  );
}

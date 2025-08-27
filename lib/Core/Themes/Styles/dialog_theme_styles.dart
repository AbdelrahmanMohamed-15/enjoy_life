import '../../../Core/Themes/Styles/text_theme_styles.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

class DialogThemeStyles {
  static DialogThemeData dialogTheme = const DialogThemeData(
    backgroundColor: AppColors.natural100,
    // double? elevation,
    // Color? shadowColor,
    // Color? surfaceTintColor,
    // ShapeBorder? shape,
    // AlignmentGeometry? alignment,
    // Color? iconColor,
    titleTextStyle: TextThemeStyles.titleLarge,
    contentTextStyle: TextThemeStyles.titleMedium,
    // EdgeInsetsGeometry? actionsPadding,
  );
}

import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppBarThemeStyles {
  static final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: AppColors.natural100,
    elevation: 0,
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: AppColors.textBlack,
      height: 28 / 20,
    ),
    shadowColor: Colors.black.withOpacity(0.15),
  );
}

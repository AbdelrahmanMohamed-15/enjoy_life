import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

class ButtonThemeStyles {
  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      backgroundColor: AppColors.primary500,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      textStyle: const TextStyle(
        fontFamily: 'Cairo-Bold',
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );

  static FloatingActionButtonThemeData floatingActionButtonTheme =
      const FloatingActionButtonThemeData();

  static OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(width: 1.w, color: AppColors.roundButtonBorderColor),
      foregroundColor: AppColors.primary500,
      // Elevation on a transparent button renders as a grey tinted fill in
      // Material 3, so outlined buttons stay flat
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.roundButtonBorderColor, width: 10.w),
        borderRadius: BorderRadius.circular(33.r),
      ),
    ),
  );

  static TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(),
    // style: TextButton.styleFrom(
    //   foregroundColor: AppColors.textButtonTextColor,
    //   textStyle: const TextStyle(
    //     fontFamily: ThemeConstants.fontFamily,
    //     fontWeight: FontWeight.w700,
    //     fontSize: 14,
    //   ),
    // ),
  );
}

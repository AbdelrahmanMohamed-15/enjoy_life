import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Routes/app_navigation.dart';
import '../Themes/app_colors.dart';

void showCustomSnackBar(
  String message, {
  Color? backgroundColor,
  Color? color,
}) {
  final context = AppNavigation.navigatorKey.currentContext;
  if (context == null) return;

  // Check if the context is still mounted
  if (!context.mounted) return;

  final snackBar = SnackBar(
    duration: const Duration(seconds: 2),
    content: Text(
      message,
      style: TextStyle(
        color: color ?? AppColors.natural200, // Replace with your desired color
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.start,
    ),
    backgroundColor: backgroundColor ?? AppColors.natural200,
    behavior: SnackBarBehavior.floating,
    elevation: 20,
    action: SnackBarAction(
      label: '',
      disabledTextColor: Colors.white,
      textColor: AppColors.secondary100,
      onPressed: () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
    ),
  );

  try {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } catch (e) {
    // Silently fail if context is no longer valid
    debugPrint('Error showing snackbar: $e');
  }
}

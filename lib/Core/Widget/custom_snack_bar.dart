import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Routes/app_navigation.dart';
import '../Themes/app_colors.dart';

enum SnackBarType { success, error, warning, info }

String? _lastMessage;
DateTime? _lastShownAt;

/// Shows a snackbar that replaces the current one right away (no queue),
/// hides itself after [duration] and can be swiped or closed by the user.
///
/// When [type] is not given it is guessed from [backgroundColor], so the
/// existing calls keep working: darkRed is an error, primary is a success.
void showCustomSnackBar(
  String message, {
  Color? backgroundColor,
  Color? color,
  SnackBarType? type,
  Duration? duration,
}) {
  if (message.trim().isEmpty) return;

  final context = AppNavigation.navigatorKey.currentContext;
  if (context == null || !context.mounted) return;

  // Skip the same message fired twice in a row (e.g. two failed requests)
  final now = DateTime.now();
  if (_lastMessage == message &&
      _lastShownAt != null &&
      now.difference(_lastShownAt!) < const Duration(seconds: 1)) {
    return;
  }
  _lastMessage = message;
  _lastShownAt = now;

  final snackType = type ?? _typeFromColor(backgroundColor);
  final bgColor = backgroundColor ?? _colorOf(snackType);
  final fgColor =
      color ??
      (bgColor.computeLuminance() > 0.6 ? AppColors.black700 : Colors.white);

  final ScaffoldMessengerState messenger;
  try {
    messenger = ScaffoldMessenger.of(context);
  } catch (e) {
    debugPrint('Error showing snackbar: $e');
    return;
  }

  final snackBar = SnackBar(
    duration:
        duration ??
        (snackType == SnackBarType.error
            ? const Duration(seconds: 4)
            : const Duration(milliseconds: 2500)),
    // Without this a snackbar with a close button would never hide itself
    persist: false,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.horizontal,
    backgroundColor: bgColor,
    elevation: 6,
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    content: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: fgColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(_iconOf(snackType), color: fgColor, size: 20),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            message,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: fgColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: messenger.hideCurrentSnackBar,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              Icons.close,
              size: 18,
              color: fgColor.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    ),
  );

  messenger
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}

SnackBarType _typeFromColor(Color? color) {
  if (color == null) return SnackBarType.info;
  if (color == AppColors.darkRed) return SnackBarType.error;
  if (color == AppColors.primary400 || color == AppColors.primary500) {
    return SnackBarType.success;
  }
  return SnackBarType.info;
}

Color _colorOf(SnackBarType type) {
  switch (type) {
    case SnackBarType.success:
      return AppColors.primary400;
    case SnackBarType.error:
      return AppColors.darkRed;
    case SnackBarType.warning:
      return const Color(0xFFF5A623);
    case SnackBarType.info:
      return AppColors.black700;
  }
}

IconData _iconOf(SnackBarType type) {
  switch (type) {
    case SnackBarType.success:
      return Icons.check_circle_outline;
    case SnackBarType.error:
      return Icons.error_outline;
    case SnackBarType.warning:
      return Icons.warning_amber_rounded;
    case SnackBarType.info:
      return Icons.info_outline;
  }
}

import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Themes/app_colors.dart';

/// Asks for confirmation, then clears the session and restarts from splash.
Future<void> confirmLogout(BuildContext context) async {
  var theme = Theme.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      icon: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary500.withValues(alpha: 0.1),
        ),
        child: const Icon(
          Icons.logout_rounded,
          color: AppColors.primary500,
          size: 28,
        ),
      ),
      title: Text(
        LocaleKeys.profileLogoutTitle.tr(),
        style: theme.textTheme.titleMedium?.copyWith(
          color: AppColors.black700,
          fontFamily: BaseConstant.cairoBold,
        ),
      ),
      content: Text(
        LocaleKeys.profileLogoutMessage.tr(),
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.natural500,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(
            LocaleKeys.commonCancel.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.natural600,
            ),
          ),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(
            LocaleKeys.profileLogout.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      ],
    ),
  );
  if (confirmed != true) return;
  await DependencyInjectionHelper().sl<AuthHandlerInterface>().clearAllData();
  AppNavigation.pushNamedAndRemoveUntil(AppRoutes.splash);
}

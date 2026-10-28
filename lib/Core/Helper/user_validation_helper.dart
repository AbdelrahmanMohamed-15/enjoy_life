import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/routes.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../Constant/base_constant.dart';
import '../Handler/auth_handler.dart';
import '../Themes/app_colors.dart';

class UserValidationHelper {
  final DependencyInjectionHelper di = DependencyInjectionHelper();

  static bool checkUserValidation() {
    Userdata? userData = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    if (userData == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> showUserValidation() {
    return showModalBottomSheet(
      context: AppNavigation.globalContext,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        var theme = Theme.of(sheetContext);
        // Close the sheet first, so it is not still open when coming back
        void go(String route) {
          Navigator.pop(sheetContext);
          AppNavigation.pushNamed(route);
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SheetHandle(),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary100.withValues(alpha: 0.6),
                  ),
                  child: const Icon(
                    Icons.lock_person_rounded,
                    color: AppColors.primary600,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  LocaleKeys.mainNavLoginRequired.tr(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.black700,
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
                const SizedBox(height: 20),
                AppGradientButton(
                  label: LocaleKeys.mainNavLoginButton.tr(),
                  icon: Icons.login_rounded,
                  onTap: () => go(AppRoutes.login),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => go(AppRoutes.register),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary600,
                  ),
                  child: Text(
                    LocaleKeys.authLoginCreateAccount.tr(),
                    style: const TextStyle(fontFamily: BaseConstant.cairoBold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

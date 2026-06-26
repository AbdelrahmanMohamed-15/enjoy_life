import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/routes.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
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

  static showUserValidation() {
    showModalBottomSheet(
      context: AppNavigation.globalContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        var theme = Theme.of(AppNavigation.globalContext);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.mainNavLoginRequired.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.black700,
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
                const SizedBox(height: 20),
                MainAppButton(
                  bgColor: AppColors.primary400,
                  child: Text(
                    LocaleKeys.mainNavLoginButton.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.natural100,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                  onTap: () {
                    AppNavigation.pushNamed(AppRoutes.login);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

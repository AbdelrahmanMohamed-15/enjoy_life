import 'package:easy_life/Core/Constant/assets_strings.dart';
import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Shared layout of the sign-in, sign-up and password screens: an orange
/// header with the logo and a white sheet holding the form.
class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final Widget? footer;
  final VoidCallback? onBack;
  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.footer,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final canPop = Navigator.of(context).canPop();
    final topInset = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, topInset + 8, 16, 56),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary300, AppColors.primary600],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 44,
                    child: Row(
                      children: [
                        if (canPop)
                          IconButton(
                            onPressed: onBack ?? () => AppNavigation.pop(),
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        const Spacer(),
                        // Nothing to go back to (e.g. the session expired):
                        // let the user keep browsing as a guest
                        if (!canPop)
                          TextButton(
                            onPressed: () =>
                                AppNavigation.pushNamedAndRemoveUntil(
                                  AppRoutes.mainNav,
                                  predicate: (_) => false,
                                ),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              LocaleKeys.authContinueAsGuest.tr(),
                              style: const TextStyle(
                                fontFamily: BaseConstant.cairoBold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Image.asset(AssetsStrings.appLogo, height: 72),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: AppColors.black700,
                        fontFamily: BaseConstant.cairoBold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.natural500,
                      ),
                    ),
                    const SizedBox(height: 28),
                    ...children,
                    if (footer != null) ...[
                      const SizedBox(height: 24),
                      footer!,
                    ],
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Don't have an account? Create account" style link row.
class AuthSwitchLink extends StatelessWidget {
  final String text;
  final String action;
  final VoidCallback onTap;
  const AuthSwitchLink({
    super.key,
    required this.text,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(color: AppColors.natural600, fontSize: 14),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary600,
            padding: const EdgeInsets.symmetric(horizontal: 6),
          ),
          child: Text(
            action,
            style: const TextStyle(
              fontFamily: BaseConstant.cairoBold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

/// Eye button that toggles password visibility.
class PasswordToggle extends StatelessWidget {
  final bool obscured;
  final VoidCallback onTap;
  const PasswordToggle({
    super.key,
    required this.obscured,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        obscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
        color: AppColors.natural500,
        size: 20,
      ),
    );
  }
}

import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/delete_bottom_sheet.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/language_bottom_sheet.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/profile_header.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/profile_menu_section.dart';
import 'package:easy_life/Features/Profile/Presentation/cubit/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Helper/user_validation_helper.dart';
import '../../../../Core/Themes/app_colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = ProfileCubit.get(context);
    var theme = Theme.of(context);
    final isLoggedIn = UserValidationHelper.checkUserValidation() == true;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) => ProfileHeader(
                userData: DependencyInjectionHelper()
                    .sl<AuthHandlerInterface>()
                    .getUserData(),
                onEdit: () async {
                  if (UserValidationHelper.checkUserValidation() == true) {
                    await AppNavigation.pushNamed(AppRoutes.editProfile);
                    profileCubit.refreshUserData();
                  } else {
                    UserValidationHelper.showUserValidation();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 24),
              child: Column(
                children: [
                  if (isLoggedIn) ...[
                    ProfileMenuSection(
                      title: LocaleKeys.profileSectionAccount.tr(),
                      tiles: [
                        ProfileMenuTile(
                          icon: Icons.receipt_long_rounded,
                          color: AppColors.primary500,
                          title: LocaleKeys.profileOrders.tr(),
                          onTap: () {
                            AppNavigation.pushNamed(AppRoutes.orderHistory);
                          },
                        ),
                        ProfileMenuTile(
                          icon: Icons.credit_card_rounded,
                          color: const Color(0xFF3A7BD5),
                          title: LocaleKeys.profilePaymentMethods.tr(),
                        ),
                        ProfileMenuTile(
                          icon: Icons.notifications_active_rounded,
                          color: const Color(0xFF8E6CEF),
                          title: LocaleKeys.profileNotifications.tr(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                  ],
                  ProfileMenuSection(
                    title: LocaleKeys.profileSectionPreferences.tr(),
                    tiles: [
                      ProfileMenuTile(
                        icon: Icons.translate_rounded,
                        color: const Color(0xFF16967D),
                        title: LocaleKeys.profileLanguage.tr(),
                        trailingText: context.locale.languageCode == 'ar'
                            ? LocaleKeys.languageArabic.tr()
                            : LocaleKeys.languageEnglish.tr(),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => const LanguageBottomSheet(),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  ProfileMenuSection(
                    title: LocaleKeys.profileSectionHelp.tr(),
                    tiles: [
                      ProfileMenuTile(
                        icon: Icons.support_agent_rounded,
                        color: const Color(0xFF2EAD5B),
                        title: LocaleKeys.profileSupport.tr(),
                        onTap: () {
                          AppNavigation.pushNamed(AppRoutes.supportScreen);
                        },
                      ),
                      ProfileMenuTile(
                        icon: Icons.shield_outlined,
                        color: const Color(0xFF5B6BD5),
                        title: LocaleKeys.profilePrivacy.tr(),
                        onTap: () {
                          AppNavigation.pushNamed(
                            AppRoutes.additionalScreen,
                            arguments: {'type': 'privace_police'},
                          );
                        },
                      ),
                      ProfileMenuTile(
                        icon: Icons.help_outline_rounded,
                        color: const Color(0xFFE0A100),
                        title: LocaleKeys.profileFaq.tr(),
                        onTap: () {
                          AppNavigation.pushNamed(
                            AppRoutes.additionalScreen,
                            arguments: {'type': 'faq'},
                          );
                        },
                      ),
                    ],
                  ),
                  if (isLoggedIn) ...[
                    const SizedBox(height: 22),
                    ProfileMenuSection(
                      tiles: [
                        ProfileMenuTile(
                          icon: Icons.logout_rounded,
                          color: AppColors.natural600,
                          title: LocaleKeys.profileLogout.tr(),
                          onTap: () => _confirmLogout(context),
                        ),
                        ProfileMenuTile(
                          icon: Icons.delete_forever_rounded,
                          color: AppColors.errorColor,
                          title: LocaleKeys.profileDeleteAccount.tr(),
                          isDestructive: true,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) {
                                return DeleteBottomSheet(
                                  profileCubit: profileCubit,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                  Text(
                    BaseConstant.appVersion,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.natural400,
                    ),
                  ).setCenter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
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
}

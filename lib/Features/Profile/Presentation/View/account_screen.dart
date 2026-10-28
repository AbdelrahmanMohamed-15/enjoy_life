import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/account_user_card.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/delete_bottom_sheet.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/language_bottom_sheet.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/tile_widget.dart';
import 'package:easy_life/Features/Profile/Presentation/cubit/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          Text(
            LocaleKeys.profileTitle.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: BaseConstant.cairoBold,
              color: AppColors.black700,
              fontSize: 22,
            ),
          ).setCenter(),
          const SizedBox(height: 20),
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) => AccountUserCard(
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
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.natural100,
            ),
            child: Column(
              children: [
                if (UserValidationHelper.checkUserValidation() == true) ...[
                  TileWidget(
                    icon: Icons.credit_card,
                    title: LocaleKeys.profilePaymentMethods.tr(),
                  ),
                  Divider(color: AppColors.natural400),
                  TileWidget(
                    icon: Icons.wallet_giftcard_rounded,
                    title: LocaleKeys.profileOrders.tr(),
                    onTap: () {
                      AppNavigation.pushNamed(AppRoutes.orderHistory);
                    },
                  ),
                  Divider(color: AppColors.natural400),
                  TileWidget(
                    icon: Icons.notifications_active_outlined,
                    title: LocaleKeys.profileNotifications.tr(),
                  ),
                  Divider(color: AppColors.natural400),
                ],

                TileWidget(
                  icon: Icons.language,
                  title: LocaleKeys.profileLanguage.tr(),
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
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.support_agent,
                  title: LocaleKeys.profileSupport.tr(),
                  onTap: () {
                    AppNavigation.pushNamed(AppRoutes.supportScreen);
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.privacy_tip_outlined,
                  title: LocaleKeys.profilePrivacy.tr(),
                  onTap: () {
                    AppNavigation.pushNamed(
                      AppRoutes.additionalScreen,
                      arguments: {'type': 'privace_police'},
                    );
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.question_mark,
                  title: LocaleKeys.profileFaq.tr(),
                  onTap: () {
                    AppNavigation.pushNamed(
                      AppRoutes.additionalScreen,
                      arguments: {'type': 'faq'},
                    );
                  },
                ),
                if (UserValidationHelper.checkUserValidation() == true) ...[
                  Divider(color: AppColors.natural400),
                  TileWidget(
                    icon: Icons.power_settings_new,
                    title: LocaleKeys.profileLogout.tr(),
                    onTap: () async {
                      await DependencyInjectionHelper()
                          .sl<AuthHandlerInterface>()
                          .clearAllData();
                      AppNavigation.pushNamedAndRemoveUntil(AppRoutes.splash);
                    },
                  ),
                  Divider(color: AppColors.natural400),
                  TileWidget(
                    icon: Icons.delete_sweep,
                    title: LocaleKeys.profileDeleteAccount.tr(),
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return DeleteBottomSheet(profileCubit: profileCubit);
                        },
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            BaseConstant.appVersion,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.primary500,
              fontFamily: BaseConstant.cairoBold,
            ),
          ).setCenter(),
        ],
      ),
    );
  }
}

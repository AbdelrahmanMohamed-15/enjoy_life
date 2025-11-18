import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/app_routes.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/account_user_card.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/tile_widget.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Themes/app_colors.dart';

class AccountScreen extends StatelessWidget {
  final VoidCallback onupdateTap;
  const AccountScreen({super.key, required this.onupdateTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          Text(
            'الملف الشخصي',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: BaseConstant.cairoBold,
              color: AppColors.black700,
              fontSize: 22,
            ),
          ).setCenter(),
          const SizedBox(height: 20),
          AccountUserCard(
            onEdit: () {
              AppNavigation.pushNamed(
                AppRoutes.editProfile,
                arguments: {'onupdate': onupdateTap},
              );
            },
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
                TileWidget(icon: Icons.credit_card, title: 'طرق الدفع'),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.wallet_giftcard_rounded,
                  title: 'الطلبات',
                  onTap: () {
                    AppNavigation.pushNamed(AppRoutes.orderHistory);
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.notifications_active_outlined,
                  title: 'الاشعارات',
                ),
                Divider(color: AppColors.natural400),
                TileWidget(icon: Icons.language, title: 'اللغة'),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.support_agent,
                  title: 'الدعم والمساعدة',
                  onTap: () {
                    AppNavigation.pushNamed(
                      AppRoutes.additionalScreen,
                      arguments: {'type': 'terms_of_use'},
                    );
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.privacy_tip_outlined,
                  title: 'سياسة الخصوصية',
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
                  title: 'الاسئلة الشائعة',
                  onTap: () {
                    AppNavigation.pushNamed(
                      AppRoutes.additionalScreen,
                      arguments: {'type': 'faq'},
                    );
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.power_settings_new,
                  title: 'تسجيل الخروج',
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
                  title: 'حذف الحساب',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

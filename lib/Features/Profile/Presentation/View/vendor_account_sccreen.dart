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
import '../Widget/delete_bottom_sheet.dart';
import '../cubit/profile_cubit.dart';

class VendorAccountSccreen extends StatelessWidget {
  final VoidCallback onupdateTap;
  const VendorAccountSccreen({super.key, required this.onupdateTap});

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
                TileWidget(
                  icon: Icons.add,
                  title: 'اضافة فئة',
                  onTap: () {
                    AppNavigation.pushNamed(AppRoutes.addCategory);
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.add,
                  title: 'اضافة فرع',
                  onTap: () {
                    AppNavigation.pushNamed(AppRoutes.addBranch);
                  },
                ),
                Divider(color: AppColors.natural400),

                TileWidget(
                  icon: Icons.add,
                  title: 'اضافة مطعم',
                  onTap: () {
                    AppNavigation.pushNamed(
                      AppRoutes.addService,
                      arguments: {'type': 'resturant', 'isEdit': false},
                    );
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.add,
                  title: 'اضافة فندق',
                  onTap: () {
                    AppNavigation.pushNamed(
                      AppRoutes.addService,
                      arguments: {'type': 'hotel', 'isEdit': false},
                    );
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.add,
                  title: 'اضافة رحلة',
                  onTap: () {
                    AppNavigation.pushNamed(
                      AppRoutes.addService,
                      arguments: {'type': 'trip', 'isEdit': false},
                    );
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.add,
                  title: 'اضافة خدمة',
                  onTap: () {
                    AppNavigation.pushNamed(AppRoutes.addNewServiceScreen);
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(
                  icon: Icons.add,
                  title: 'اضافة خدمة اضافية',
                  onTap: () {
                    AppNavigation.pushNamed(AppRoutes.addServiceOption);
                  },
                ),
                Divider(color: AppColors.natural400),
                TileWidget(icon: Icons.language, title: 'اللغة'),
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

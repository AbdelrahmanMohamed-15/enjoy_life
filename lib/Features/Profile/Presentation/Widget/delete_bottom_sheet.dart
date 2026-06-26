import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Profile/Presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Themes/app_colors.dart';

class DeleteBottomSheet extends StatelessWidget {
  final ProfileCubit profileCubit;
  const DeleteBottomSheet({super.key, required this.profileCubit});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 26),
                const SizedBox(width: 8),
                Text(
                  LocaleKeys.profileDeleteSheetTitle.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.profileDeleteSheetMessage.tr(),
              style: const TextStyle(color: AppColors.natural600, fontSize: 14),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      AppNavigation.pop();
                      final res = await profileCubit.deleteAccount();
                      if (res != null &&
                          (res.status == 200 || res.status == 1)) {
                        await DependencyInjectionHelper()
                            .sl<AuthHandlerInterface>()
                            .clearAllData();
                        AppNavigation.pushNamedAndRemoveUntil(AppRoutes.splash);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.profileDeleteConfirm.tr(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      AppNavigation.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.natural300,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.profileDeleteCancel.tr(),
                      style: const TextStyle(color: AppColors.natural700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

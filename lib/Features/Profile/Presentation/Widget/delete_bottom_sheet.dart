import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
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

  Future<void> _delete() async {
    AppNavigation.pop();
    final res = await profileCubit.deleteAccount();
    if (res != null && (res.status == 200 || res.status == 1)) {
      await DependencyInjectionHelper()
          .sl<AuthHandlerInterface>()
          .clearAllData();
      AppNavigation.pushNamedAndRemoveUntil(AppRoutes.splash);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
                color: AppColors.errorColor.withValues(alpha: 0.1),
              ),
              child: const Icon(
                Icons.delete_forever_rounded,
                color: AppColors.errorColor,
                size: 34,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              LocaleKeys.profileDeleteSheetTitle.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontFamily: BaseConstant.cairoBold,
                color: AppColors.black700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              LocaleKeys.profileDeleteSheetMessage.tr(),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.natural600,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: AppNavigation.pop,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.natural700,
                        side: const BorderSide(color: AppColors.natural300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        LocaleKeys.profileDeleteCancel.tr(),
                        style: const TextStyle(
                          fontFamily: BaseConstant.cairoBold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: FilledButton(
                      onPressed: _delete,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.errorColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        LocaleKeys.profileDeleteConfirm.tr(),
                        style: const TextStyle(
                          fontFamily: BaseConstant.cairoBold,
                          color: Colors.white,
                        ),
                      ),
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

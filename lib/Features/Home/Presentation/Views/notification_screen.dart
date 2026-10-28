import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Themes/app_colors.dart';

/// The API has no notifications list yet; push notifications arrive through
/// FCM, so this screen shows a friendly empty state.
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppPageBar(title: LocaleKeys.homeNotificationsTitle.tr()),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary100.withValues(alpha: 0.5),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    size: 56,
                    color: AppColors.primary500,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                LocaleKeys.homeNotificationsEmpty.tr(),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: AppColors.black700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

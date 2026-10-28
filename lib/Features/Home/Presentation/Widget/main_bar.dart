import 'package:flutter/material.dart';

import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:easy_life/Features/Profile/Presentation/Widget/profile_avatar.dart';

import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Themes/app_colors.dart';

/// Orange home header: greeting, notifications and (optionally) a search
/// field that opens the search screen.
class MainBar extends StatelessWidget {
  final bool isHaveSearch;
  const MainBar({super.key, required this.isHaveSearch});

  @override
  Widget build(BuildContext context) {
    Userdata? userData = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    var theme = Theme.of(context);
    final isGuest = userData == null;
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 14,
        16,
        isHaveSearch ? 18 : 20,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary300, AppColors.primary600],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ProfileAvatar(
                imageUrl: userData?.image,
                name: userData?.fullName,
                size: 44,
                borderWidth: 2,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isGuest
                      ? LocaleKeys.homeWelcomeGuest.tr()
                      : LocaleKeys.homeWelcomeUser.tr(
                          namedArgs: {'name': userData.fullName ?? ''},
                        ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Material(
                color: Colors.white.withValues(alpha: 0.2),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => AppNavigation.pushNamed(AppRoutes.notification),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isHaveSearch) ...[
            const SizedBox(height: 16),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => AppNavigation.pushNamed(AppRoutes.search),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: AppColors.primary500,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          LocaleKeys.homeSearchHint.tr(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.natural400,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.tune_rounded,
                        color: AppColors.natural400,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../Authentication/Domain/Entity/user_entity.dart';
import 'profile_avatar.dart';

/// Gradient header for the account screen. Shows the user's photo, name and
/// email, or a sign-in prompt when [userData] is null (guest).
class ProfileHeader extends StatelessWidget {
  final Userdata? userData;
  final VoidCallback onEdit;
  const ProfileHeader({
    super.key,
    required this.userData,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final isGuest = userData == null;
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 12,
        20,
        28,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary300, AppColors.primary600],
        ),
      ),
      child: Column(
        children: [
          Text(
            LocaleKeys.profileTitle.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: BaseConstant.cairoBold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: onEdit,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ProfileAvatar(
                    imageUrl: userData?.image,
                    name: userData?.fullName,
                    size: 92,
                    borderWidth: 3,
                  ),
                ),
                if (!isGuest)
                  PositionedDirectional(
                    bottom: 2,
                    end: 2,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.primary100,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit_rounded,
                        size: 16,
                        color: AppColors.primary500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            isGuest
                ? LocaleKeys.profileGuestName.tr()
                : (userData!.fullName ?? ''),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: BaseConstant.cairoBold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            isGuest
                ? LocaleKeys.profileGuestHint.tr()
                : (userData!.email ?? ''),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 14),
          Material(
            color: Colors.white.withValues(alpha: isGuest ? 1 : 0.2),
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: onEdit,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isGuest ? Icons.login_rounded : Icons.edit_note_rounded,
                      size: 18,
                      color: isGuest ? AppColors.primary500 : Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isGuest
                          ? LocaleKeys.profileSignIn.tr()
                          : LocaleKeys.profileEditTitle.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: BaseConstant.cairoBold,
                        color: isGuest ? AppColors.primary500 : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

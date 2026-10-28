import 'package:flutter/material.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../Authentication/Domain/Entity/user_entity.dart';
import 'profile_avatar.dart';

class AccountUserCard extends StatelessWidget {
  final VoidCallback onEdit;
  const AccountUserCard({super.key, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Userdata? userData = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getUserData();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.natural100,
      ),
      child: Row(
        children: [
          ProfileAvatar(
            imageUrl: userData?.image,
            name: userData?.fullName,
            size: 50,
            borderWidth: 1,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData?.fullName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.black700,
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  userData?.email ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.natural400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onEdit,
            child: Icon(
              Icons.edit_square,
              color: AppColors.primary400,
              size: 17,
            ),
          ),
        ],
      ),
    );
  }
}

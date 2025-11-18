import 'package:flutter/material.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';

class TileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;
  final Color? iconColor;
  final Color? textColor;
  const TileWidget({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.primary400),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontFamily: BaseConstant.cairoBold,
          color: textColor ?? AppColors.black700,
        ),
      ),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';

/// Titled white card that groups [ProfileMenuTile]s with inset dividers.
class ProfileMenuSection extends StatelessWidget {
  final String? title;
  final List<ProfileMenuTile> tiles;
  const ProfileMenuSection({super.key, this.title, required this.tiles});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 6, bottom: 8),
            child: Text(
              title!,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: BaseConstant.cairoBold,
                color: AppColors.natural500,
                letterSpacing: 0.3,
              ),
            ),
          ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              for (var i = 0; i < tiles.length; i++) ...[
                if (i > 0)
                  const Divider(
                    height: 1,
                    thickness: 1,
                    indent: 68,
                    endIndent: 16,
                    color: AppColors.natural200,
                  ),
                tiles[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? trailingText;
  final bool isDestructive;
  final VoidCallback? onTap;
  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    this.trailingText,
    this.isDestructive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 21),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: isDestructive ? color : AppColors.black700,
                ),
              ),
            ),
            if (trailingText != null) ...[
              Text(
                trailingText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.natural500,
                ),
              ),
              const SizedBox(width: 4),
            ],
            if (!isDestructive)
              Transform.flip(
                flipX: isRtl,
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.natural400,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Features/Reversion/Domain/Entities/reversion_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';

class ReversionUserCard extends StatelessWidget {
  final ReversionData reversion;
  const ReversionUserCard({super.key, required this.reversion});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.primary400,
                border: Border.all(color: AppColors.primary500, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  reversion.client?.image ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return SvgPicture.asset(
                      AssetsStrings.noImages,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reversion.client?.fullName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.black700,
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  reversion.client?.email ?? '',
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
        ],
      ).setVerticalPadding(context, 8, enableMediaQuery: false),
    );
  }
}

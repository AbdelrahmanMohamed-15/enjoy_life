import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Features/Reversion/Domain/Entities/reversion_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Themes/app_colors.dart';

class ReversionCard extends StatelessWidget {
  final ReversionData reversion;
  const ReversionCard({super.key, required this.reversion});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              reversion.order?.image ?? '',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SvgPicture.asset(
                  AssetsStrings.noImages,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reversion.order?.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  reversion.order?.createdAt == null
                      ? ''
                      : '${reversion.order?.createdAt!.year}-${reversion.order?.createdAt!.month}-${reversion.order?.createdAt!.day}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: BaseConstant.cairoRegular,
                    color: AppColors.natural400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primary200.withOpacity(0.3),
            ),
            child: Text(
              '${reversion.order?.totalPrice ?? '0.0'} ج.م',
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: BaseConstant.cairoBold,
                color: AppColors.primary500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              AppNavigation.pushNamed(
                AppRoutes.reversionDetails,
                arguments: {'reversionData': reversion},
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.natural100,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.natural200,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                  BoxShadow(
                    color: AppColors.natural200,
                    blurRadius: 7,
                    offset: const Offset(0, -3), // changes position of shadow
                  ),
                ],
              ),
              child: Icon(Icons.visibility_sharp, color: AppColors.primary500),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    ).setVerticalPadding(context, 4, enableMediaQuery: false);
  }
}

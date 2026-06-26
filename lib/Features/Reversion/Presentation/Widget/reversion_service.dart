import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:easy_life/Core/Extentions/padding_ext.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import 'package:flutter/material.dart';

class ReversionService extends StatelessWidget {
  final int serviceID;
  final ReversionCubit reversionCubit;
  const ReversionService({
    super.key,
    required this.serviceID,
    required this.reversionCubit,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              reversionCubit.setReversionStatus(servID: 1);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: serviceID == 1
                    ? AppColors.primary500
                    : AppColors.natural200,
              ),
              child: Text(
                LocaleKeys.reversionFilterRestaurant.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: serviceID == 1
                      ? AppColors.natural100
                      : AppColors.natural500,
                ),
              ).setCenter(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              reversionCubit.setReversionStatus(servID: 2);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: serviceID == 2
                    ? AppColors.primary500
                    : AppColors.natural200,
              ),
              child: Text(
                LocaleKeys.reversionFilterHotel.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: serviceID == 2
                      ? AppColors.natural100
                      : AppColors.natural500,
                ),
              ).setCenter(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              reversionCubit.setReversionStatus(servID: 3);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: serviceID == 3
                    ? AppColors.primary500
                    : AppColors.natural200,
              ),
              child: Text(
                LocaleKeys.reversionFilterTrip.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: serviceID == 3
                      ? AppColors.natural100
                      : AppColors.natural500,
                ),
              ).setCenter(),
            ),
          ),
        ),
      ],
    ).setHorizontalPadding(context, 15, enableMediaQuery: false);
  }
}

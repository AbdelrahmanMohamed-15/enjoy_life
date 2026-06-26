import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:easy_life/Core/Extentions/padding_ext.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import 'package:flutter/material.dart';

class ReversionStatus extends StatelessWidget {
  final String status;
  final ReversionCubit reversionCubit;
  const ReversionStatus({
    super.key,
    required this.status,
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
              reversionCubit.setReversionStatus(reversionStatus: 'pending');
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: status == 'pending'
                      ? AppColors.primary500
                      : AppColors.natural400,
                ),
              ),
              child: Text(
                LocaleKeys.reversionStatusPending.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: status == 'pending'
                      ? AppColors.primary500
                      : AppColors.natural400,
                ),
              ).setCenter(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              reversionCubit.setReversionStatus(reversionStatus: 'completed');
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: status == 'completed'
                      ? AppColors.primary500
                      : AppColors.natural400,
                ),
              ),
              child: Text(
                LocaleKeys.reversionStatusApproved.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: status == 'completed'
                      ? AppColors.primary500
                      : AppColors.natural400,
                ),
              ).setCenter(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              reversionCubit.setReversionStatus(reversionStatus: 'cancelled');
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: status == 'cancelled'
                      ? AppColors.primary500
                      : AppColors.natural400,
                ),
              ),
              child: Text(
                LocaleKeys.reversionStatusCancelled.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: status == 'cancelled'
                      ? AppColors.primary500
                      : AppColors.natural400,
                ),
              ).setCenter(),
            ),
          ),
        ),
      ],
    ).setHorizontalPadding(context, 15, enableMediaQuery: false);
  }
}

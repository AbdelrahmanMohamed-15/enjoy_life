import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/Order/Presentation/cubit/order_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';

class OrderTabs extends StatelessWidget {
  final int currentIndex;
  final OrderCubit orderCubit;
  const OrderTabs({
    super.key,
    required this.currentIndex,
    required this.orderCubit,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              orderCubit.changeIndex(0);
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    LocaleKeys.orderTabPending.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: currentIndex == 0
                          ? AppColors.primary400
                          : AppColors.natural300,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                ),
                Divider(
                  color: currentIndex == 0
                      ? AppColors.primary400
                      : AppColors.natural300,
                  thickness: currentIndex == 0 ? 2 : 1,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              orderCubit.changeIndex(1);
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    LocaleKeys.orderTabCompleted.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: currentIndex == 1
                          ? AppColors.primary400
                          : AppColors.natural300,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                ),
                Divider(
                  color: currentIndex == 1
                      ? AppColors.primary400
                      : AppColors.natural300,
                  thickness: currentIndex == 1 ? 2 : 1,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              orderCubit.changeIndex(2);
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    LocaleKeys.orderTabCancelled.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: currentIndex == 2
                          ? AppColors.primary400
                          : AppColors.natural300,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                ),
                Divider(
                  color: currentIndex == 2
                      ? AppColors.primary400
                      : AppColors.natural300,
                  thickness: currentIndex == 2 ? 2 : 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

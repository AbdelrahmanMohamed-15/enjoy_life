import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/Order/Presentation/cubit/order_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Themes/app_colors.dart';

/// Segmented control for the pending / completed / cancelled order lists.
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
    final tabs = [
      (Icons.hourglass_top_rounded, LocaleKeys.orderTabPending.tr()),
      (Icons.check_circle_rounded, LocaleKeys.orderTabCompleted.tr()),
      (Icons.cancel_rounded, LocaleKeys.orderTabCancelled.tr()),
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.natural200.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Expanded(
              child: _TabItem(
                icon: tabs[i].$1,
                label: tabs[i].$2,
                isSelected: currentIndex == i,
                onTap: () {
                  if (currentIndex != i) orderCubit.changeIndex(i);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _TabItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.white : AppColors.natural500;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: isSelected
              ? const LinearGradient(
                  colors: [AppColors.primary400, AppColors.primary600],
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary500.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: BaseConstant.cairoBold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

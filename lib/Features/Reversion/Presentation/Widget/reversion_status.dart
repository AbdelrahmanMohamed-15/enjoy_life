import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import 'package:flutter/material.dart';

/// Segmented control for the pending / approved / cancelled reservations.
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
    final tabs = [
      (
        'pending',
        Icons.hourglass_top_rounded,
        LocaleKeys.reversionStatusPending.tr(),
      ),
      (
        'completed',
        Icons.check_circle_rounded,
        LocaleKeys.reversionStatusApproved.tr(),
      ),
      (
        'cancelled',
        Icons.cancel_rounded,
        LocaleKeys.reversionStatusCancelled.tr(),
      ),
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
          for (final tab in tabs)
            Expanded(
              child: _StatusTab(
                icon: tab.$2,
                label: tab.$3,
                isSelected: status == tab.$1,
                onTap: () {
                  if (status != tab.$1) {
                    reversionCubit.setReversionStatus(reversionStatus: tab.$1);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _StatusTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _StatusTab({
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

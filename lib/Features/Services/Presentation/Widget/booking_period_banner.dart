import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:flutter/material.dart';

/// Shows the chosen booking window above the available tables / rooms.
class BookingPeriodBanner extends StatelessWidget {
  final String startDate;
  final String endDate;
  const BookingPeriodBanner({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary100.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary200),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.event_available_rounded,
            color: AppColors.primary600,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                '$startDate  →  $endDate',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: BaseConstant.cairoBold,
                  color: AppColors.primary700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

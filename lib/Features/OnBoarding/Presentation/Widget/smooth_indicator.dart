import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Themes/app_colors.dart';

class SmoothIndicator extends StatelessWidget {
  final int currentIndex;
  const SmoothIndicator({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: currentIndex == 0 ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: currentIndex == 0
                ? AppColors.primary500
                : AppColors.natural300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: currentIndex == 1 ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: currentIndex == 1
                ? AppColors.primary500
                : AppColors.natural300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: currentIndex == 2 ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: currentIndex == 2
                ? AppColors.primary500
                : AppColors.natural300,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    ).setCenter();
  }
}

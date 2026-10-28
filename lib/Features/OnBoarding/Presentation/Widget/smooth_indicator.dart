import 'package:flutter/material.dart';

import '../../../../Core/Themes/app_colors.dart';

class SmoothIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;
  const SmoothIndicator({
    super.key,
    required this.currentIndex,
    this.count = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentIndex == i ? 28 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: currentIndex == i
                  ? AppColors.primary500
                  : AppColors.natural300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
      ],
    );
  }
}

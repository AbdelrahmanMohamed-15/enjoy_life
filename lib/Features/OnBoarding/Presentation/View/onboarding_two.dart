import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/main_app_button.dart';
import '../Widget/smooth_indicator.dart';

class OnboardingTwo extends StatelessWidget {
  final PageController controller;
  final int currentIndex;
  const OnboardingTwo({
    super.key,
    required this.controller,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.jumpToPage(0);
                },
                child: Icon(Icons.arrow_back_ios, color: AppColors.black700),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  controller.jumpToPage(2);
                },
                child: Text(
                  'تخطي',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.black700,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Image.asset(AssetsStrings.boarding2),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              style: theme.textTheme.headlineMedium!.copyWith(
                color: AppColors.black700,
              ),
              children: [
                TextSpan(text: 'أكمل'),
                TextSpan(text: ' '),
                TextSpan(text: 'حجزك'),
                TextSpan(text: ' '),
                TextSpan(
                  text: 'بسلاسة!',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'أكمل حجز وجهتك المفضلة بضغطة زر، واستمتع بتجربة دفع آمنة!',
            style: theme.textTheme.bodyMedium!.copyWith(
              color: AppColors.natural400,
            ),
          ),
          const SizedBox(height: 20),
          SmoothIndicator(currentIndex: currentIndex),
          Spacer(),
          MainAppButton(
            bgColor: AppColors.primary500,
            onTap: () {
              controller.jumpToPage(2);
            },
            child: Text(
              'التالي',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: AppColors.natural100,
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ).setHorizontalPadding(context, 15, enableMediaQuery: false),
    );
  }
}

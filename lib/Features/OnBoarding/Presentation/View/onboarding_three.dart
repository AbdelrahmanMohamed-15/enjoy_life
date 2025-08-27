import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/main_app_button.dart';
import '../Widget/smooth_indicator.dart';

class OnboardingThree extends StatelessWidget {
  final PageController controller;
  final int currentIndex;
  const OnboardingThree({
    super.key,
    required this.controller,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final DependencyInjectionHelper _di = DependencyInjectionHelper();
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.jumpToPage(1);
                },
                child: Icon(Icons.arrow_back_ios, color: AppColors.black700),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          Image.asset(AssetsStrings.boarding3),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              style: theme.textTheme.headlineMedium!.copyWith(
                color: AppColors.black700,
              ),
              children: [
                TextSpan(
                  text: 'اصنع',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
                TextSpan(text: ' '),
                TextSpan(text: 'ذكريات'),
                TextSpan(text: ' '),
                TextSpan(text: 'لا تُنسى!'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'احجز الآن واستمتع بأوقات مميزة مع أحبابك في وجهاتك المفضلة!',
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
              Future.delayed(Duration(milliseconds: 50), () async {
                await _di.sl<AuthHandlerInterface>().setOnBoarding(false);
                AppNavigation.pushNamedAndRemoveUntil(AppRoutes.login);
              });
            },
            child: Text(
              'ابدا',
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

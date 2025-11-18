import 'package:easy_life/Core/Constant/assets_strings.dart';
import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../Core/Handler/auth_handler.dart';
import '../../Core/Helper/dependency_injection_helper.dart';
import '../../Core/Routes/app_navigation.dart';
import '../../Core/Routes/app_routes.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  final DependencyInjectionHelper _di = DependencyInjectionHelper();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      String onBoarding = _di.sl<AuthHandlerInterface>().getBoarding() ?? '';
      if (onBoarding.isEmpty || onBoarding != 'false') {
        AppNavigation.pushReplacementNamed(AppRoutes.onboarding);
      } else {
        AppNavigation.pushReplacementNamed(AppRoutes.mainNav);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsStrings.appLogo),
          Text(
            'Easy Life',
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 24,
              color: AppColors.primary500,
            ),
          ),
        ],
      ).setCenter(),
    );
  }
}

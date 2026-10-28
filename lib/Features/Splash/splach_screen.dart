import 'package:easy_life/Core/Constant/assets_strings.dart';
import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
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

class _SplachScreenState extends State<SplachScreen>
    with SingleTickerProviderStateMixin {
  final DependencyInjectionHelper _di = DependencyInjectionHelper();
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      String onBoarding = _di.sl<AuthHandlerInterface>().getBoarding() ?? '';
      if (onBoarding.isEmpty || onBoarding != 'false') {
        AppNavigation.pushReplacementNamed(AppRoutes.onboarding);
      } else {
        AppNavigation.pushReplacementNamed(AppRoutes.mainNav);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    final scale = Tween(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Soft decorative circles
          Positioned(
            top: -90,
            right: -70,
            child: _Blob(size: 260, opacity: 0.18),
          ),
          Positioned(
            bottom: -110,
            left: -80,
            child: _Blob(size: 300, opacity: 0.12),
          ),
          Center(
            child: FadeTransition(
              opacity: fade,
              child: ScaleTransition(
                scale: scale,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AssetsStrings.appLogo, width: 220),
                    const SizedBox(height: 8),
                    Text(
                      LocaleKeys.splashTagline.tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 22,
                        color: AppColors.primary500,
                        fontFamily: BaseConstant.cairoBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Center(
              child: SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primary400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final double size;
  final double opacity;
  const _Blob({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.primary300.withValues(alpha: opacity),
            AppColors.primary600.withValues(alpha: opacity),
          ],
        ),
      ),
    );
  }
}

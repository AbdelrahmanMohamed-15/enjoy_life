import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Handler/auth_handler.dart';
import '../../../../Core/Helper/dependency_injection_helper.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Routes/app_routes.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/app_ui.dart';
import '../Widget/smooth_indicator.dart';

/// One onboarding page: an illustration and a headline where one part is
/// highlighted in orange.
class _OnboardingPage {
  final String image;
  final List<(String, bool)> headline;
  final String description;
  const _OnboardingPage({
    required this.image,
    required this.headline,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentIndex = 0;
  bool _finishing = false;

  List<_OnboardingPage> get _pages => [
    _OnboardingPage(
      image: AssetsStrings.boarding1,
      headline: [
        (LocaleKeys.onboardingOneHeadline1.tr(), false),
        (LocaleKeys.onboardingOneHeadline2.tr(), true),
        (LocaleKeys.onboardingOneHeadline3.tr(), false),
      ],
      description: LocaleKeys.onboardingOneDescription.tr(),
    ),
    _OnboardingPage(
      image: AssetsStrings.boarding2,
      headline: [
        (LocaleKeys.onboardingTwoHeadline1.tr(), false),
        (LocaleKeys.onboardingTwoHeadline2.tr(), false),
        (LocaleKeys.onboardingTwoHeadline3.tr(), true),
      ],
      description: LocaleKeys.onboardingTwoDescription.tr(),
    ),
    _OnboardingPage(
      image: AssetsStrings.boarding3,
      headline: [
        (LocaleKeys.onboardingThreeHeadline1.tr(), true),
        (LocaleKeys.onboardingThreeHeadline2.tr(), false),
        (LocaleKeys.onboardingThreeHeadline3.tr(), false),
      ],
      description: LocaleKeys.onboardingThreeDescription.tr(),
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    if (_finishing) return;
    _finishing = true;
    await DependencyInjectionHelper().sl<AuthHandlerInterface>().setOnBoarding(
      false,
    );
    AppNavigation.pushNamedAndRemoveUntil(
      AppRoutes.mainNav,
      predicate: (_) => false,
    );
  }

  void _goTo(int page) => controller.animateToPage(
    page,
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final pages = _pages;
    final isLast = currentIndex == pages.length - 1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: Row(
                children: [
                  if (currentIndex > 0)
                    IconButton(
                      onPressed: () => _goTo(currentIndex - 1),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.black700,
                        size: 20,
                      ),
                    ),
                  const Spacer(),
                  if (!isLast)
                    TextButton(
                      onPressed: _finish,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.natural600,
                      ),
                      child: Text(
                        LocaleKeys.onboardingSkip.tr(),
                        style: const TextStyle(
                          fontFamily: BaseConstant.cairoBold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (value) => setState(() => currentIndex = value),
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const Spacer(),
                        Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxHeight: 330),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primary100.withValues(alpha: 0.7),
                                AppColors.primary100.withValues(alpha: 0),
                              ],
                            ),
                          ),
                          child: Image.asset(page.image, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 28),
                        Text.rich(
                          TextSpan(
                            children: [
                              for (final (text, highlighted) in page.headline)
                                if (text.trim().isNotEmpty)
                                  TextSpan(
                                    text: '$text ',
                                    style: highlighted
                                        ? const TextStyle(
                                            color: AppColors.primary500,
                                          )
                                        : null,
                                  ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: AppColors.black700,
                            fontFamily: BaseConstant.cairoBold,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.natural500,
                            height: 1.5,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),
            SmoothIndicator(currentIndex: currentIndex, count: pages.length),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: AppGradientButton(
                label: isLast
                    ? LocaleKeys.onboardingStart.tr()
                    : LocaleKeys.onboardingNext.tr(),
                icon: isLast
                    ? Icons.rocket_launch_rounded
                    : Icons.arrow_forward_rounded,
                onTap: isLast ? _finish : () => _goTo(currentIndex + 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

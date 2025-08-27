import 'package:flutter/material.dart';
import 'onboarding_one.dart';
import 'onboarding_three.dart';
import 'onboarding_two.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            OnboardingOne(controller: controller, currentIndex: currentIndex),
            OnboardingTwo(controller: controller, currentIndex: currentIndex),
            OnboardingThree(controller: controller, currentIndex: currentIndex),
          ],
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
        ),
      ),
    );
  }
}

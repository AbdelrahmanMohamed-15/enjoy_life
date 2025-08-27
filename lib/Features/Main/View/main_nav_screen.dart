import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Home/Presentation/Views/home_screen.dart';
import 'package:flutter/material.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int currentIndex = 0;
  PageController pageController = PageController();
  List<Widget> pages = [HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen()];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: AppColors.natural100,
          // showUnselectedLabels: true,
          selectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.primary400,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.natural400,
          ),
          selectedItemColor: AppColors.primary400,
          unselectedItemColor: AppColors.natural400,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                currentIndex == 0 ? Icons.home : Icons.home_outlined,
                color: currentIndex == 0
                    ? AppColors.primary400
                    : AppColors.natural400,
              ),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                currentIndex == 1
                    ? Icons.shopping_bag
                    : Icons.shopping_bag_outlined,
                color: currentIndex == 1
                    ? AppColors.primary400
                    : AppColors.natural400,
              ),
              label: 'السلة',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                currentIndex == 2 ? Icons.favorite : Icons.favorite_border,
                color: currentIndex == 2
                    ? AppColors.primary400
                    : AppColors.natural400,
              ),
              label: 'المفضلة',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                currentIndex == 3 ? Icons.person : Icons.person_outline,
                color: currentIndex == 3
                    ? AppColors.primary400
                    : AppColors.natural400,
              ),
              label: 'الحساب',
            ),
          ],
        ),
      ),
    );
  }
}

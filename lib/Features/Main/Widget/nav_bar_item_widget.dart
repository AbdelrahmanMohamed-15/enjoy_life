import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../Core/Themes/app_colors.dart';

class NavBarItemWidget {
  final int currentIndex;
  NavBarItemWidget({required this.currentIndex});

  List<BottomNavigationBarItem> get userNavBarItems => [
    BottomNavigationBarItem(
      icon: Icon(
        currentIndex == 0 ? Icons.home : Icons.home_outlined,
        color: currentIndex == 0 ? AppColors.primary400 : AppColors.natural400,
      ),
      label: LocaleKeys.mainNavHome.tr(),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        currentIndex == 1 ? Icons.shopping_bag : Icons.shopping_bag_outlined,
        color: currentIndex == 1 ? AppColors.primary400 : AppColors.natural400,
      ),
      label: LocaleKeys.mainNavCart.tr(),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        currentIndex == 2 ? Icons.favorite : Icons.favorite_border,
        color: currentIndex == 2 ? AppColors.primary400 : AppColors.natural400,
      ),
      label: LocaleKeys.mainNavFavorites.tr(),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        currentIndex == 3 ? Icons.person : Icons.person_outline,
        color: currentIndex == 3 ? AppColors.primary400 : AppColors.natural400,
      ),
      label: LocaleKeys.mainNavAccount.tr(),
    ),
  ];

  List<BottomNavigationBarItem> get providerNavBarItems => [
    BottomNavigationBarItem(
      icon: Icon(
        currentIndex == 0 ? Icons.home : Icons.home_outlined,
        color: currentIndex == 0 ? AppColors.primary400 : AppColors.natural400,
      ),
      label: LocaleKeys.mainNavHome.tr(),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        currentIndex == 1
            ? Icons.qr_code_scanner
            : Icons.qr_code_scanner_outlined,
        color: currentIndex == 1 ? AppColors.primary400 : AppColors.natural400,
      ),
      label: LocaleKeys.mainNavScan.tr(),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        currentIndex == 2
            ? Icons.shopping_basket
            : Icons.shopping_basket_outlined,
        color: currentIndex == 2 ? AppColors.primary400 : AppColors.natural400,
      ),
      label: LocaleKeys.mainNavReservations.tr(),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        currentIndex == 3 ? Icons.person : Icons.person_outline,
        color: currentIndex == 3 ? AppColors.primary400 : AppColors.natural400,
      ),
      label: LocaleKeys.mainNavAccount.tr(),
    ),
  ];
}

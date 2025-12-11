import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:easy_life/Features/Cart/Presentation/Views/cart_screen.dart';
import 'package:easy_life/Features/Home/Presentation/Views/home_screen.dart';
import 'package:easy_life/Features/Home/Presentation/Views/my_favourite_screen.dart';
import 'package:easy_life/Features/Home/Presentation/Views/vendor_homde_screen.dart';
import 'package:easy_life/Features/Main/Widget/nav_bar_item_widget.dart';
import 'package:easy_life/Features/Profile/Presentation/View/account_screen.dart';
import 'package:easy_life/Features/Profile/Presentation/View/vendor_account_sccreen.dart';
import 'package:easy_life/Features/Reversion/Presentation/Views/reversion_screen.dart';
import 'package:flutter/material.dart';

import '../../../Core/Constant/base_constant.dart';
import '../../../Core/Handler/auth_handler.dart';
import '../../../Core/Helper/user_validation_helper.dart';
import '../../Reversion/Presentation/Views/scan_order_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int currentIndex = 0;
  PageController pageController = PageController();
  Userdata? userData = DependencyInjectionHelper()
      .sl<AuthHandlerInterface>()
      .getUserData();
  @override
  Widget build(BuildContext context) {
    debugPrint('user data is ${userData?.clientType}');
    List<Widget> userPages = [
      HomeScreen(),
      CartScreen(),
      MyFavouriteScreen(),
      AccountScreen(
        onupdateTap: () {
          setState(() {
            currentIndex = 1;
          });
        },
      ),
    ];
    List<Widget> vendorPages = [
      VendorHomeScreen(),
      ScanOrderScreen(),
      ReversionScreen(),
      VendorAccountSccreen(
        onupdateTap: () {
          setState(() {
            currentIndex = 1;
          });
        },
      ),
    ];
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: userData == null
            ? userPages[currentIndex]
            : userData?.clientType == 0
            ? userPages[currentIndex]
            : vendorPages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: currentIndex,
          backgroundColor: AppColors.natural100,
          // showUnselectedLabels: true,
          selectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.primary400,
            fontFamily: BaseConstant.cairoBold,
          ),
          unselectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.natural400,
          ),
          selectedItemColor: AppColors.primary400,
          unselectedItemColor: AppColors.natural400,
          onTap: (value) {
            if (value == 2 || value == 3) {
              if (UserValidationHelper.checkUserValidation() == true) {
                setState(() {
                  currentIndex = value;
                });
              } else {
                UserValidationHelper.showUserValidation();
              }
            } else {
              setState(() {
                currentIndex = value;
              });
            }
          },
          items: userData == null
              ? NavBarItemWidget(currentIndex: currentIndex).userNavBarItems
              : userData?.clientType == 0
              ? NavBarItemWidget(currentIndex: currentIndex).userNavBarItems
              : NavBarItemWidget(
                  currentIndex: currentIndex,
                ).providerNavBarItems,
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:easy_life/Features/Cart/Presentation/Views/cart_screen.dart';
import 'package:easy_life/Features/Home/Presentation/Views/home_screen.dart';
import 'package:easy_life/Features/Home/Presentation/Views/my_favourite_screen.dart';
import 'package:easy_life/Features/Home/Presentation/Views/vendor_homde_screen.dart';
import 'package:easy_life/Features/Main/Widget/nav_bar_item_widget.dart';
import 'package:easy_life/Features/Profile/Presentation/View/account_screen.dart';
import 'package:easy_life/Features/Profile/Presentation/cubit/profile_cubit.dart';
import 'package:easy_life/Features/Profile/Presentation/View/vendor_account_sccreen.dart';
import 'package:easy_life/Features/Reversion/Presentation/Views/reversion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // Rebuild the tab labels when the language changes
    context.locale;
    List<Widget> userPages = [
      HomeScreen(),
      CartScreen(),
      MyFavouriteScreen(),
      BlocProvider(
        create: (context) =>
            DependencyInjectionHelper().sl<ProfileCubit>()..getProfileData(),
        child: AccountScreen(),
      ),
    ];
    List<Widget> vendorPages = [
      VendorHomeScreen(),
      ScanOrderScreen(),
      ReversionScreen(),
      BlocProvider(
        create: (context) =>
            DependencyInjectionHelper().sl<ProfileCubit>()..getProfileData(),
        child: VendorAccountSccreen(),
      ),
    ];
    final isVendor = userData != null && userData?.clientType != 0;
    return PopScope(
      // Back on another tab returns to Home before leaving the app
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => currentIndex = 0);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: isVendor ? vendorPages[currentIndex] : userPages[currentIndex],
          bottomNavigationBar: AppBottomNav(
            items: isVendor
                ? NavBarItemWidget.providerItems
                : NavBarItemWidget.userItems,
            currentIndex: currentIndex,
            onTap: (value) {
              if (value == currentIndex) return;
              // Favourites need an account (vendors are always logged in)
              if (!isVendor &&
                  value == 2 &&
                  UserValidationHelper.checkUserValidation() != true) {
                UserValidationHelper.showUserValidation();
                return;
              }
              setState(() => currentIndex = value);
            },
          ),
        ),
      ),
    );
  }
}

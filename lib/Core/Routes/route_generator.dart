import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Features/Authentication/Presentation/Views/register_screen.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:easy_life/Features/Main/View/main_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../Features/Authentication/Presentation/Views/login_screen.dart';
import '../../Features/OnBoarding/Presentation/View/onboarding_screen.dart';
import '../../Features/Splash/splach_screen.dart';
import '../Constant/base_constant.dart';
import 'app_navigation.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // var args = settings.arguments;

    //paymentMethod

    switch (settings.name) {
      case AppRoutes.splash:
        return _screenRoute(screen: SplachScreen(), settings: settings);
      case AppRoutes.onboarding:
        return _screenRoute(
          screen: const OnboardingScreen(),
          settings: settings,
        );
      case AppRoutes.login:
        return _screenRoute(
          screen: BlocProvider(
            create: (context) => DependencyInjectionHelper().sl<AuthCubit>(),
            child: const LoginScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.register:
        return _screenRoute(
          screen: BlocProvider(
            create: (context) => DependencyInjectionHelper().sl<AuthCubit>(),
            child: const RegisterScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.home:
      case AppRoutes.mainNav:
        return _screenRoute(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    DependencyInjectionHelper().sl<HomeCubit>()..getSliders(),
              ),
            ],
            child: const MainNavScreen(),
          ),
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _screenRoute({
    Widget? screen,
    RouteSettings? settings,
  }) {
    return MaterialPageRoute(builder: (context) => screen!, settings: settings);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(elevation: 0, title: const Text(BaseConstant.appName)),
          body: Center(
            child: InkWell(
              onTap: () {
                Phoenix.rebirth(AppNavigation.currentContext);
              },
              child: const Text('Try again.'),
            ),
          ),
        );
      },
    );
  }
}

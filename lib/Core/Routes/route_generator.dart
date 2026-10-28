import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Features/Authentication/Presentation/Views/ForgetPassword/forget_password_screen.dart';
import 'package:easy_life/Features/Authentication/Presentation/Views/ForgetPassword/rest_otp_screen.dart';
import 'package:easy_life/Features/Authentication/Presentation/Views/register_screen.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_life/Features/Home/Presentation/Views/notification_screen.dart';
import 'package:easy_life/Features/Home/Presentation/cubit/home_cubit.dart';
import 'package:easy_life/Features/Home/Presentation/Views/search_screen.dart';
import 'package:easy_life/Features/Main/View/main_nav_screen.dart';
import 'package:easy_life/Features/Order/Presentation/View/order_history_screen.dart';
import 'package:easy_life/Features/Order/Presentation/cubit/order_cubit.dart';
import 'package:easy_life/Features/Home/Presentation/Views/all_home_screen.dart';
import 'package:easy_life/Features/Profile/Presentation/View/additional_screen.dart';
import 'package:easy_life/Features/Profile/Presentation/View/edit_profile_screen.dart';
import 'package:easy_life/Features/Profile/Presentation/cubit/profile_cubit.dart';
import 'package:easy_life/Features/Reversion/Presentation/Views/qr_scanner_screen.dart';
import 'package:easy_life/Features/Reversion/Presentation/Views/reversion_details_screen.dart';
import 'package:easy_life/Features/Reversion/Presentation/Views/reversion_list_screen.dart';
import 'package:easy_life/Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import 'package:easy_life/Features/Services/Presentation/Views/room_screen.dart';
import 'package:easy_life/Features/Services/Presentation/Views/service_details_screen.dart';
import 'package:easy_life/Features/Services/Presentation/Views/service_screen.dart';
import 'package:easy_life/Features/Services/Presentation/Views/tables_screen.dart';
import 'package:easy_life/Features/Services/Presentation/Views/trips_screen.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:easy_life/Features/vendorService/Presentation/Views/Service%20Page%20View/main_add_service_screen.dart';
import 'package:easy_life/Features/vendorService/Presentation/Views/add_branch_screen.dart';
import 'package:easy_life/Features/vendorService/Presentation/Views/add_category_screen.dart';
import 'package:easy_life/Features/vendorService/Presentation/Views/add_new_service_screen.dart';
import 'package:easy_life/Features/vendorService/Presentation/Views/add_service_option_screen.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../Features/Authentication/Presentation/Views/login_screen.dart';
import '../../Features/OnBoarding/Presentation/View/onboarding_screen.dart';
import '../../Features/Profile/Presentation/View/support_screen.dart';
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
      case AppRoutes.forgetPassword:
        return _screenRoute(
          screen: BlocProvider(
            create: (context) => DependencyInjectionHelper().sl<AuthCubit>(),
            child: const ForgetPasswordScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.verifyResetOtp:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: RestOtpScreen(
            authCubit: args['authCubit'],
            isRegister: args['isRegister'],
          ),
          settings: settings,
        );
      case AppRoutes.allHome:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: BlocProvider(
            create: (context) =>
                DependencyInjectionHelper().sl<HomeCubit>()
                  ..getAllHome(type: args['type']),
            child: AllHomeScreen(type: args['type']),
          ),
          settings: settings,
        );
      case AppRoutes.search:
        return _screenRoute(screen: const SearchScreen(), settings: settings);
      case AppRoutes.notification:
        return _screenRoute(
          screen: const NotificationScreen(),
          settings: settings,
        );
      case AppRoutes.mainNav:
        return _screenRoute(screen: const MainNavScreen(), settings: settings);
      case AppRoutes.resturantDetails:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: BlocProvider(
            create: (context) =>
                DependencyInjectionHelper().sl<ServiceCubit>()
                  ..getinitialData(id: args['serviceID'], type: args['type']),
            child: ServiceDetailsScreen(
              serviceID: args['serviceID'],
              type: args['type'],
            ),
          ),
          settings: settings,
        );
      case AppRoutes.serviceScreen:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: ServiceScreen(
            serviceBranches: args['serviceBranches'],
            title: args['title'],
            branchID: args['branchID'],
            serviceCubit: args['serviceCubit'],
          ),
        );
      case AppRoutes.tablesScreen:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: TablesScreen(
            tableData: args['tableData'],
            title: args['title'],
            serviceCubit: args['serviceCubit'],
            startDate: args['startDate'],
            endDate: args['endDate'],
          ),
        );
      case AppRoutes.roomScreen:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: RoomScreen(
            tableData: args['tableData'],
            title: args['title'],
            serviceCubit: args['serviceCubit'],
            startDate: args['startDate'],
            endDate: args['endDate'],
          ),
        );
      case AppRoutes.tripScreen:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: TripsScreen(
            tripsData: args['tripsData'],
            title: args['title'],
            serviceCubit: args['serviceCubit'],
          ),
        );
      case AppRoutes.orderHistory:
        return _screenRoute(
          screen: BlocProvider(
            create: (context) =>
                DependencyInjectionHelper().sl<OrderCubit>()
                  ..getPendingOrders(),
            child: OrderHistoryScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.editProfile:
        return _screenRoute(
          screen: BlocProvider(
            create: (context) => DependencyInjectionHelper().sl<ProfileCubit>()
              ..getProfileData()
              ..initProfileData(),
            child: EditProfileScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.additionalScreen:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: BlocProvider(
            create: (context) =>
                DependencyInjectionHelper().sl<ProfileCubit>()
                  ..getAdditionalPage(type: args['type']),
            child: AdditionalScreen(type: args['type']),
          ),
          settings: settings,
        );
      case AppRoutes.supportScreen:
        return _screenRoute(screen: SupportScreen(), settings: settings);
      case AppRoutes.addCategory:
        // var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: BlocProvider(
            create: (context) =>
                DependencyInjectionHelper().sl<VendorServiceCubit>(),
            child: AddCategoryScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.addBranch:
        // var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: BlocProvider(
            create: (context) =>
                DependencyInjectionHelper().sl<VendorServiceCubit>()
                  ..maxImages = 1,
            child: AddBranchScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.addService:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: BlocProvider(
            create: (context) {
              final cubit = DependencyInjectionHelper()
                  .sl<VendorServiceCubit>();

              if (args['type'] == 'resturant') {
                cubit.getAllBranches();
                if (args['isEdit'] == true) {
                  cubit.showResturant(id: args['id']);
                }
              } else if (args['type'] == 'hotel') {
                cubit.getAllBranches();
                if (args['isEdit'] == true) {
                  cubit.showHotel(id: args['id']);
                }
              } else {
                debugPrint('serviceID route ${args['id']}');
                cubit.getAllBranches();
                cubit.getAllTripSchedual();
                if (args['isEdit'] == true) {
                  cubit.showTrip(id: args['id']);
                }
              }

              return cubit; // return the Cubit instance
            },
            child: MainAddServiceScreen(
              type: args['type'],
              isEdit: args['isEdit'],
              id: args['id'],
            ),
          ),
          settings: settings,
        );
      case AppRoutes.addNewServiceScreen:
        // var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: BlocProvider(
            create: (context) =>
                DependencyInjectionHelper().sl<VendorServiceCubit>()
                  ..getAllBranches()
                  ..getAllCategory()
                  ..getVendorResturant()
                  ..loadVendorTypes(),
            child: AddNewServiceScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.addServiceOption:
        // var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: BlocProvider(
            create: (context) =>
                DependencyInjectionHelper().sl<VendorServiceCubit>()
                  ..getAllService(),
            child: AddServiceOptionScreen(),
          ),
          settings: settings,
        );
      case AppRoutes.reversionList:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: BlocProvider(
            create: (context) =>
                DependencyInjectionHelper().sl<ReversionCubit>()
                  ..serviceID = args['serviceID']
                  ..getAllReversion(),
            child: ReversionListScreen(serviceID: args['serviceID']),
          ),
          settings: settings,
        );
      case AppRoutes.reversionDetails:
        var args = (settings.arguments as Map<String, dynamic>);
        return _screenRoute(
          screen: ReversionDetailsScreen(reversionData: args['reversionData']),
          settings: settings,
        );
      case AppRoutes.scanQRScreen:
        return _screenRoute(
          screen: BlocProvider(
            create: (context) =>
                DependencyInjectionHelper().sl<ReversionCubit>(),
            child: QRScannerScreen(),
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

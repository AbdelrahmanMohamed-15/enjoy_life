import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/Constant/base_constant.dart';
import '../../../Core/Routes/app_navigation.dart';
import 'Core/Handler/auth_handler.dart';
import 'Core/Helper/dependency_injection_helper.dart';
import 'Core/Routes/route_generator.dart';
import 'Core/Themes/app_themes.dart';
import 'Core/main cubit/cubit/language_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await DependencyInjectionHelper().init();
  try {
    await DependencyInjectionHelper().sl<AuthHandlerInterface>().init();
  } catch (e) {
    // Handle initialization errors gracefully
    debugPrint('Error initializing AuthHandler in main: $e');
  }

  runApp(
    EasyLocalization(
      supportedLocales: const <Locale>[
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: Phoenix(
        child: Portal(
          child: BlocProvider<LanguageCubit>(
            create: (context) => LanguageCubit(context: context),
            child: const MyApp(),
          ),
        ),
      ),
    ),
  );
  configLoading();
  // NotificationNavigator(
  //   onRoutingMessage: (RemoteMessage message) {},
  //   onNoInitialMessage: () {},
  // );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..maskType = EasyLoadingMaskType
        .black // Blocks user interaction
    ..userInteractions =
        false // Prevents screen interactions while loading
    ..dismissOnTap = false; // Does not dismiss when tapped
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(393, 844),
      builder: (_, __) => BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          var languageCubit = LanguageCubit.get(context);
          return MaterialApp(
            title: BaseConstant.appName,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: ThemeMode.dark,
            navigatorKey: AppNavigation.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: languageCubit.currentLocale,
            builder: EasyLoading.init(
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.noScaling),
                child: child ?? const Scaffold(),
              ),
            ),
          );
        },
      ),
    );
  }
}

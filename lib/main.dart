import 'dart:async';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/Constant/base_constant.dart';
import '../../../Core/Routes/app_navigation.dart';
import 'Core/Handler/auth_handler.dart';
import 'Core/Services/push_notification_service.dart';
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
    debugPrint('Error initializing AuthHandler in main: $e');
  }

  final di = DependencyInjectionHelper();
  // Not awaited: Firebase and the token upload must never delay startup
  unawaited(di.sl<PushNotificationService>().init());
  final languageCubit = di.sl<LanguageCubit>();
  await languageCubit.initialize();

  final startLocale = languageCubit.currentLocale;

  runApp(
    EasyLocalization(
      supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: LanguageCubit.defaultLocale,
      startLocale: startLocale,
      child: Phoenix(
        child: Portal(
          child: BlocProvider<LanguageCubit>.value(
            value: languageCubit,
            child: const MyApp(),
          ),
        ),
      ),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
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
        buildWhen: (previous, current) => previous.locale != current.locale,
        builder: (context, state) {
          final locale = state.locale;
          final textDirection = locale.languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr;

          return MaterialApp(
            title: BaseConstant.appName,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: ThemeMode.dark,
            navigatorKey: AppNavigation.navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            locale: locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: [
              ...context.localizationDelegates,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: EasyLoading.init(
              builder: (context, child) => Directionality(
                textDirection: textDirection,
                child: MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.noScaling),
                  child: child ?? const Scaffold(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

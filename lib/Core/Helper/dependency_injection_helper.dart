import 'package:dio/dio.dart';
import 'package:easy_life/Features/Authentication/Data/DataSource/auth_datasource.dart';
import 'package:easy_life/Features/Authentication/Data/Repository/auth_repository_impl.dart';
import 'package:easy_life/Features/Authentication/Domain/Repository/auth_repository.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/login_usecases.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_life/Features/Home/Data/DataSource/home_datasource.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Features/Home/Data/Repository/home_repository_impl.dart';
import '../../Features/Home/Domain/Repository/home_repository.dart';
import '../../Features/Home/Domain/Usecases/get_sliders_usecases.dart';
import '../../Features/Home/Presentation/cubit/home_cubit.dart';
import '../Handler/auth_handler.dart';
import '../Services/network_service.dart';

class DependencyInjectionHelper {
  final sl = GetIt.instance; // sl = service locator
  // final NotificationService _notificationService = NotificationService();

  /// Registering all components to be able to use them later in the app
  /// Note: don't forget to call this in main.dart
  Future<void> init() async {
    await _registerCoreDependencies();
    await _registerDataSources();
    await _registerRepositories();
    await _registerUseCases();
    await _registerBloc();
    // await _initFirebase();
  }

  // Future<void> _initFirebase() async {
  //   await Firebase.initializeApp();
  //   final fcmToken = Platform.isAndroid
  //       ? await FirebaseMessaging.instance.getToken()
  //       : await FirebaseMessaging.instance.getAPNSToken();
  //   await _notificationService.setupNotifications();
  //   print("fcmToken$fcmToken");
  // }

  /// Registers all core components like services
  Future<void> _registerCoreDependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => flutterSecureStorage);
    // sl.registerLazySingleton<AuthService>(
    //   () => AuthService(sl()),
    // );
    sl.registerLazySingleton<NetworkService>(() {
      final Dio public = Dio();
      final Dio private = Dio();
      return NetworkService(publicDio: public, privateDio: private);
    });

    sl.registerSingleton<AuthHandlerInterface>(
      AuthHandler(secureStorage: sl<FlutterSecureStorage>()),
    );
  }

  /// Registers any [DATA SOURCE]
  Future<void> _registerDataSources() async {
    sl.registerLazySingleton<AuthDatasource>(
      () => AuthDatasource(publicDio: sl<NetworkService>().publicDio),
    );
    sl.registerLazySingleton<HomeDatasource>(
      () => HomeDatasource(privateDio: sl<NetworkService>().privateDio),
    );
  }

  /// Registers any [REPOSITORY]
  Future<void> _registerRepositories() async {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: sl<AuthDatasource>()),
    );
    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(homeDatasource: sl<HomeDatasource>()),
    );
  }

  /// Registers any [USE CASE]
  Future<void> _registerUseCases() async {
    sl.registerLazySingleton<LoginUsecases>(
      () => LoginUsecases(authRepository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton<GetSlidersUsecases>(
      () => GetSlidersUsecases(homeRepository: sl<HomeRepository>()),
    );
  }

  /// Registers any [Bloc]
  Future<void> _registerBloc() async {
    sl.registerFactory(() => AuthCubit(loginUsecases: sl<LoginUsecases>()));
    sl.registerFactory(
      () => HomeCubit(getSlidersUsecases: sl<GetSlidersUsecases>()),
    );
  }
}

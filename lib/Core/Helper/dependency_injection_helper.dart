import 'package:dio/dio.dart';
import 'package:easy_life/Features/Authentication/Data/DataSource/auth_datasource.dart';
import 'package:easy_life/Features/Authentication/Data/Repository/auth_repository_impl.dart';
import 'package:easy_life/Features/Authentication/Domain/Repository/auth_repository.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/active_email_usecases.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/login_usecases.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/register_usecases.dart';
import 'package:easy_life/Features/Authentication/Domain/UseCases/rest_password_usecase.dart';
import 'package:easy_life/Features/Authentication/Presentation/cubit/auth_cubit.dart';
import 'package:easy_life/Features/Cart/Data/DataSource/cart_datasource.dart';
import 'package:easy_life/Features/Cart/Domain/Usecases/get_cart_usecases.dart';
import 'package:easy_life/Features/Cart/Domain/Usecases/remove_item_cart_usecases.dart';
import 'package:easy_life/Features/Cart/Domain/Usecases/update_item_quantity_usecases.dart';
import 'package:easy_life/Features/Home/Data/DataSource/home_datasource.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_all_home_usecases.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_my_favourite_usecases.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_vendor_hotels_usecases.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_vendor_resturant_usecases.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_vendor_trips_usecases.dart';
import 'package:easy_life/Features/Order/Data/Datasource/order_datasource.dart';
import 'package:easy_life/Features/Order/Domain/Usecases/get_cancel_order_usecases.dart';
import 'package:easy_life/Features/Order/Domain/Usecases/get_complete_order_usecases.dart';
import 'package:easy_life/Features/Order/Domain/Usecases/get_pending_order_usecases.dart';
import 'package:easy_life/Features/Profile/Data/DataSource/profile_datasource.dart';
import 'package:easy_life/Features/Reversion/Data/Datasource/reversion_datasource.dart';
import 'package:easy_life/Features/Reversion/Domain/Usecases/get_all_reversion_usecases.dart';
import 'package:easy_life/Features/Reversion/Domain/Usecases/scan_order_usecases.dart';
import 'package:easy_life/Features/Services/Data/DataSource/service_datasource.dart';
import 'package:easy_life/Features/Services/Domain/Usecases/get_avaliable_tables_usecases.dart';
import 'package:easy_life/Features/Services/Domain/Usecases/get_avaliable_trips_usecases.dart';
import 'package:easy_life/Features/Services/Domain/Usecases/get_hotel_details_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_branch_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_category_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_hotel_usecaes.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_resturant_usecaes.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_service_otion_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_service_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_trip_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/get_all_branch_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/get_all_service_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/get_all_trip_schedule_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/show_hotel_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/show_resturant_usecase.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/show_trip_usecases.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Features/Authentication/Domain/UseCases/forget_password_usecases.dart';
import '../../Features/Authentication/Domain/UseCases/verify_reset_otp_usecases.dart';
import '../../Features/Cart/Data/Repository/cart_repository_impl.dart';
import '../../Features/Cart/Domain/Repository/cart_repository.dart';
import '../../Features/Cart/Domain/Usecases/create_order_usecases.dart';
import '../../Features/Cart/Domain/Usecases/store_session_usecases.dart';
import '../../Features/Cart/Presentation/cubit/cart_cubit.dart';
import '../../Features/Home/Data/Repository/home_repository_impl.dart';
import '../../Features/Home/Domain/Repository/home_repository.dart';
import '../../Features/Home/Domain/Usecases/add_favourite_usecases.dart';
import '../../Features/Home/Domain/Usecases/get_hotels_usecases.dart';
import '../../Features/Home/Domain/Usecases/get_resturant_usecases.dart';
import '../../Features/Home/Domain/Usecases/get_sliders_usecases.dart';
import '../../Features/Home/Domain/Usecases/get_trips_usecases.dart';
import '../../Features/Home/Domain/Usecases/remove_favourite_usecases.dart';
import '../../Features/Home/Presentation/cubit/home_cubit.dart';
import '../../Features/Order/Data/Repository/order_repository_impl.dart';
import '../../Features/Order/Domain/Repository/order_repository.dart';
import '../../Features/Order/Presentation/cubit/order_cubit.dart';
import '../../Features/Profile/Data/Repository/profile_repository_impl.dart';
import '../../Features/Profile/Domain/Repository/profile_repository.dart';
import '../../Features/Profile/Domain/Usecases/get_additional_usecases.dart';
import '../../Features/Profile/Domain/Usecases/get_profile_usecases.dart';
import '../../Features/Profile/Domain/Usecases/update_profile_usecases.dart';
import '../../Features/Profile/Presentation/cubit/profile_cubit.dart';
import '../../Features/Reversion/Data/Repository/reversion_repository_impl.dart';
import '../../Features/Reversion/Domain/Repository/reversion_repository.dart';
import '../../Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import '../../Features/Services/Data/Repository/service_repository_impl.dart';
import '../../Features/Services/Domain/Repository/service_repository.dart';
import '../../Features/Services/Domain/Usecases/add_to_cart_usecases.dart';
import '../../Features/Services/Domain/Usecases/get_avaliable_rooms_usecases.dart';
import '../../Features/Services/Domain/Usecases/get_resturant_details_usecases.dart';
import '../../Features/Services/Domain/Usecases/get_trip_details_usecases.dart';
import '../../Features/Services/Presentation/cubit/service_cubit.dart';
import '../../Features/vendorService/Data/DataSource/vendor_service_datasource.dart';
import '../../Features/vendorService/Data/Repository/vendor_service_repository_impl.dart';
import '../../Features/vendorService/Domain/Repository/vendor_service_repository.dart';
import '../../Features/vendorService/Domain/Usecases/get_all_category_usecases.dart';
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
    const FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
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
    sl.registerLazySingleton<ServiceDatasource>(
      () => ServiceDatasource(privateDio: sl<NetworkService>().privateDio),
    );
    sl.registerLazySingleton<CartDatasource>(
      () => CartDatasource(privateDio: sl<NetworkService>().privateDio),
    );
    sl.registerLazySingleton<OrderDatasource>(
      () => OrderDatasource(privateDio: sl<NetworkService>().privateDio),
    );
    sl.registerLazySingleton<ProfileDatasource>(
      () => ProfileDatasource(privateDio: sl<NetworkService>().privateDio),
    );
    sl.registerLazySingleton<VendorServiceDatasource>(
      () =>
          VendorServiceDatasource(privateDio: sl<NetworkService>().privateDio),
    );
    sl.registerLazySingleton<ReversionDatasource>(
      () => ReversionDatasource(privateDio: sl<NetworkService>().privateDio),
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
    sl.registerLazySingleton<ServiceRepository>(
      () => ServiceRepositoryImpl(serviceDatasource: sl<ServiceDatasource>()),
    );
    sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(cartDatasource: sl<CartDatasource>()),
    );
    sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(orderDatasource: sl<OrderDatasource>()),
    );
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(profileDatasource: sl<ProfileDatasource>()),
    );
    sl.registerLazySingleton<VendorServiceRepository>(
      () => VendorServiceRepositoryImpl(
        vendorServiceDatasource: sl<VendorServiceDatasource>(),
      ),
    );
    sl.registerLazySingleton<ReversionRepository>(
      () => ReversionRepositoryImpl(
        reversionDatasource: sl<ReversionDatasource>(),
      ),
    );
  }

  /// Registers any [USE CASE]
  Future<void> _registerUseCases() async {
    // usecase for Authentication
    sl.registerLazySingleton<LoginUsecases>(
      () => LoginUsecases(authRepository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton<RegisterUsecases>(
      () => RegisterUsecases(authRepository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton<ActiveEmailUsecases>(
      () => ActiveEmailUsecases(authRepository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton<ForgetPasswordUsecases>(
      () => ForgetPasswordUsecases(authRepository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton<VerifyResetOtpUsecases>(
      () => VerifyResetOtpUsecases(authRepository: sl<AuthRepository>()),
    );
    sl.registerLazySingleton<RestPasswordUsecase>(
      () => RestPasswordUsecase(authRepository: sl<AuthRepository>()),
    );

    // usecase for Home
    sl.registerLazySingleton<GetSlidersUsecases>(
      () => GetSlidersUsecases(homeRepository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<GetResturantUsecases>(
      () => GetResturantUsecases(homeRepository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<GetTripsUsecases>(
      () => GetTripsUsecases(homeRepository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<GetHotelsUsecases>(
      () => GetHotelsUsecases(homeRepository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<GetVendorResturantUsecases>(
      () => GetVendorResturantUsecases(homeRepository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<GetVendorHotelsUsecases>(
      () => GetVendorHotelsUsecases(homeRepository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<GetVendorTripsUsecases>(
      () => GetVendorTripsUsecases(homeRepository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<AddFavouriteUsecases>(
      () => AddFavouriteUsecases(homeRepository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<RemoveFavouriteUsecases>(
      () => RemoveFavouriteUsecases(homeRepository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<GetMyFavouriteUsecases>(
      () => GetMyFavouriteUsecases(homeRepository: sl<HomeRepository>()),
    );
    sl.registerLazySingleton<GetAllHomeUsecases>(
      () => GetAllHomeUsecases(homeRepository: sl<HomeRepository>()),
    );
    // usecase for Service
    sl.registerLazySingleton<GetResturantDetailsUsecases>(
      () => GetResturantDetailsUsecases(
        serviceRepository: sl<ServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<GetHotelDetailsUsecases>(
      () =>
          GetHotelDetailsUsecases(servicesRepository: sl<ServiceRepository>()),
    );
    sl.registerLazySingleton<GetTripDetailsUsecases>(
      () => GetTripDetailsUsecases(serviceRepository: sl<ServiceRepository>()),
    );
    sl.registerLazySingleton<GetAvaliableTablesUsecases>(
      () => GetAvaliableTablesUsecases(
        serviceRepository: sl<ServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<GetAvaliableRoomsUsecases>(
      () =>
          GetAvaliableRoomsUsecases(serviceRepository: sl<ServiceRepository>()),
    );
    sl.registerLazySingleton<AddToCartUsecases>(
      () => AddToCartUsecases(serviceRepository: sl<ServiceRepository>()),
    );
    sl.registerLazySingleton<GetAvaliableTripsUsecases>(
      () =>
          GetAvaliableTripsUsecases(serviceRepository: sl<ServiceRepository>()),
    );
    // usecase for Cart
    sl.registerLazySingleton<GetCartUsecases>(
      () => GetCartUsecases(cartRepository: sl<CartRepository>()),
    );
    sl.registerLazySingleton<RemoveItemCartUsecases>(
      () => RemoveItemCartUsecases(cartRepository: sl<CartRepository>()),
    );
    sl.registerLazySingleton<UpdateItemQuantityUsecases>(
      () => UpdateItemQuantityUsecases(cartRepository: sl<CartRepository>()),
    );
    sl.registerLazySingleton<CreateOrderUsecases>(
      () => CreateOrderUsecases(cartRepository: sl<CartRepository>()),
    );
    sl.registerLazySingleton<StoreSessionUsecases>(
      () => StoreSessionUsecases(cartRepository: sl<CartRepository>()),
    );

    // usecase for Order
    sl.registerLazySingleton<GetPendingOrderUsecases>(
      () => GetPendingOrderUsecases(orderRepository: sl<OrderRepository>()),
    );
    sl.registerLazySingleton<GetCompleteOrderUsecases>(
      () => GetCompleteOrderUsecases(orderRepository: sl<OrderRepository>()),
    );
    sl.registerLazySingleton<GetCancelOrderUsecases>(
      () => GetCancelOrderUsecases(orderRepository: sl<OrderRepository>()),
    );

    // usecase for Profile
    sl.registerLazySingleton<GetProfileUsecases>(
      () => GetProfileUsecases(profileRepository: sl<ProfileRepository>()),
    );
    sl.registerLazySingleton<UpdateProfileUsecases>(
      () => UpdateProfileUsecases(profileRepository: sl<ProfileRepository>()),
    );
    sl.registerLazySingleton<GetAdditionalUsecases>(
      () => GetAdditionalUsecases(profileRepository: sl<ProfileRepository>()),
    );

    // usecase for Vendor Service
    sl.registerLazySingleton<CreateCategoryUsecases>(
      () => CreateCategoryUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<CreateBranchUsecases>(
      () => CreateBranchUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<GetAllCategoryUsecases>(
      () => GetAllCategoryUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<GetAllBranchUsecases>(
      () => GetAllBranchUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<GetAllTripScheduleUsecases>(
      () => GetAllTripScheduleUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<CreateResturantUsecaes>(
      () => CreateResturantUsecaes(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<CreateHotelUsecaes>(
      () => CreateHotelUsecaes(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<CreateTripUsecases>(
      () => CreateTripUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<ShowResturantUsecase>(
      () => ShowResturantUsecase(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<ShowHotelUsecases>(
      () => ShowHotelUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<ShowTripUsecases>(
      () => ShowTripUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<GetAllServiceUsecases>(
      () => GetAllServiceUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<CreateServiceUsecases>(
      () => CreateServiceUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    sl.registerLazySingleton<CreateServiceOtionUsecases>(
      () => CreateServiceOtionUsecases(
        vendorServiceRepository: sl<VendorServiceRepository>(),
      ),
    );
    // usecase for Reversion
    sl.registerLazySingleton<GetAllReversionUsecases>(
      () => GetAllReversionUsecases(
        reversionRepository: sl<ReversionRepository>(),
      ),
    );
    sl.registerLazySingleton<ScanOrderUsecases>(
      () => ScanOrderUsecases(reversionRepository: sl<ReversionRepository>()),
    );
  }

  /// Registers any [Bloc]
  Future<void> _registerBloc() async {
    sl.registerFactory(
      () => AuthCubit(
        loginUsecases: sl<LoginUsecases>(),
        forgetPasswordUsecases: sl<ForgetPasswordUsecases>(),
        verifyResetOtpUsecases: sl<VerifyResetOtpUsecases>(),
        restPasswordUsecase: sl<RestPasswordUsecase>(),
        registerUsecases: sl<RegisterUsecases>(),
        activeEmailUsecases: sl<ActiveEmailUsecases>(),
      ),
    );
    sl.registerFactory(
      () => HomeCubit(
        getSlidersUsecases: sl<GetSlidersUsecases>(),
        getResturantUsecases: sl<GetResturantUsecases>(),
        getTripsUsecases: sl<GetTripsUsecases>(),
        getHotelsUsecases: sl<GetHotelsUsecases>(),
        getVendorResturantUsecases: sl<GetVendorResturantUsecases>(),
        getVendorHotelsUsecases: sl<GetVendorHotelsUsecases>(),
        getVendorTripsUsecases: sl<GetVendorTripsUsecases>(),
        addFavouriteUsecases: sl<AddFavouriteUsecases>(),
        removeFavouriteUsecases: sl<RemoveFavouriteUsecases>(),
        getMyFavouriteUsecases: sl<GetMyFavouriteUsecases>(),
        getAllHomeUsecases: sl<GetAllHomeUsecases>(),
      ),
    );
    sl.registerFactory(
      () => ServiceCubit(
        getResturantDetailsUsecases: sl<GetResturantDetailsUsecases>(),
        getHotelDetailsUsecases: sl<GetHotelDetailsUsecases>(),
        getTripDetailsUsecases: sl<GetTripDetailsUsecases>(),
        getAvaliableTablesUsecases: sl<GetAvaliableTablesUsecases>(),
        getAvaliableRoomsUsecases: sl<GetAvaliableRoomsUsecases>(),
        addToCartUsecases: sl<AddToCartUsecases>(),
        getAvaliableTripsUsecases: sl<GetAvaliableTripsUsecases>(),
      ),
    );
    sl.registerFactory(
      () => CartCubit(
        getCartUsecases: sl<GetCartUsecases>(),
        removeItemCartUsecases: sl<RemoveItemCartUsecases>(),
        updateItemQuantityUsecases: sl<UpdateItemQuantityUsecases>(),
        createOrderUsecases: sl<CreateOrderUsecases>(),
        storeSessionUsecases: sl<StoreSessionUsecases>(),
      ),
    );
    sl.registerFactory(
      () => OrderCubit(
        getPendingOrderUsecases: sl<GetPendingOrderUsecases>(),
        getCompleteOrderUsecases: sl<GetCompleteOrderUsecases>(),
        getCancelOrderUsecases: sl<GetCancelOrderUsecases>(),
      ),
    );
    sl.registerFactory(
      () => ProfileCubit(
        getProfileUsecases: sl<GetProfileUsecases>(),
        updateProfileUsecases: sl<UpdateProfileUsecases>(),
        getAdditionalUsecases: sl<GetAdditionalUsecases>(),
      ),
    );
    sl.registerFactory(
      () => VendorServiceCubit(
        createBranchUsecases: sl<CreateBranchUsecases>(),
        createCategoryUsecases: sl<CreateCategoryUsecases>(),
        getAllBranchUsecases: sl<GetAllBranchUsecases>(),
        getAllTripScheduleUsecases: sl<GetAllTripScheduleUsecases>(),
        createResturantUsecaes: sl<CreateResturantUsecaes>(),
        createHotelUsecaes: sl<CreateHotelUsecaes>(),
        createTripUsecases: sl<CreateTripUsecases>(),
        showResturantUsecase: sl<ShowResturantUsecase>(),
        showHotelUsecases: sl<ShowHotelUsecases>(),
        showTripUsecases: sl<ShowTripUsecases>(),
        getVendorResturantUsecases: sl<GetVendorResturantUsecases>(),
        getVendorHotelsUsecases: sl<GetVendorHotelsUsecases>(),
        getVendorTripsUsecases: sl<GetVendorTripsUsecases>(),
        getAllCategoryUsecases: sl<GetAllCategoryUsecases>(),
        getAllServiceUsecases: sl<GetAllServiceUsecases>(),
        createServiceUsecases: sl<CreateServiceUsecases>(),
        createServiceOtionUsecases: sl<CreateServiceOtionUsecases>(),
      ),
    );
    sl.registerFactory(
      () => ReversionCubit(
        getAllReversionUsecases: sl<GetAllReversionUsecases>(),
        scanOrderUsecases: sl<ScanOrderUsecases>(),
      ),
    );
  }
}

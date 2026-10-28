import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../Constant/base_constant.dart';
import '../Handler/auth_handler.dart';
import '../Handler/error_handler.dart';
import '../Handler/response_code.dart';
import '../Helper/dependency_injection_helper.dart';
import '../Helper/locale_storage.dart';
import '../main cubit/cubit/language_cubit.dart';
import '../L10n/locale_keys.dart';
import '../Routes/app_navigation.dart';
import '../Routes/app_routes.dart';
import '../Widget/custom_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';

/// Used to handle the network clients all over the app
class NetworkService {
  Dio publicDio;
  Dio privateDio;

  NetworkService({required this.publicDio, required this.privateDio}) {
    String baseUrl = BaseConstant.baseUrl;
    publicDio.options.baseUrl = baseUrl;
    privateDio.options.baseUrl = baseUrl;
    initializeInterceptors();
  }

  /// Initializing interceptors to be able to check network calls and handle errors
  initializeInterceptors() {
    privateDio.interceptors.clear();
    publicDio.interceptors.clear();

    /*(publicDio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      SecurityContext context = SecurityContext();
      var client = HttpClient(context: context);
      client.badCertificateCallback = (cert, host, port) => false;

      return client;
    };*/

    /*(privateDio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
        () {
      SecurityContext context = SecurityContext();
      var client = HttpClient(context: context);
      client.badCertificateCallback = (cert, host, port) => false;

      return client;
    };
*/
    publicDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Content-Type'] = "application/json";
          _setLanguageHeader(options);
          debugPrint('send request ${options.uri}');
          debugPrint('headers: ${options.headers}');
          debugPrint('query parameters: ${options.queryParameters}');
          debugPrint('data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          debugPrint('Response Body Data ${response.data.toString()}');
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          EasyLoading.dismiss();
          debugPrint('path: ${error.requestOptions.path}');
          debugPrint('response: ${error.response}');
          debugPrint('statusCode: ${error.response?.statusCode}');
          debugPrint('data: ${error.response?.data}');
          debugPrint('*************************************');
          handler.reject(error);
        },
      ),
    );

    privateDio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Authorization'] =
              'Bearer ${DependencyInjectionHelper().sl<AuthHandlerInterface>().getToken()}';
          options.headers['Content-Type'] = "application/json";
          if (DependencyInjectionHelper()
                  .sl<AuthHandlerInterface>()
                  .getCookies() !=
              null) {
            debugPrint(
              'cookie: ${DependencyInjectionHelper().sl<AuthHandlerInterface>().getCookies()}',
            );
            options.headers['Cookie'] = DependencyInjectionHelper()
                .sl<AuthHandlerInterface>()
                .getCookies()!;
          }
          options.headers['country_id'] = "1";
          _setLanguageHeader(options);
          debugPrint('send request ${options.uri}');
          debugPrint('headers: ${options.headers}');
          debugPrint('query parameters: ${options.queryParameters}');
          debugPrint('Data: ${options.data}');
          debugPrint('-----------------------------------------------');
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          debugPrint('Response Body Data ${response.data.toString()}');
          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          debugPrint('path: ${error.requestOptions.path}');
          debugPrint('response: ${error.response}');
          debugPrint('statusCode: ${error.response?.statusCode}');
          debugPrint('data: ${error.response?.data}');
          debugPrint('*************************************');

          ErrorHandler errorHandler = ErrorHandler.handle(error);
          if (errorHandler.failure.code == APIResponseCode.unauthorized) {
            await _onSessionExpired();
          }
          // Always pass the error on: returning without calling the handler
          // left the request's Future pending forever (endless spinners)
          handler.next(error);
        },
      ),
    );
  }

  static bool _handlingExpiry = false;

  /// The saved token was rejected: clear the session once (several requests
  /// may fail together) and send the user to log in again.
  Future<void> _onSessionExpired() async {
    final authHandler = DependencyInjectionHelper().sl<AuthHandlerInterface>();
    if (_handlingExpiry || authHandler.getToken() == null) return;
    _handlingExpiry = true;
    try {
      EasyLoading.dismiss();
      await authHandler.clearAllData();
      if (AppNavigation.navigatorKey.currentState != null) {
        AppNavigation.pushNamedAndRemoveUntil(
          AppRoutes.login,
          predicate: (_) => false,
        );
        showCustomSnackBar(
          LocaleKeys.commonSessionExpired.tr(),
          type: SnackBarType.warning,
        );
      }
    } finally {
      _handlingExpiry = false;
    }
  }

  void _setLanguageHeader(RequestOptions options) {
    final languageCode =
        DependencyInjectionHelper().sl<LocaleStorage>().getLanguageCode() ??
        LanguageCubit.defaultLocale.languageCode;
    options.headers['language'] = languageCode;
    options.headers['Accept-Language'] = languageCode;
  }
}

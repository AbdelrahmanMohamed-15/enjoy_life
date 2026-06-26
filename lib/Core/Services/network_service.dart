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
            // DependencyInjectionHelper().sl<AuthService>().clearAuth();
            // AppNavigation.pushNamedAndRemoveUntil(AppRoutes.login);
            return; //For stopping error propagation here if the error is handled
          }
          // You can pass the error to the next handler or modify it as needed
          handler.next(error); // Continue to propagate the error
        },
      ),
    );
  }

  void _setLanguageHeader(RequestOptions options) {
    final languageCode = DependencyInjectionHelper()
            .sl<LocaleStorage>()
            .getLanguageCode() ??
        LanguageCubit.defaultLocale.languageCode;
    options.headers['language'] = languageCode;
    options.headers['Accept-Language'] = languageCode;
  }
}

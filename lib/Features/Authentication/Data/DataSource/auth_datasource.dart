import 'package:dio/dio.dart';
import 'package:easy_life/Core/Constant/api_urls.dart';

class AuthDatasource {
  final Dio publicDio;
  const AuthDatasource({required this.publicDio});

  Future<Response> login({
    required String dailCode,
    required String phone,
    required String password,
  }) async {
    return await publicDio.post(
      ApiUrls.login,
      data: {'country_code': dailCode, 'phone': phone, 'password': password},
    );
  }

  Future<Response> register({
    required String dailCode,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String address,
  }) async {
    return await publicDio.post(
      ApiUrls.register,
      data: {
        'name': name,
        'full_name': name,
        'email': email,
        'verification_type': 2,
        'country_code': dailCode,
        'phone': phone,
        'address': address,
        'password': password,
        'password_confirmation': confirmPassword,
        'country_id': 1,
      },
    );
  }

  Future<Response> activeEmail({
    required String code,
    required String email,
  }) async {
    return await publicDio.post(
      ApiUrls.activeEmail,
      data: {'token': code, 'email': email},
    );
  }

  Future<Response> forgetPassword({required String email}) async {
    return await publicDio.post(ApiUrls.forgetPassword, data: {'email': email});
  }

  Future<Response> verifyRestCode({
    required String code,
    required String email,
  }) async {
    return await publicDio.post(
      ApiUrls.verifyRestCode,
      data: {'token': code, 'email': email},
    );
  }

  Future<Response> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await publicDio.post(
      ApiUrls.resetPassword,
      data: {
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );
  }

  Future<Response> updateFCM({required String fcmToken}) async {
    return await publicDio.post(
      ApiUrls.updateFCM,
      data: {'fcm_token': fcmToken},
    );
  }
}

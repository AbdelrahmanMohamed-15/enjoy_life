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
      data: {'dailCode': dailCode, 'phone': phone, 'password': password},
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
        'dailCode': dailCode,
        'name': name,
        'full_name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': confirmPassword,
        'address': address,
      },
    );
  }
}

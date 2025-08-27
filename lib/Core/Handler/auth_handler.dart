library auth_handler;

import 'dart:convert';

import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthHandlerInterface {
  String? getToken();

  Userdata? getUserData();

  String? getBoarding();

  String? getLanguageCode();

  Future<AuthHandlerInterface> init();

  Future<void> setToken(String token);

  Future<void> setOnBoarding(bool isFirst);

  Future<void> setLanguageCode(String languageCode);

  Future<void> setUserData(Userdata? data);
}

class AuthHandler implements AuthHandlerInterface {
  AuthHandler({required this.secureStorage});

  final FlutterSecureStorage secureStorage;
  String? _token;
  String? _boardnig;
  String? _languageCode;
  Userdata? _userData;

  @override
  String? getToken() => _token;

  @override
  Userdata? getUserData() => _userData;

  @override
  String? getBoarding() => _boardnig;

  @override
  String? getLanguageCode() => _languageCode;

  @override
  Future<void> setOnBoarding(bool isFirst) async {
    _boardnig = isFirst.toString();
    await secureStorage.write(key: 'boarding', value: isFirst.toString());
  }

  @override
  Future<AuthHandlerInterface> init() async {
    _token = await secureStorage.read(key: 'token');
    final userDataString = await secureStorage.read(key: 'userData');
    _userData = userDataString != null
        ? Userdata.fromJson(
            Map<String, dynamic>.from(json.decode(userDataString)),
          )
        : null;
    _boardnig = await secureStorage.read(key: 'boarding');
    _languageCode = await secureStorage.read(key: 'languageCode');
    return this;
  }

  @override
  Future<void> setUserData(Userdata? data) async {
    _userData = data;
    if (data == null) {
      await secureStorage.delete(key: 'userData');
      return;
    }
    await secureStorage.write(
      key: 'userData',
      value: json.encode(data.toJson()),
    );
  }

  @override
  Future<void> setToken(String token) async {
    _token = token;
    await secureStorage.write(key: 'token', value: token);
  }

  @override
  Future<void> setLanguageCode(String languageCode) async {
    _languageCode = languageCode;
    await secureStorage.write(key: 'languageCode', value: languageCode);
  }
}

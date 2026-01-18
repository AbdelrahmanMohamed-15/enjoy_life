library auth_handler;

import 'dart:convert';

import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthHandlerInterface {
  String? getToken();

  Userdata? getUserData();

  String? getBoarding();

  String? getLanguageCode();

  String? getCookies();

  Future<AuthHandlerInterface> init();

  Future<void> setToken(String token);

  Future<void> setCookies(String cookies);

  Future<void> setOnBoarding(bool isFirst);

  Future<void> setLanguageCode(String languageCode);

  Future<void> setUserData(Userdata? data);

  Future<void> clearAllData();
}

class AuthHandler implements AuthHandlerInterface {
  AuthHandler({required this.secureStorage});

  final FlutterSecureStorage secureStorage;
  String? _token;
  String? _boardnig;
  String? _languageCode;
  Userdata? _userData;
  String? _cookies;

  @override
  String? getToken() => _token;

  @override
  Userdata? getUserData() => _userData;

  @override
  String? getBoarding() => _boardnig;

  @override
  String? getLanguageCode() => _languageCode;

  @override
  String? getCookies() => _cookies;

  @override
  Future<void> setOnBoarding(bool isFirst) async {
    try {
      _boardnig = isFirst.toString();
      await secureStorage.write(key: 'boarding', value: isFirst.toString());
    } catch (e) {
      debugPrint('Error setting onboarding: $e');
    }
  }

  @override
  Future<AuthHandlerInterface> init() async {
    try {
      _token = await secureStorage.read(key: 'token');
      final userDataString = await secureStorage.read(key: 'userData');
      _userData = userDataString != null
          ? Userdata.fromJson(
              Map<String, dynamic>.from(json.decode(userDataString)),
            )
          : null;
      _boardnig = await secureStorage.read(key: 'boarding');
      _languageCode = await secureStorage.read(key: 'languageCode');
      _cookies = await secureStorage.read(key: 'cookies');
    } catch (e) {
      // Handle platform channel errors gracefully
      // If secure storage fails, continue with null values
      // This can happen if KeyStore is not available or during app initialization
      debugPrint('Error initializing AuthHandler: $e');
      // Set default values to prevent null reference errors
      _token = null;
      _userData = null;
      _boardnig = null;
      _languageCode = null;
      _cookies = null;
    }
    return this;
  }

  @override
  Future<void> setUserData(Userdata? data) async {
    try {
      _userData = data;
      if (data == null) {
        await secureStorage.delete(key: 'userData');
        return;
      }
      await secureStorage.write(
        key: 'userData',
        value: json.encode(data.toJson()),
      );
    } catch (e) {
      debugPrint('Error setting user data: $e');
    }
  }

  @override
  Future<void> setToken(String token) async {
    try {
      _token = token;
      await secureStorage.write(key: 'token', value: token);
    } catch (e) {
      debugPrint('Error setting token: $e');
    }
  }

  @override
  Future<void> setLanguageCode(String languageCode) async {
    try {
      _languageCode = languageCode;
      await secureStorage.write(key: 'languageCode', value: languageCode);
    } catch (e) {
      debugPrint('Error setting language code: $e');
    }
  }

  @override
  Future<void> clearAllData() async {
    try {
      await setUserData(null);
      await secureStorage.delete(key: 'userData');
      await secureStorage.delete(key: 'token');
      await secureStorage.delete(key: 'cookies');
      await secureStorage.delete(key: 'languageCode');
      // await secureStorage.delete(key: 'boarding');
      _token = null;
      _userData = null;
      // _boardnig = null;
      _languageCode = null;
      _cookies = null;
    } catch (e) {
      debugPrint('Error clearing data: $e');
    }
  }

  @override
  Future<void> setCookies(String cookies) async {
    try {
      _cookies = cookies;
      await secureStorage.write(key: 'cookies', value: cookies);
    } catch (e) {
      debugPrint('Error setting cookies: $e');
    }
  }
}

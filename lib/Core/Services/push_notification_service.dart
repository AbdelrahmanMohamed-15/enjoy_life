import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../Constant/api_urls.dart';
import '../Handler/auth_handler.dart';
import '../Helper/default_firebase_option.dart';
import '../Routes/app_navigation.dart';
import '../Routes/app_routes.dart';
import '../Widget/custom_snack_bar.dart';

/// Firebase Cloud Messaging setup and FCM token registration.
///
/// The backend only accepts the token from a logged-in user, so it is sent
/// with the auth token after login, at startup when a session exists, and
/// whenever Firebase rotates it.
class PushNotificationService {
  PushNotificationService({
    required this.privateDio,
    required this.authHandler,
  });

  final Dio privateDio;
  final AuthHandlerInterface authHandler;
  bool _ready = false;

  /// Started without awaiting from main, so a slow network or Firebase never
  /// keeps the app on the launch screen.
  Future<void> init() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _ready = true;
      final messaging = FirebaseMessaging.instance;
      // Android 13+ and iOS need the user's permission to show notifications
      await messaging.requestPermission();

      messaging.onTokenRefresh.listen(_upload);
      FirebaseMessaging.onMessage.listen(_showInApp);
      FirebaseMessaging.onMessageOpenedApp.listen((_) => _openNotifications());

      await syncToken();
    } catch (e) {
      debugPrint('Push notifications init error: $e');
    }
  }

  /// Sends the current FCM token to the backend if a user is logged in.
  Future<void> syncToken() async {
    if (!_ready || authHandler.getToken() == null) return;
    try {
      final token = await FirebaseMessaging.instance.getToken().timeout(
        const Duration(seconds: 15),
      );
      if (token != null) await _upload(token);
    } catch (e) {
      debugPrint('FCM token error: $e');
    }
  }

  Future<void> _upload(String token) async {
    if (authHandler.getToken() == null) return;
    try {
      await privateDio.post(ApiUrls.updateFCM, data: {'fcm_token': token});
      debugPrint('FCM token registered');
    } catch (e) {
      debugPrint('FCM token upload error: $e');
    }
  }

  /// Android shows nothing for messages received in the foreground, so show
  /// them as an in-app banner.
  void _showInApp(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;
    final text = [
      notification.title,
      notification.body,
    ].whereType<String>().where((s) => s.trim().isNotEmpty).join('\n');
    showCustomSnackBar(text, type: SnackBarType.info);
  }

  void _openNotifications() {
    if (AppNavigation.navigatorKey.currentState == null) return;
    AppNavigation.pushNamed(AppRoutes.notification);
  }
}

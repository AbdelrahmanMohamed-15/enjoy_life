import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<bool> openUri(Uri uri) async {
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      return launched;
    } on PlatformException {
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> openLink(String url) async {
    return openUri(Uri.parse(url));
  }

  static Future<bool> openPhone(String phone) async {
    final cleanedPhone = phone.replaceAll(RegExp(r'\s+'), '');
    return openUri(Uri(scheme: 'tel', path: cleanedPhone));
  }

  static Future<bool> openEmail(String email) async {
    return openUri(
      Uri(
        scheme: 'mailto',
        path: email,
      ),
    );
  }

  static Future<bool> openWhatsApp(String phone) async {
    final cleanedPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    return openUri(Uri.parse('https://wa.me/$cleanedPhone'));
  }
}

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AppLinkHelper {
  final AppLinks _appLinks = AppLinks();

  /// Initializes the deep link listener
  void initDeepLinkListener({required BuildContext context}) {
    _appLinks.uriLinkStream.listen(
      (Uri? deepLink) {
        if (deepLink != null) {
          _handleDeepLink(context: context, deepLink: deepLink);
        }
      },
      onError: (error) {
        debugPrint("Error listening to deep links: $error");
      },
    );
  }

  /// Handles incoming deep links
  void _handleDeepLink({required BuildContext context, required Uri deepLink}) {
    final pathSegments = deepLink.pathSegments;
    if (pathSegments.isNotEmpty) {
      final type = pathSegments[0];
      final id = pathSegments.length > 1 ? pathSegments[1] : null;
      if (type == '') {
      } else if (type == '') {
      } else if (type == '' && id != null) {
      } else if (type == '' && id != null) {}
    }
  }

  /// Creates and shares a link
  void createAndShareLink({required String type, required String id}) {
    const String baseUrl = "https://hypelify.com";
    final Uri shareLink = Uri.parse("$baseUrl/$type/$id");
    SharePlus.instance.share(ShareParams(text: "$shareLink"));
  }
}

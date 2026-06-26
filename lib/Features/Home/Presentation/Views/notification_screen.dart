import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Themes/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.homeNotificationsTitle.tr()),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios, color: AppColors.primary500),
          ),
          elevation: 2,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsStrings.empty),
            const SizedBox(height: 20),
            Center(
              child: Text(
                LocaleKeys.homeNotificationsEmpty.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 17,
                  color: AppColors.black700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

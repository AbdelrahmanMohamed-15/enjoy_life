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
          title: const Text('الاشعارات'),
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
                'لا توجد اشعارات حالياً',
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

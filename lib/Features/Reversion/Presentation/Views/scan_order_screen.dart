import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:easy_life/Core/Routes/routes.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../Core/Themes/app_colors.dart';

class ScanOrderScreen extends StatelessWidget {
  const ScanOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مسح الطلب',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 20,
            color: AppColors.primary500,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImageView(data: '', size: 200).setCenter(),
          const SizedBox(height: 20),
          Text(
            'قم بمسح الكود الخاص بالطلب لتأكيد الحجز الخاص بك',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.primary500,
              fontFamily: BaseConstant.cairoBold,
            ),
          ).setCenter(),
          const SizedBox(height: 30),
          MainAppButton(
            child: Text(
              'مسح الكود',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.natural100,
                fontFamily: BaseConstant.cairoBold,
              ),
            ),
            onTap: () {
              AppNavigation.pushNamed(AppRoutes.scanQRScreen);
            },
          ),
        ],
      ),
    );
  }
}

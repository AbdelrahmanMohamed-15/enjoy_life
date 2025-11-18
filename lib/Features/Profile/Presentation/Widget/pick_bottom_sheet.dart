import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Core/Constant/assets_strings.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../cubit/profile_cubit.dart';

pickupBottomSheet({required ProfileCubit profileCubit}) {
  var theme = Theme.of(AppNavigation.globalContext);
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor: AppColors.natural200,
    context: AppNavigation.globalContext,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            'اختر صورة من',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 18,
              fontFamily: BaseConstant.cairoBold,
            ),
          ).setCenter(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    AppNavigation.pop();
                    profileCubit.pickImage(source: ImageSource.camera);
                  },
                  child: Container(
                    height: 118,
                    decoration: BoxDecoration(
                      color: AppColors.natural100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetsStrings.camera,
                          height: 34,
                          width: 34,
                          color: AppColors.primary400,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'الكاميرا',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontFamily: BaseConstant.cairoBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    AppNavigation.pop();
                    profileCubit.pickImage(source: ImageSource.gallery);
                  },
                  child: Container(
                    height: 118,
                    decoration: BoxDecoration(
                      color: AppColors.natural100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetsStrings.gallery,
                          height: 34,
                          width: 34,
                          color: AppColors.primary400,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'المعرض',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontFamily: BaseConstant.cairoBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ).setHorizontalPadding(
            AppNavigation.globalContext,
            25,
            enableMediaQuery: false,
          ),
          const SizedBox(height: 40),
        ],
      );
    },
  );
}

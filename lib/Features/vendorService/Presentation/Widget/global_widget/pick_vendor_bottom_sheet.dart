import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Routes/app_navigation.dart';
import '../../../../../Core/Themes/app_colors.dart';

pickuVendorpBottomSheet({
  VendorServiceCubit? vendorServiceCubit,
  required String type,
  Function()? onCameraTap,
  Function()? onGalleryTap,
}) {
  var theme = Theme.of(AppNavigation.globalContext);
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor: AppColors.natural50,
    context: AppNavigation.globalContext,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            LocaleKeys.vendorPickImageTitle.tr(),
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
                  onTap:
                      onCameraTap ??
                      () {
                        AppNavigation.pop();
                        if (type == 'logo') {
                          vendorServiceCubit!.pickLogoFile(
                            source: ImageSource.camera,
                          );
                        } else {
                          vendorServiceCubit!.pickFile(
                            source: ImageSource.camera,
                          );
                        }
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
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 34,
                          color: AppColors.primary500,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          LocaleKeys.vendorPickCamera.tr(),
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
                  onTap:
                      onGalleryTap ??
                      () {
                        AppNavigation.pop();
                        if (type == 'logo') {
                          vendorServiceCubit!.pickLogoFile(
                            source: ImageSource.gallery,
                          );
                        } else {
                          vendorServiceCubit!.pickFile(
                            source: ImageSource.gallery,
                          );
                        }
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
                        Icon(
                          Icons.image_outlined,
                          size: 34,
                          color: AppColors.primary500,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          LocaleKeys.vendorPickGallery.tr(),
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

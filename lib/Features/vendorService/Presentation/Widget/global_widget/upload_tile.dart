import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UploadTile extends StatelessWidget {
  const UploadTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.primary100.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary300.withValues(alpha: 0.7),
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.cloud_upload_rounded,
              color: AppColors.primary500,
              size: 26,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.vendorUploadImage.tr(),
            style: const TextStyle(
              fontSize: 14,
              fontFamily: BaseConstant.cairoBold,
              color: AppColors.black700,
            ),
          ),
          Text(
            LocaleKeys.vendorUploadHint.tr(),
            style: const TextStyle(fontSize: 11, color: AppColors.natural500),
          ),
        ],
      ),
    );
  }
}

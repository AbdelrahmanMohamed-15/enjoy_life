import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UploadTile extends StatelessWidget {
  const UploadTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tileColor: AppColors.natural50,
      leading: CircleAvatar(
        backgroundColor: AppColors.natural100,
        radius: 20.0,
        child: const Icon(
          Icons.cloud_upload_outlined,
          color: AppColors.primary500,
        ),
      ),
      title: Text(
        LocaleKeys.vendorUploadImage.tr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          fontFamily: BaseConstant.cairoBold,
        ),
      ),
    );
  }
}

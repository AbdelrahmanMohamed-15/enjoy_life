import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:flutter/material.dart';
import '../../../../../Core/Themes/app_colors.dart';

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
        'أرفق الصورة من هنا',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          fontFamily: BaseConstant.cairoBold,
        ),
      ),
    );
  }
}

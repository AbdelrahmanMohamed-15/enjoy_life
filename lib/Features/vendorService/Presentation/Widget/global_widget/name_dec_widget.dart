import 'package:easy_life/Core/Helper/input_validator.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';

class NameDecWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const NameDecWidget({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.natural50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vendorServiceCubit.language != 'ar'
                      ? LocaleKeys.vendorNameEn.tr()
                      : LocaleKeys.vendorNameAr.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.black700,
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
                SizedBox(height: 15),
                CustomTextFormField(
                  controller: vendorServiceCubit.language == 'ar'
                      ? vendorServiceCubit.nameArController
                      : vendorServiceCubit.nameEnController,
                  hintText: vendorServiceCubit.language != 'ar'
                      ? LocaleKeys.vendorNameEnHint.tr()
                      : LocaleKeys.vendorNameArHint.tr(),
                  validator: (value) => InputValidator.validateName(value!),
                ),
                SizedBox(height: 15),
                Text(
                  vendorServiceCubit.language != 'ar'
                      ? LocaleKeys.vendorDescriptionEn.tr()
                      : LocaleKeys.vendorDescriptionAr.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.black700,
                    fontFamily: BaseConstant.cairoBold,
                  ),
                ),
                SizedBox(height: 15),
                CustomTextFormField(
                  controller: vendorServiceCubit.language == 'ar'
                      ? vendorServiceCubit.descriptionArController
                      : vendorServiceCubit.descriptionEnController,
                  hintText: vendorServiceCubit.language != 'ar'
                      ? LocaleKeys.vendorDescriptionEnHint.tr()
                      : LocaleKeys.vendorDescriptionArHint.tr(),
                  validator: (value) => InputValidator.validateName(value!),
                  maxLines: 4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

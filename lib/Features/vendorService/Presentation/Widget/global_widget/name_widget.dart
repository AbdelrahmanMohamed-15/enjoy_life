import 'package:easy_life/Core/Helper/input_validator.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/vendor_service_cubit.dart';
import 'vendor_form_kit.dart';

class NameWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const NameWidget({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        final isAr = vendorServiceCubit.language == 'ar';
        return VendorSectionCard(
          icon: Icons.badge_rounded,
          title: LocaleKeys.vendorSectionBasic.tr(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VendorFieldLabel(
                  isAr
                      ? LocaleKeys.vendorNameAr.tr()
                      : LocaleKeys.vendorNameEn.tr(),
                ),
                CustomTextFormField(
                  // A new key per language so the field swaps controllers
                  key: ValueKey('name_${vendorServiceCubit.language}'),
                  controller: isAr
                      ? vendorServiceCubit.nameArController
                      : vendorServiceCubit.nameEnController,
                  hintText: isAr
                      ? LocaleKeys.vendorNameArHint.tr()
                      : LocaleKeys.vendorNameEnHint.tr(),
                  validator: (value) => InputValidator.validateNotEmpty(value),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

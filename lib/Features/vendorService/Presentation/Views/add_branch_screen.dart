import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/location_picker_widget.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/country_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/field_header_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/language_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/logo_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/name_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/status_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Helper/input_validator.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_snack_bar.dart';
import '../Widget/global_widget/service_image_widget.dart';

class AddBranchScreen extends StatelessWidget {
  const AddBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.natural100,
              title: Text(
                LocaleKeys.vendorAddBranch.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary500,
                  fontFamily: BaseConstant.cairoBold,
                ),
              ),
              elevation: 1,
              leading: GestureDetector(
                onTap: () {
                  AppNavigation.pop();
                },
                child: Icon(Icons.arrow_back_ios, color: AppColors.primary500),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              children: [
                LanguageWidget(),
                NameWidget(formKey: vendorServiceCubit.formKey),
                FieldHeaderWidget(
                  controller: vendorServiceCubit.addressArController,
                  label: LocaleKeys.vendorAddress.tr(),
                  hintText: LocaleKeys.vendorAddressHint.tr(),
                  maxLines: 4,
                  validator: (value) => InputValidator.validateNotEmpty(value),
                ),
                FieldHeaderWidget(
                  controller: vendorServiceCubit.phoneController,
                  label: LocaleKeys.vendorPhone.tr(),
                  hintText: LocaleKeys.vendorPhoneHint.tr(),
                  keyboardType: TextInputType.phone,
                  validator: (value) => InputValidator.validateNumbers(value),
                ),
                const SizedBox(height: 20),
                LocationPickerWidget(
                  // Reuse the chosen pin when the page is rebuilt
                  initialLatitude: vendorServiceCubit.initialLatitude,
                  initialLongitude: vendorServiceCubit.initialLongitude,
                  onLocationSelected: (lat, lng) {
                    vendorServiceCubit.setLatitudeLongitude(
                      latitude: lat,
                      longitude: lng,
                    );
                  },
                ),
                const SizedBox(height: 20),
                LogoWidget(),
                ServiceImageWidget(isEdit: false),
                CountryWidget(),
                StatusWidget(),
                const SizedBox(height: 20),
                MainAppButton(
                  child: Text(
                    LocaleKeys.commonAdd.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.natural50,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                  onTap: () {
                    if (vendorServiceCubit.nameArController.text.isEmpty ||
                        vendorServiceCubit.nameEnController.text.isEmpty) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationNameBoth.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    if (vendorServiceCubit.addressArController.text.isEmpty) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationAddressAr.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    if (vendorServiceCubit.phoneController.text.isEmpty) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationPhone.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    if (vendorServiceCubit.logoImage == null) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationLogoRequired.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    if (vendorServiceCubit.imageFiles.isEmpty) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationBranchImageRequired.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    if (vendorServiceCubit.initialLatitude == null ||
                        vendorServiceCubit.initialLongitude == null) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationLocationRequired.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    vendorServiceCubit.createBranch();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

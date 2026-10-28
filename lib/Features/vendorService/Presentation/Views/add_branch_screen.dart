import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/location_picker_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/country_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/field_header_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/language_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/logo_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/name_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/status_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/vendor_form_kit.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Helper/input_validator.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_snack_bar.dart';
import '../Widget/global_widget/service_image_widget.dart';

class AddBranchScreen extends StatelessWidget {
  const AddBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: VendorAppBar(title: LocaleKeys.vendorAddBranch.tr()),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                const LanguageWidget(),
                NameWidget(formKey: vendorServiceCubit.formKey),
                VendorContactSection(vendorServiceCubit: vendorServiceCubit),
                VendorSectionCard(
                  icon: Icons.photo_library_rounded,
                  title: LocaleKeys.vendorSectionMedia.tr(),
                  child: const Column(
                    children: [LogoWidget(), ServiceImageWidget(isEdit: false)],
                  ),
                ),
                VendorSectionCard(
                  icon: Icons.tune_rounded,
                  title: LocaleKeys.vendorSectionSettings.tr(),
                  child: const Column(
                    children: [CountryWidget(), StatusWidget()],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: VendorSubmitButton(
              label: LocaleKeys.vendorAddBranch.tr(),
              icon: Icons.add_business_rounded,
              onTap: () {
                if (!vendorServiceCubit.validateBilingual()) return;
                if (!vendorServiceCubit.validateContact()) return;
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
                vendorServiceCubit.createBranch();
              },
            ),
          ),
        );
      },
    );
  }
}

/// Address, phone and map picker. Shared by Add Branch and the first step of
/// Add Restaurant / Hotel / Trip.
class VendorContactSection extends StatelessWidget {
  final VendorServiceCubit vendorServiceCubit;
  const VendorContactSection({super.key, required this.vendorServiceCubit});

  @override
  Widget build(BuildContext context) {
    return VendorSectionCard(
      icon: Icons.location_on_rounded,
      title: LocaleKeys.vendorSectionContact.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FieldHeaderWidget(
            controller: vendorServiceCubit.addressArController,
            label: LocaleKeys.vendorAddress.tr(),
            hintText: LocaleKeys.vendorAddressHint.tr(),
            icon: Icons.home_work_rounded,
            maxLines: 3,
            validator: (value) => InputValidator.validateNotEmpty(value),
          ),
          FieldHeaderWidget(
            controller: vendorServiceCubit.phoneController,
            label: LocaleKeys.vendorPhone.tr(),
            hintText: LocaleKeys.vendorPhoneHint.tr(),
            icon: Icons.phone_rounded,
            keyboardType: TextInputType.phone,
            validator: (value) => InputValidator.validateNumbers(value),
          ),
          VendorFieldLabel(LocaleKeys.vendorLocation.tr()),
          LocationPickerWidget(
            initialLatitude: vendorServiceCubit.initialLatitude,
            initialLongitude: vendorServiceCubit.initialLongitude,
            onLocationSelected: (lat, lng) {
              vendorServiceCubit.setLatitudeLongitude(
                latitude: lat,
                longitude: lng,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.touch_app_rounded,
                  size: 14,
                  color: AppColors.natural500,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    LocaleKeys.vendorLocationHint.tr(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.natural500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

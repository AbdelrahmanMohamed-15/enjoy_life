import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/country_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/language_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/logo_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/name_dec_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/status_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/type_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/vendor_form_kit.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/service_widget/service_branch_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/service_widget/service_category_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/service_widget/service_info_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_snack_bar.dart';
import '../Widget/service_widget/service_type_widget.dart';

class AddNewServiceScreen extends StatelessWidget {
  const AddNewServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: VendorAppBar(title: LocaleKeys.vendorAddService.tr()),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                const LanguageWidget(withDescription: true),
                NameDecWidget(formKey: vendorServiceCubit.formKey),
                VendorSectionCard(
                  icon: Icons.link_rounded,
                  title: LocaleKeys.vendorSectionLinks.tr(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        const TypeWidget(),
                        ServiceTypeWidget(
                          vendorServiceCubit: vendorServiceCubit,
                        ),
                        ServiceBranchWidget(
                          vendorServiceCubit: vendorServiceCubit,
                        ),
                        ServiceCategoryWidget(
                          vendorServiceCubit: vendorServiceCubit,
                        ),
                      ],
                    ),
                  ),
                ),
                VendorSectionCard(
                  icon: Icons.sell_rounded,
                  title: LocaleKeys.vendorSectionPricing.tr(),
                  child: const ServiceInfoWidget(),
                ),
                VendorSectionCard(
                  icon: Icons.photo_library_rounded,
                  title: LocaleKeys.vendorSectionMedia.tr(),
                  child: LogoWidget(label: LocaleKeys.vendorImages.tr()),
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
              label: LocaleKeys.vendorAddService.tr(),
              icon: Icons.room_service_rounded,
              onTap: () {
                if (!vendorServiceCubit.validateBilingual(
                  withDescription: true,
                )) {
                  return;
                }
                String? error;
                if (vendorServiceCubit.selectedService == 0) {
                  error = LocaleKeys.vendorValidationServiceTypeRequired.tr();
                } else if (vendorServiceCubit.branchID == 0) {
                  error = LocaleKeys.vendorValidationBranchRequired.tr();
                } else if (vendorServiceCubit.catID == 0) {
                  error = LocaleKeys.vendorValidationCategoryRequired.tr();
                }
                if (error != null) {
                  showCustomSnackBar(error, backgroundColor: AppColors.darkRed);
                  return;
                }
                if (!vendorServiceCubit.validatePricing()) return;
                if (vendorServiceCubit.logoImage == null) {
                  showCustomSnackBar(
                    LocaleKeys.vendorValidationImageRequired.tr(),
                    backgroundColor: AppColors.darkRed,
                  );
                  return;
                }
                vendorServiceCubit.createService();
              },
            ),
          ),
        );
      },
    );
  }
}

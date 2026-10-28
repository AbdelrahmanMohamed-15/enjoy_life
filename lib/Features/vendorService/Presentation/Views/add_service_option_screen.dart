import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/country_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/language_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/name_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/status_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/vendor_form_kit.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/service_widget/all_service_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/service_widget/service_info_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_snack_bar.dart';

class AddServiceOptionScreen extends StatelessWidget {
  const AddServiceOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: VendorAppBar(title: LocaleKeys.vendorAddServiceOption.tr()),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                const LanguageWidget(),
                NameWidget(formKey: vendorServiceCubit.formKey),
                VendorSectionCard(
                  icon: Icons.link_rounded,
                  title: LocaleKeys.vendorSectionLinks.tr(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AllServiceWidget(
                      vendorServiceCubit: vendorServiceCubit,
                    ),
                  ),
                ),
                VendorSectionCard(
                  icon: Icons.sell_rounded,
                  title: LocaleKeys.vendorSectionPricing.tr(),
                  child: const ServiceInfoWidget(),
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
              label: LocaleKeys.vendorAddServiceOption.tr(),
              icon: Icons.playlist_add_rounded,
              onTap: () {
                if (!vendorServiceCubit.validateBilingual()) return;
                if (vendorServiceCubit.selectedService == 0) {
                  showCustomSnackBar(
                    LocaleKeys.vendorValidationServiceRequired.tr(),
                    backgroundColor: AppColors.darkRed,
                  );
                  return;
                }
                if (!vendorServiceCubit.validatePricing()) return;
                vendorServiceCubit.createServiceOption();
              },
            ),
          ),
        );
      },
    );
  }
}

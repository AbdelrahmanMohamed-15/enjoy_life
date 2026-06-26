import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/country_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/language_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/name_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/status_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/service_widget/all_service_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/service_widget/service_info_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_snack_bar.dart';

class AddServiceOptionScreen extends StatelessWidget {
  const AddServiceOptionScreen({super.key});

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
                LocaleKeys.vendorAddServiceOption.tr(),
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
                AllServiceWidget(vendorServiceCubit: vendorServiceCubit),
                ServiceInfoWidget(),
                CountryWidget(),
                StatusWidget(),
                const SizedBox(height: 40),
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
                    if (vendorServiceCubit.selectedService == 0) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationServiceRequired.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    if (vendorServiceCubit.priceController.text.isEmpty) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationPriceRequired.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    if (vendorServiceCubit.discountController.text.isEmpty) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationDiscountRequired.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    vendorServiceCubit.createServiceOption();
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

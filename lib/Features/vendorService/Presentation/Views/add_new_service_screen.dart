import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/country_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/language_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/logo_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/name_dec_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/status_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/type_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/service_widget/service_branch_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/service_widget/service_category_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/service_widget/service_info_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Constant/base_constant.dart';
import '../../../../Core/Routes/app_navigation.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_snack_bar.dart';
import '../Widget/service_widget/service_type_widget.dart';

class AddNewServiceScreen extends StatefulWidget {
  const AddNewServiceScreen({super.key});

  @override
  State<AddNewServiceScreen> createState() => _AddNewServiceScreenState();
}

class _AddNewServiceScreenState extends State<AddNewServiceScreen> {
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
                LocaleKeys.vendorAddService.tr(),
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
                NameDecWidget(formKey: vendorServiceCubit.formKey),
                ServiceBranchWidget(vendorServiceCubit: vendorServiceCubit),
                ServiceCategoryWidget(vendorServiceCubit: vendorServiceCubit),
                TypeWidget(),
                ServiceTypeWidget(vendorServiceCubit: vendorServiceCubit),
                ServiceInfoWidget(),
                CountryWidget(),
                LogoWidget(),
                StatusWidget(),
                const SizedBox(height: 20),
                MainAppButton(
                  child: Text(
                    LocaleKeys.vendorAddService.tr(),
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
                    if (vendorServiceCubit
                            .descriptionArController
                            .text
                            .isEmpty ||
                        vendorServiceCubit
                            .descriptionEnController
                            .text
                            .isEmpty) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationDescriptionBoth.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    if (vendorServiceCubit.branchID == 0) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationBranchRequired.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    if (vendorServiceCubit.catID == 0) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationCategoryRequired.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    if (vendorServiceCubit.selectedService == 0) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationServiceTypeRequired.tr(),
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
                    if (vendorServiceCubit.logoImage == null) {
                      showCustomSnackBar(
                        LocaleKeys.vendorValidationImageRequired.tr(),
                        backgroundColor: AppColors.darkRed,
                      );
                      return;
                    }
                    vendorServiceCubit.createService();
                  },
                ).setVerticalPadding(context, 20, enableMediaQuery: false),
              ],
            ),
          ),
        );
      },
    );
  }
}

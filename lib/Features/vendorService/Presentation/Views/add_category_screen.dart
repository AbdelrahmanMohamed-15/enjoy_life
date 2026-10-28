import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/language_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/name_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/status_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/vendor_form_kit.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Themes/app_colors.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: VendorAppBar(title: LocaleKeys.vendorAddCategory.tr()),
            body: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                const LanguageWidget(),
                NameWidget(formKey: vendorServiceCubit.formKey),
                VendorSectionCard(
                  icon: Icons.tune_rounded,
                  title: LocaleKeys.vendorSectionSettings.tr(),
                  child: const StatusWidget(),
                ),
              ],
            ),
            bottomNavigationBar: VendorSubmitButton(
              label: LocaleKeys.vendorAddCategory.tr(),
              icon: Icons.add_circle_rounded,
              onTap: () {
                if (!vendorServiceCubit.validateBilingual()) return;
                vendorServiceCubit.createCategory();
              },
            ),
          ),
        );
      },
    );
  }
}

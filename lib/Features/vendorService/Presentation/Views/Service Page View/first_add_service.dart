import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/language_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/name_widget.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Helper/input_validator.dart';
import '../../../../../Core/Widget/location_picker_widget.dart';
import '../../Widget/global_widget/field_header_widget.dart';

class FirstAddService extends StatelessWidget {
  const FirstAddService({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return ListView(
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
          ],
        );
      },
    );
  }
}

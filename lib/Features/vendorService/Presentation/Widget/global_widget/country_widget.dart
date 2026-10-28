import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/vendor_service_cubit.dart';
import 'vendor_form_kit.dart';

class CountryWidget extends StatelessWidget {
  const CountryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VendorFieldLabel(LocaleKeys.vendorCountry.tr()),
            VendorDropdownBox(
              child: DropdownButtonFormField<int>(
                value: vendorServiceCubit.initialCountryID,
                decoration: VendorDropdownBox.decoration,
                borderRadius: BorderRadius.circular(14),
                hint: Text(LocaleKeys.vendorSelectCountry.tr()),
                items: [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('🇪🇬  ${LocaleKeys.vendorCountryEgypt.tr()}'),
                  ),
                ],
                onChanged: (value) {
                  vendorServiceCubit.setCountryID(countryID: value!);
                },
              ),
            ),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }
}

import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Helper/vendor_service_types.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';

class TypeWidget extends StatelessWidget {
  const TypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final vendorTypes = DependencyInjectionHelper().sl<VendorServiceTypes>();
    return ValueListenableBuilder(
      valueListenable: vendorTypes.types,
      builder: (context, _, _) =>
          BlocBuilder<VendorServiceCubit, VendorServiceState>(
            builder: (context, state) {
              var vendorServiceCubit = VendorServiceCubit.get(context);
              // Only the services this vendor runs; switch away from a default
              // type the vendor does not have
              final offered = vendorTypes.current;
              if (!offered.contains(vendorServiceCubit.initialTypeID)) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  vendorServiceCubit.setTypeID(
                    type: offered.reduce((a, b) => a < b ? a : b),
                  );
                });
              }
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      LocaleKeys.vendorServiceType.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.black700,
                        fontFamily: BaseConstant.cairoBold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.natural200),
                      ),
                      child: DropdownButtonFormField<int>(
                        // Was the status value: status "No" (0) matched no item and
                        // crashed the dropdown
                        value: vendorServiceCubit.initialTypeID,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        hint: Text(LocaleKeys.vendorSelectServiceType.tr()),
                        items: [
                          if (offered.contains(1))
                            DropdownMenuItem(
                              value: 1,
                              child: Text(LocaleKeys.vendorTypeRestaurant.tr()),
                            ),
                          if (offered.contains(2))
                            DropdownMenuItem(
                              value: 2,
                              child: Text(LocaleKeys.vendorTypeHotel.tr()),
                            ),
                          if (offered.contains(3))
                            DropdownMenuItem(
                              value: 3,
                              child: Text(LocaleKeys.vendorTypeTrip.tr()),
                            ),
                        ],
                        onChanged: (value) {
                          vendorServiceCubit.setTypeID(type: value!);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}

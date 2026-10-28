import 'package:easy_life/Core/Helper/input_validator.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/vendor_service_cubit.dart';
import '../global_widget/field_header_widget.dart';

/// Price and discount fields, side by side.
class ServiceInfoWidget extends StatelessWidget {
  const ServiceInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FieldHeaderWidget(
                controller: vendorServiceCubit.priceController,
                label: LocaleKeys.vendorPrice.tr(),
                hintText: LocaleKeys.vendorPriceHint.tr(),
                icon: Icons.payments_rounded,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) => InputValidator.validateNotEmpty(value!),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FieldHeaderWidget(
                controller: vendorServiceCubit.discountController,
                label: LocaleKeys.vendorDiscount.tr(),
                hintText: LocaleKeys.vendorDiscountHint.tr(),
                icon: Icons.local_offer_rounded,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) => InputValidator.validateNotEmpty(value!),
              ),
            ),
          ],
        );
      },
    );
  }
}

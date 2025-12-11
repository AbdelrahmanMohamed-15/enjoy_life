import 'package:easy_life/Core/Helper/input_validator.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';

class ServiceInfoWidget extends StatelessWidget {
  const ServiceInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              'السعر',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.black700,
                fontFamily: BaseConstant.cairoBold,
              ),
            ),
            SizedBox(height: 15),
            CustomTextFormField(
              controller: vendorServiceCubit.priceController,
              hintText: 'ادخل السعر',
              textInputType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) => InputValidator.validateNotEmpty(value!),
            ),
            const SizedBox(height: 15),
            Text(
              'الخصم',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.black700,
                fontFamily: BaseConstant.cairoBold,
              ),
            ),
            SizedBox(height: 15),
            CustomTextFormField(
              controller: vendorServiceCubit.discountController,
              hintText: 'ادخل الخصم',
              textInputType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) => InputValidator.validateNotEmpty(value!),
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }
}

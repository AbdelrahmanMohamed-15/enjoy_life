import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';

class CountryWidget extends StatelessWidget {
  const CountryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الدولة',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.black700,
                  fontFamily: BaseConstant.cairoBold,
                ),
              ),
              SizedBox(height: 15),
              // ---------------- STATE DROPDOWN ----------------
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.natural200),
                ),
                child: DropdownButtonFormField<int>(
                  value: vendorServiceCubit.initialCountryID,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  hint: const Text("اختر الدولة"),
                  items: const [DropdownMenuItem(value: 1, child: Text("مصر"))],
                  onChanged: (value) {
                    vendorServiceCubit.setCountryID(countryID: value!);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

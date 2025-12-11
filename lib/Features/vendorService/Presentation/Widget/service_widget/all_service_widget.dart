// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_life/Features/vendorService/Domain/Entities/all_service_entity.dart';
import 'package:flutter/material.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Themes/app_colors.dart';

class AllServiceWidget extends StatefulWidget {
  final VendorServiceCubit vendorServiceCubit;
  const AllServiceWidget({super.key, required this.vendorServiceCubit});

  @override
  State<AllServiceWidget> createState() => _AllServiceWidgetState();
}

class _AllServiceWidgetState extends State<AllServiceWidget> {
  AllServiceData? _getSelectedservice(
    List<AllServiceData>? services,
    int? servID,
  ) {
    if (servID == null || servID == 0 || services == null || services.isEmpty) {
      return null;
    }
    try {
      return services.firstWhere((branch) => branch.id == servID);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          'اختر الخدمة',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.black700,
            fontFamily: BaseConstant.cairoBold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.natural200),
          ),
          child: DropdownButtonFormField<AllServiceData>(
            hint: const Text("اختر الخدمة"),
            value: _getSelectedservice(
              widget.vendorServiceCubit.allServiceEntity?.data,
              widget.vendorServiceCubit.selectedService,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            items: widget.vendorServiceCubit.allServiceEntity?.data
                ?.map(
                  (service) => DropdownMenuItem<AllServiceData>(
                    value: service,
                    child: Text(service.name ?? ''),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null && value.id != null) {
                widget.vendorServiceCubit.setServiceID(svID: value.id!);
                setState(() {});
              }
            },
          ),
        ),
      ],
    );
  }
}

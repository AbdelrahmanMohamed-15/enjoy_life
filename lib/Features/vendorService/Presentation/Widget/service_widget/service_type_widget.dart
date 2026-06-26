// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/Home/Domain/Entity/resturant_entity.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Themes/app_colors.dart';

class ServiceTypeWidget extends StatefulWidget {
  final VendorServiceCubit vendorServiceCubit;
  const ServiceTypeWidget({super.key, required this.vendorServiceCubit});

  @override
  State<ServiceTypeWidget> createState() => _ServiceTypeWidgetState();
}

class _ServiceTypeWidgetState extends State<ServiceTypeWidget> {
  HomeData? _getSelectedService(List<HomeData>? homeData, int? serviceID) {
    if (serviceID == null ||
        serviceID == 0 ||
        homeData == null ||
        homeData.isEmpty) {
      return null;
    }
    try {
      return homeData.firstWhere((branch) => branch.id == serviceID);
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
          LocaleKeys.vendorSelectService.tr(),
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
          child: DropdownButtonFormField<HomeData>(
            hint: Text(LocaleKeys.vendorSelectService.tr()),
            value: widget.vendorServiceCubit.initialTypeID == 1
                ? _getSelectedService(
                    widget.vendorServiceCubit.vendorResturantEntity?.data,
                    widget.vendorServiceCubit.selectedService,
                  )
                : widget.vendorServiceCubit.initialTypeID == 2
                ? _getSelectedService(
                    widget.vendorServiceCubit.vendorHotelsEntity?.data,
                    widget.vendorServiceCubit.selectedService,
                  )
                : _getSelectedService(
                    widget.vendorServiceCubit.vendorTripsEntity?.data,
                    widget.vendorServiceCubit.selectedService,
                  ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            items: widget.vendorServiceCubit.initialTypeID == 1
                ? widget.vendorServiceCubit.vendorResturantEntity?.data
                      ?.map(
                        (home) => DropdownMenuItem<HomeData>(
                          value: home,
                          child: Text(home.name ?? ''),
                        ),
                      )
                      .toList()
                : widget.vendorServiceCubit.initialTypeID == 2
                ? widget.vendorServiceCubit.vendorHotelsEntity?.data
                      ?.map(
                        (home) => DropdownMenuItem<HomeData>(
                          value: home,
                          child: Text(home.name ?? ''),
                        ),
                      )
                      .toList()
                : widget.vendorServiceCubit.vendorTripsEntity?.data
                      ?.map(
                        (home) => DropdownMenuItem<HomeData>(
                          value: home,
                          child: Text(home.name ?? ''),
                        ),
                      )
                      .toList(),
            onChanged: (value) {
              debugPrint('service id Vendor ${value?.id}');
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

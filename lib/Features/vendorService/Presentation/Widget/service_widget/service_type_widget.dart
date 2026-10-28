// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/Home/Domain/Entity/resturant_entity.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../global_widget/vendor_form_kit.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VendorFieldLabel(LocaleKeys.vendorSelectService.tr()),
        VendorDropdownBox(
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
            decoration: VendorDropdownBox.decoration,
            borderRadius: BorderRadius.circular(14),
            isExpanded: true,
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

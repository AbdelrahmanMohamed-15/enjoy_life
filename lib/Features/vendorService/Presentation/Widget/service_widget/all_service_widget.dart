// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_service_entity.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../global_widget/vendor_form_kit.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VendorFieldLabel(LocaleKeys.vendorSelectService.tr()),
        VendorDropdownBox(
          child: DropdownButtonFormField<AllServiceData>(
            hint: Text(LocaleKeys.vendorSelectService.tr()),
            value: _getSelectedservice(
              widget.vendorServiceCubit.allServiceEntity?.data,
              widget.vendorServiceCubit.selectedService,
            ),
            decoration: VendorDropdownBox.decoration,
            borderRadius: BorderRadius.circular(14),
            isExpanded: true,
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

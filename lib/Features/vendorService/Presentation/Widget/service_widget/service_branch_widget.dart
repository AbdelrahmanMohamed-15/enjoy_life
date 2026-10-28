// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../global_widget/vendor_form_kit.dart';

import '../../../Domain/Entities/all_branch_entity.dart';

class ServiceBranchWidget extends StatefulWidget {
  final VendorServiceCubit vendorServiceCubit;
  const ServiceBranchWidget({super.key, required this.vendorServiceCubit});

  @override
  State<ServiceBranchWidget> createState() => _ServiceBranchWidgetState();
}

class _ServiceBranchWidgetState extends State<ServiceBranchWidget> {
  BranchData? _getSelectedBranch(List<BranchData>? branches, int? branchID) {
    if (branchID == null ||
        branchID == 0 ||
        branches == null ||
        branches.isEmpty) {
      return null;
    }
    try {
      return branches.firstWhere((branch) => branch.id == branchID);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VendorFieldLabel(LocaleKeys.vendorSelectBranch.tr()),
        VendorDropdownBox(
          child: DropdownButtonFormField<BranchData>(
            hint: Text(LocaleKeys.vendorSelectBranch.tr()),
            value: _getSelectedBranch(
              widget.vendorServiceCubit.allBranchEntity?.data,
              widget.vendorServiceCubit.branchID,
            ),
            decoration: VendorDropdownBox.decoration,
            borderRadius: BorderRadius.circular(14),
            isExpanded: true,
            items: widget.vendorServiceCubit.allBranchEntity?.data
                ?.map(
                  (branch) => DropdownMenuItem<BranchData>(
                    value: branch,
                    child: Text(
                      branch.getbranchName?.name ?? branch.name ?? '',
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null && value.id != null) {
                widget.vendorServiceCubit.setBranchID(brID: value.id!);
                setState(() {});
              }
            },
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';

import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Themes/app_colors.dart';
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
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          'اختر الفرع',
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
          child: DropdownButtonFormField<BranchData>(
            hint: const Text("اختر الفرع"),
            value: _getSelectedBranch(
              widget.vendorServiceCubit.allBranchEntity?.data,
              widget.vendorServiceCubit.branchID,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
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

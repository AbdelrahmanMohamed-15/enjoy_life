import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/vendorService/Data/Model/resturnat_item_model.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_branch_entity.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/field_header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/vendor_service_cubit.dart';

class ReturantItemWidget extends StatefulWidget {
  final int index;
  const ReturantItemWidget({super.key, required this.index});

  @override
  State<ReturantItemWidget> createState() => _ReturantItemWidgetState();
}

class _ReturantItemWidgetState extends State<ReturantItemWidget> {
  bool _listenersAdded = false;
  ResturnatItemModel? _currentItem;

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _addListeners(ResturnatItemModel item) {
    // Only add listeners once per item
    if (!_listenersAdded || _currentItem != item) {
      // Remove old listeners if item changed
      if (_currentItem != null && _currentItem != item) {
        _removeListeners(_currentItem!);
      }
      item.tableNumber?.addListener(_onTextChanged);
      item.capacity?.addListener(_onTextChanged);
      item.price?.addListener(_onTextChanged);
      item.deposit?.addListener(_onTextChanged);
      _listenersAdded = true;
      _currentItem = item;
    }
  }

  void _removeListeners(ResturnatItemModel item) {
    item.tableNumber?.removeListener(_onTextChanged);
    item.capacity?.removeListener(_onTextChanged);
    item.price?.removeListener(_onTextChanged);
    item.deposit?.removeListener(_onTextChanged);
    _listenersAdded = false;
    _currentItem = null;
  }

  @override
  void dispose() {
    final vendorServiceCubit = VendorServiceCubit.get(context);
    if (widget.index < vendorServiceCubit.tableList.length) {
      final item = vendorServiceCubit.tableList[widget.index];
      _removeListeners(item);
    }
    super.dispose();
  }

  BranchData? _getSelectedBranch(List<BranchData>? branches, int? branchID) {
    if (branchID == null || branches == null || branches.isEmpty) {
      return null;
    }
    try {
      return branches.firstWhere((branch) => branch.id == branchID);
    } catch (e) {
      return null;
    }
  }

  bool _isItemValid(ResturnatItemModel item) {
    return item.branchID != null &&
        item.tableNumber?.text.trim().isNotEmpty == true &&
        item.capacity?.text.trim().isNotEmpty == true &&
        item.price?.text.trim().isNotEmpty == true &&
        item.deposit?.text.trim().isNotEmpty == true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        var list = vendorServiceCubit.tableList;
        if (widget.index >= list.length) {
          return const SizedBox.shrink();
        }
        final item = list[widget.index];
        // Add listeners when widget builds (they will be removed in dispose)
        _addListeners(item);
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.natural200),
                  ),
                  child: DropdownButtonFormField<BranchData>(
                    hint: Text(LocaleKeys.vendorSelectBranch.tr()),
                    value: _getSelectedBranch(
                      vendorServiceCubit.allBranchEntity?.data,
                      item.branchID,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    items: vendorServiceCubit.allBranchEntity?.data
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
                        vendorServiceCubit.updateResturantBranch(
                          widget.index,
                          value.id,
                        );
                        setState(
                          () {},
                        ); // Trigger rebuild to update button state
                      }
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: FieldHeaderWidget(
                        controller: item.tableNumber!,
                        label: LocaleKeys.vendorTableNumber.tr(),
                        keyboardType: TextInputType.number,
                        hintText: LocaleKeys.vendorTableNumber.tr(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FieldHeaderWidget(
                        controller: item.capacity!,
                        keyboardType: TextInputType.number,
                        label: LocaleKeys.vendorCapacity.tr(),
                        hintText: LocaleKeys.vendorCapacity.tr(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: FieldHeaderWidget(
                        controller: item.price!,
                        keyboardType: TextInputType.number,
                        label: LocaleKeys.vendorPrice.tr(),
                        hintText: LocaleKeys.vendorPrice.tr(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FieldHeaderWidget(
                        controller: item.deposit!,
                        keyboardType: TextInputType.number,
                        label: LocaleKeys.vendorDeposit.tr(),
                        hintText: LocaleKeys.vendorDeposit.tr(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    if (widget.index != 0)
                      IconButton(
                        onPressed: () => vendorServiceCubit
                            .removeResturantTable(widget.index),
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.darkRed,
                        ),
                      ),
                    const SizedBox(width: 15),
                    if (list.length - 1 == widget.index)
                      IconButton(
                        onPressed: _isItemValid(item)
                            ? () => vendorServiceCubit.addResturantTable()
                            : null,
                        icon: Icon(
                          Icons.add,
                          color: _isItemValid(item)
                              ? AppColors.primary500
                              : AppColors.natural200,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

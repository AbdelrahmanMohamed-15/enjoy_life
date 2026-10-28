import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/vendorService/Data/Model/hotel_item_model.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_branch_entity.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/field_header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import '../global_widget/vendor_form_kit.dart';
import '../../../../../Core/Constant/base_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/vendor_service_cubit.dart';

class HotelItemWidget extends StatefulWidget {
  final int index;
  const HotelItemWidget({super.key, required this.index});

  @override
  State<HotelItemWidget> createState() => _HotelItemWidgetState();
}

class _HotelItemWidgetState extends State<HotelItemWidget> {
  bool _listenersAdded = false;
  HotelItemModel? _currentItem;

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _addListeners(HotelItemModel item) {
    // Only add listeners once per item
    if (!_listenersAdded || _currentItem != item) {
      // Remove old listeners if item changed
      if (_currentItem != null && _currentItem != item) {
        _removeListeners(_currentItem!);
      }
      item.roomNumber?.addListener(_onTextChanged);
      item.floorNumber?.addListener(_onTextChanged);
      item.capacity?.addListener(_onTextChanged);
      item.price?.addListener(_onTextChanged);
      item.deposit?.addListener(_onTextChanged);
      _listenersAdded = true;
      _currentItem = item;
    }
  }

  void _removeListeners(HotelItemModel item) {
    item.roomNumber?.removeListener(_onTextChanged);
    item.floorNumber?.removeListener(_onTextChanged);
    item.capacity?.removeListener(_onTextChanged);
    item.price?.removeListener(_onTextChanged);
    item.deposit?.removeListener(_onTextChanged);
    _listenersAdded = false;
    _currentItem = null;
  }

  @override
  void dispose() {
    // Looking up the cubit from context is unsafe here, so use the item the
    // listeners were attached to
    if (_currentItem != null) _removeListeners(_currentItem!);
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

  bool _isItemValid(HotelItemModel item) {
    return item.branchID != null &&
        item.roomNumber?.text.trim().isNotEmpty == true &&
        item.floorNumber?.text.trim().isNotEmpty == true &&
        item.capacity?.text.trim().isNotEmpty == true &&
        item.price?.text.trim().isNotEmpty == true &&
        item.deposit?.text.trim().isNotEmpty == true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        var list = vendorServiceCubit.roomList;
        if (widget.index >= list.length) {
          return const SizedBox.shrink();
        }
        final item = list[widget.index];
        // Add listeners when widget builds (they will be removed in dispose)
        _addListeners(item);
        return Card(
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black.withValues(alpha: 0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const BookingTypeIcon(itemType: 'hotel', size: 34),
                    const SizedBox(width: 10),
                    Text(
                      '#${widget.index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: BaseConstant.cairoBold,
                        color: AppColors.black700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                VendorDropdownBox(
                  child: DropdownButtonFormField<BranchData>(
                    hint: Text(LocaleKeys.vendorSelectBranch.tr()),
                    value: _getSelectedBranch(
                      vendorServiceCubit.allBranchEntity?.data,
                      item.branchID,
                    ),
                    decoration: VendorDropdownBox.decoration,
                    isExpanded: true,
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
                        vendorServiceCubit.updateHotelBranch(
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
                        controller: item.roomNumber!,
                        label: LocaleKeys.vendorRoomNumber.tr(),
                        keyboardType: TextInputType.number,
                        hintText: LocaleKeys.vendorRoomNumber.tr(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FieldHeaderWidget(
                        controller: item.floorNumber!,
                        keyboardType: TextInputType.number,
                        label: LocaleKeys.vendorFloorNumber.tr(),
                        hintText: LocaleKeys.vendorFloorNumber.tr(),
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
                FieldHeaderWidget(
                  controller: item.capacity!,
                  keyboardType: TextInputType.number,
                  label: LocaleKeys.vendorCapacity.tr(),
                  hintText: LocaleKeys.vendorCapacity.tr(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    if (widget.index != 0)
                      IconButton(
                        onPressed: () =>
                            vendorServiceCubit.removeHotelTable(widget.index),
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.darkRed,
                        ),
                      ),
                    const SizedBox(width: 15),
                    if (list.length - 1 == widget.index)
                      IconButton(
                        onPressed: _isItemValid(item)
                            ? () => vendorServiceCubit.addHotelRoom()
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

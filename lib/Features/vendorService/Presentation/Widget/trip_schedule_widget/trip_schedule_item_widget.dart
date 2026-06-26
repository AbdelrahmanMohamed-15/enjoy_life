import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/vendorService/Data/Model/trip_schedule_item_model.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_branch_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_trip_schedual_entity.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/field_header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';

class TripScheduleItemWidget extends StatefulWidget {
  final int index;
  const TripScheduleItemWidget({super.key, required this.index});

  @override
  State<TripScheduleItemWidget> createState() => _TripScheduleItemWidgetState();
}

class _TripScheduleItemWidgetState extends State<TripScheduleItemWidget> {
  bool _listenersAdded = false;
  TripScheduleItemModel? _currentItem;

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _addListeners(TripScheduleItemModel item) {
    // Only add listeners once per item
    if (!_listenersAdded || _currentItem != item) {
      // Remove old listeners if item changed
      if (_currentItem != null && _currentItem != item) {
        _removeListeners(_currentItem!);
      }
      item.capacity.addListener(_onTextChanged);
      item.price.addListener(_onTextChanged);
      item.deposit.addListener(_onTextChanged);
      item.startPlace.addListener(_onTextChanged);
      item.endPlace.addListener(_onTextChanged);
      item.startDate.addListener(_onTextChanged);
      item.endDate.addListener(_onTextChanged);
      _listenersAdded = true;
      _currentItem = item;
    }
  }

  void _removeListeners(TripScheduleItemModel item) {
    item.capacity.removeListener(_onTextChanged);
    item.price.removeListener(_onTextChanged);
    item.deposit.removeListener(_onTextChanged);
    item.startPlace.removeListener(_onTextChanged);
    item.endPlace.removeListener(_onTextChanged);
    item.startDate.removeListener(_onTextChanged);
    item.endDate.removeListener(_onTextChanged);
    _listenersAdded = false;
    _currentItem = null;
  }

  @override
  void dispose() {
    final vendorServiceCubit = VendorServiceCubit.get(context);
    if (widget.index < vendorServiceCubit.tripScheduleList.length) {
      final item = vendorServiceCubit.tripScheduleList[widget.index];
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

  TripScheduleData? _getSelectedTripSchedule(
    List<TripScheduleData>? tripSchedules,
    int? tripScheduleID,
  ) {
    if (tripScheduleID == null ||
        tripSchedules == null ||
        tripSchedules.isEmpty) {
      return null;
    }
    try {
      return tripSchedules.firstWhere(
        (schedule) => schedule.id == tripScheduleID,
      );
    } catch (e) {
      return null;
    }
  }

  bool _isItemValid(TripScheduleItemModel item) {
    return item.branchID != null &&
        item.tripScheduleID != null &&
        item.capacity.text.trim().isNotEmpty &&
        item.price.text.trim().isNotEmpty &&
        item.deposit.text.trim().isNotEmpty &&
        item.startPlace.text.trim().isNotEmpty &&
        item.endPlace.text.trim().isNotEmpty &&
        item.startDate.text.trim().isNotEmpty &&
        item.endDate.text.trim().isNotEmpty;
  }

  String _formatDateTime(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) return '';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day $hour:$minute';
  }

  Future<void> _selectDateTime(
    BuildContext context,
    Function(DateTime?, TimeOfDay?) onSelected,
  ) async {
    // First select date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary400,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary400,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // Then select time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primary400,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary400,
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      onSelected(pickedDate, pickedTime);
    }
  }

  Widget _buildDateTimePicker({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required Function(DateTime?, TimeOfDay?) onDateSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.black700,
            fontFamily: BaseConstant.cairoBold,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDateTime(context, onDateSelected),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.natural200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.text.isEmpty
                      ? LocaleKeys.vendorSelectDateTime.tr()
                      : controller.text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: controller.text.isEmpty
                        ? AppColors.natural400
                        : AppColors.black700,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: AppColors.primary400,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        var list = vendorServiceCubit.tripScheduleList;
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                    branch.getbranchName?.name ??
                                        branch.name ??
                                        '',
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null && value.id != null) {
                              vendorServiceCubit.updateTripScheduleBranch(
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
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.natural200),
                        ),
                        child: DropdownButtonFormField<TripScheduleData>(
                          hint: Text(LocaleKeys.vendorSelectTripSchedule.tr()),
                          value: _getSelectedTripSchedule(
                            vendorServiceCubit.allTripSchedualEntity?.data,
                            item.tripScheduleID,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          items: vendorServiceCubit.allTripSchedualEntity?.data
                              ?.map(
                                (
                                  schedule,
                                ) => DropdownMenuItem<TripScheduleData>(
                                  value: schedule,
                                  child: Text(
                                    '${schedule.locationFrom ?? ''} - ${schedule.locationTo ?? ''}',
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null && value.id != null) {
                              vendorServiceCubit.updateTripSchedule(
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
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: FieldHeaderWidget(
                        controller: item.startPlace,
                        label: LocaleKeys.vendorDeparturePlace.tr(),
                        hintText: LocaleKeys.vendorDeparturePlace.tr(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FieldHeaderWidget(
                        controller: item.endPlace,
                        label: LocaleKeys.vendorArrivalPlace.tr(),
                        hintText: LocaleKeys.vendorArrivalPlace.tr(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateTimePicker(
                        context: context,
                        label: LocaleKeys.vendorDepartureDate.tr(),
                        controller: item.startDate,
                        onDateSelected: (date, time) {
                          final formatted = _formatDateTime(date, time);
                          item.startDate.text = formatted;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDateTimePicker(
                        context: context,
                        label: LocaleKeys.vendorArrivalDate.tr(),
                        controller: item.endDate,
                        onDateSelected: (date, time) {
                          final formatted = _formatDateTime(date, time);
                          item.endDate.text = formatted;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: FieldHeaderWidget(
                        controller: item.price,
                        keyboardType: TextInputType.number,
                        label: LocaleKeys.vendorPrice.tr(),
                        hintText: LocaleKeys.vendorPrice.tr(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FieldHeaderWidget(
                        controller: item.deposit,
                        keyboardType: TextInputType.number,
                        label: LocaleKeys.vendorDeposit.tr(),
                        hintText: LocaleKeys.vendorDeposit.tr(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                FieldHeaderWidget(
                  controller: item.capacity,
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
                            vendorServiceCubit.removeTripSchedule(widget.index),
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.darkRed,
                        ),
                      ),
                    const SizedBox(width: 15),
                    if (list.length - 1 == widget.index)
                      IconButton(
                        onPressed: _isItemValid(item)
                            ? () => vendorServiceCubit.addTripSchedule()
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

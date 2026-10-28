import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Widget/custom_snack_bar.dart';
import '../../../Data/Model/hotel_item_model.dart';
import '../../../Data/Model/resturnat_item_model.dart';
import '../../../Data/Model/trip_schedule_item_model.dart';
import '../../cubit/vendor_service_cubit.dart';
import 'vendor_form_kit.dart';

class ScrollWidget extends StatelessWidget {
  final String type;
  final bool isEdit;
  final int? id;
  const ScrollWidget({
    super.key,
    required this.type,
    required this.isEdit,
    this.id,
  });

  void _goTo(VendorServiceCubit cubit, {required bool next}) {
    final page = next ? cubit.currentPage + 1 : cubit.currentPage - 1;
    cubit.pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _error(String message) {
    showCustomSnackBar(message, backgroundColor: AppColors.darkRed);
  }

  /// Validates the current page, then moves on or submits on the last page.
  void _onNext(VendorServiceCubit cubit) {
    switch (cubit.currentPage) {
      case 0:
        if (!cubit.validateBilingual() || !cubit.validateContact()) return;
        _goTo(cubit, next: true);
      case 1:
        if (cubit.logoImage == null) {
          return _error(LocaleKeys.vendorValidationLogoRequired.tr());
        }
        if (cubit.imageFiles.isEmpty) {
          return _error(LocaleKeys.vendorValidationBranchImageRequired.tr());
        }
        _goTo(cubit, next: true);
      default:
        // Every row is sent, so every row must be complete
        if (type == 'resturant') {
          if (cubit.tableList.isEmpty ||
              !cubit.tableList.every(_isResturantItemValid)) {
            return _error(LocaleKeys.vendorValidationTablesRequired.tr());
          }
          cubit.createResturant(isEdit: isEdit, id: id);
        } else if (type == 'hotel') {
          if (cubit.roomList.isEmpty ||
              !cubit.roomList.every(_isHotelItemValid)) {
            return _error(LocaleKeys.vendorValidationRoomsRequired.tr());
          }
          cubit.createHotel(isEdit: isEdit, id: id);
        } else {
          if (cubit.tripScheduleList.isEmpty ||
              !cubit.tripScheduleList.every(_isTripItemValid)) {
            return _error(LocaleKeys.vendorValidationTripScheduleRequired.tr());
          }
          cubit.createTrip(isEdit: isEdit, id: id);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var cubit = VendorServiceCubit.get(context);
        final isLast = cubit.currentPage == 2;
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                if (cubit.currentPage != 0) ...[
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton.icon(
                        onPressed: () => _goTo(cubit, next: false),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.arrow_back_rounded, size: 18),
                        label: Text(
                          LocaleKeys.commonPrevious.tr(),
                          style: const TextStyle(
                            fontFamily: BaseConstant.cairoBold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  flex: 2,
                  child: VendorGradientButton(
                    label: isLast
                        ? (isEdit
                              ? LocaleKeys.commonEdit.tr()
                              : LocaleKeys.commonAdd.tr())
                        : LocaleKeys.commonNext.tr(),
                    icon: isLast
                        ? Icons.check_circle_rounded
                        : Icons.arrow_forward_rounded,
                    onTap: () => _onNext(cubit),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isTripItemValid(TripScheduleItemModel item) {
    return item.tripScheduleID != null &&
        item.branchID != null &&
        item.capacity.text.trim().isNotEmpty &&
        item.price.text.trim().isNotEmpty &&
        item.deposit.text.trim().isNotEmpty &&
        item.startPlace.text.trim().isNotEmpty &&
        item.endPlace.text.trim().isNotEmpty &&
        item.startDate.text.trim().isNotEmpty &&
        item.endDate.text.trim().isNotEmpty;
  }

  bool _isResturantItemValid(ResturnatItemModel item) {
    return item.branchID != null &&
        item.tableNumber?.text.trim().isNotEmpty == true &&
        item.capacity?.text.trim().isNotEmpty == true &&
        item.price?.text.trim().isNotEmpty == true &&
        item.deposit?.text.trim().isNotEmpty == true;
  }

  bool _isHotelItemValid(HotelItemModel item) {
    return item.branchID != null &&
        item.roomNumber?.text.trim().isNotEmpty == true &&
        item.floorNumber?.text.trim().isNotEmpty == true &&
        item.capacity?.text.trim().isNotEmpty == true &&
        item.price?.text.trim().isNotEmpty == true &&
        item.deposit?.text.trim().isNotEmpty == true;
  }
}

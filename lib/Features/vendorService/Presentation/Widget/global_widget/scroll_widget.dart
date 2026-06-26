import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Widget/custom_snack_bar.dart';
import '../../../Data/Model/hotel_item_model.dart';
import '../../../Data/Model/resturnat_item_model.dart';
import '../../../Data/Model/trip_schedule_item_model.dart';
import '../../cubit/vendor_service_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.sizeOf(context);
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: AppColors.natural100,
          child: Row(
            children: [
              if (vendorServiceCubit.currentPage != 0)
                MainAppButton(
                  width: size.width * 0.25,
                  height: 40,
                  onTap: () {
                    vendorServiceCubit.pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(
                    LocaleKeys.commonPrevious.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.natural100,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                ),
              if (vendorServiceCubit.currentPage == 0) const Spacer(),
              const Spacer(),
              if (vendorServiceCubit.currentPage != 2)
                MainAppButton(
                  width: size.width * 0.25,
                  height: 40,
                  onTap: () {
                    if (vendorServiceCubit.currentPage == 0) {
                      if (vendorServiceCubit.nameArController.text.isEmpty ||
                          vendorServiceCubit.nameEnController.text.isEmpty) {
                        showCustomSnackBar(
                          LocaleKeys.vendorValidationNameBoth.tr(),
                          backgroundColor: AppColors.darkRed,
                        );
                        return;
                      }
                      if (vendorServiceCubit.addressArController.text.isEmpty) {
                        showCustomSnackBar(
                          LocaleKeys.vendorValidationAddressAr.tr(),
                          backgroundColor: AppColors.darkRed,
                        );
                        return;
                      }
                      if (vendorServiceCubit.phoneController.text.isEmpty) {
                        showCustomSnackBar(
                          LocaleKeys.vendorValidationPhone.tr(),
                          backgroundColor: AppColors.darkRed,
                        );
                        return;
                      }
                      if (vendorServiceCubit.initialLatitude == null ||
                          vendorServiceCubit.initialLongitude == null) {
                        showCustomSnackBar(
                          LocaleKeys.vendorValidationLocationRequired.tr(),
                          backgroundColor: AppColors.darkRed,
                        );
                        return;
                      }
                      vendorServiceCubit.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else if (vendorServiceCubit.currentPage == 1) {
                      if (vendorServiceCubit.logoImage == null) {
                        showCustomSnackBar(
                          LocaleKeys.vendorValidationLogoRequired.tr(),
                          backgroundColor: AppColors.darkRed,
                        );
                        return;
                      }
                      if (vendorServiceCubit.imageFiles.isEmpty) {
                        showCustomSnackBar(
                          LocaleKeys.vendorValidationBranchImageRequired.tr(),
                          backgroundColor: AppColors.darkRed,
                        );
                        return;
                      }
                      vendorServiceCubit.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      vendorServiceCubit.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    LocaleKeys.commonNext.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.natural100,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                ),
              if (vendorServiceCubit.currentPage == 2)
                MainAppButton(
                  width: size.width * 0.25,
                  height: 40,
                  onTap: () {
                    if (type == 'resturant') {
                      if (!_isResturantItemValid(
                        vendorServiceCubit.tableList.first,
                      )) {
                        showCustomSnackBar(
                          LocaleKeys.vendorValidationTablesRequired.tr(),
                          backgroundColor: AppColors.darkRed,
                        );
                        return;
                      } else {
                        vendorServiceCubit.createResturant(
                          isEdit: isEdit,
                          id: id,
                        );
                      }
                    } else if (type == 'hotel') {
                      if (!_isHotelItemValid(
                        vendorServiceCubit.roomList.first,
                      )) {
                        showCustomSnackBar(
                          LocaleKeys.vendorValidationRoomsRequired.tr(),
                          backgroundColor: AppColors.darkRed,
                        );
                        return;
                      } else {
                        vendorServiceCubit.createHotel(isEdit: isEdit, id: id);
                      }
                    } else {
                      if (vendorServiceCubit.tripScheduleList.isEmpty) {
                        showCustomSnackBar(
                          LocaleKeys.vendorValidationTripScheduleRequired.tr(),
                          backgroundColor: AppColors.darkRed,
                        );
                        return;
                      } else {
                        if (!_isTripItemValid(
                          vendorServiceCubit.tripScheduleList.first,
                        )) {
                          showCustomSnackBar(
                            LocaleKeys.vendorValidationTripScheduleRequired.tr(),
                            backgroundColor: AppColors.darkRed,
                          );
                          return;
                        }
                        vendorServiceCubit.createTrip(isEdit: isEdit, id: id);
                      }
                    }
                  },
                  child: Text(
                    isEdit == false
                        ? LocaleKeys.commonAdd.tr()
                        : LocaleKeys.commonEdit.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.natural100,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  bool _isTripItemValid(TripScheduleItemModel item) {
    return item.tripScheduleID != null &&
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

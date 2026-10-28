import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'picked_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';
import 'pick_vendor_bottom_sheet.dart';
import 'upload_tile.dart';

class ServiceImageWidget extends StatelessWidget {
  final bool isEdit;
  const ServiceImageWidget({super.key, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.vendorImages.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.black700,
                  fontFamily: BaseConstant.cairoBold,
                ),
              ),
              SizedBox(height: 15),

              if (vendorServiceCubit.imageFiles.isEmpty)
                GestureDetector(
                  onTap: () {
                    pickuVendorpBottomSheet(
                      vendorServiceCubit: vendorServiceCubit,
                      type: 'image',
                    );
                  },
                  child: UploadTile(),
                ),
              if (vendorServiceCubit.imageFiles.isNotEmpty)
                GridView.builder(
                  key: ValueKey(vendorServiceCubit.imageFiles.length),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount:
                      vendorServiceCubit.imageFiles.length <
                          vendorServiceCubit.maxImages
                      ? vendorServiceCubit.imageFiles.length + 1
                      : vendorServiceCubit.imageFiles.length,
                  itemBuilder: (context, index) {
                    if (index < vendorServiceCubit.imageFiles.length) {
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.natural200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: pickedImage(
                                vendorServiceCubit.imageFiles[index],
                                fit: BoxFit.fill,
                                height: 200,
                                width: 200,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                vendorServiceCubit.removeImage(index);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.darkRed,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          pickuVendorpBottomSheet(
                            vendorServiceCubit: vendorServiceCubit,
                            type: 'image',
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.natural50,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primary500,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate,
                                color: AppColors.primary500,
                                size: 30,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                LocaleKeys.commonAdd.tr(),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.primary500,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

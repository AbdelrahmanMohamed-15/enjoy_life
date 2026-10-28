import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';
import 'pick_vendor_bottom_sheet.dart';
import 'upload_tile.dart';
import 'vendor_form_kit.dart';

class ServiceImageWidget extends StatelessWidget {
  final bool isEdit;
  const ServiceImageWidget({super.key, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var cubit = VendorServiceCubit.get(context);
        void pick() =>
            pickuVendorpBottomSheet(vendorServiceCubit: cubit, type: 'image');
        final files = cubit.imageFiles;
        final canAdd = files.length < cubit.maxImages;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: VendorFieldLabel(LocaleKeys.vendorImages.tr())),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    '${files.length}/${cubit.maxImages}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: BaseConstant.cairoBold,
                      color: AppColors.natural500,
                    ),
                  ),
                ),
              ],
            ),
            if (files.isEmpty)
              GestureDetector(onTap: pick, child: const UploadTile())
            else
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: canAdd ? files.length + 1 : files.length,
                itemBuilder: (context, index) {
                  if (index == files.length) {
                    return GestureDetector(
                      onTap: pick,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary100.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primary300.withValues(alpha: 0.7),
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_photo_alternate_rounded,
                              color: AppColors.primary500,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              LocaleKeys.commonAdd.tr(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: BaseConstant.cairoBold,
                                color: AppColors.primary600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: VendorPickedImage(file: files[index]),
                      ),
                      PositionedDirectional(
                        top: 6,
                        end: 6,
                        child: GestureDetector(
                          onTap: () => cubit.removeImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.55),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}

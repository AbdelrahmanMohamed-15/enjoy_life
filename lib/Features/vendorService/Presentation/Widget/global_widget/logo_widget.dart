import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/upload_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'picked_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';
import 'pick_vendor_bottom_sheet.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

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
                LocaleKeys.vendorLogo.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.black700,
                  fontFamily: BaseConstant.cairoBold,
                ),
              ),
              SizedBox(height: 15),

              vendorServiceCubit.logoImage == null
                  ? GestureDetector(
                      onTap: () {
                        pickuVendorpBottomSheet(
                          vendorServiceCubit: vendorServiceCubit,
                          type: 'logo',
                        );
                      },
                      child: UploadTile(),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: pickedImage(
                        vendorServiceCubit.logoImage!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

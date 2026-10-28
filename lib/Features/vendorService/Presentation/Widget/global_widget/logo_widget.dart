import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Features/vendorService/Presentation/Widget/global_widget/upload_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';
import 'pick_vendor_bottom_sheet.dart';
import 'vendor_form_kit.dart';

class LogoWidget extends StatelessWidget {
  /// Label shown above the picker (defaults to "Logo")
  final String? label;
  const LogoWidget({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        void pick() => pickuVendorpBottomSheet(
          vendorServiceCubit: vendorServiceCubit,
          type: 'logo',
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VendorFieldLabel(label ?? LocaleKeys.vendorLogo.tr()),
            vendorServiceCubit.logoImage == null
                ? GestureDetector(onTap: pick, child: const UploadTile())
                : Row(
                    children: [
                      Container(
                        height: 92,
                        width: 92,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.natural200),
                        ),
                        child: VendorPickedImage(
                          file: vendorServiceCubit.logoImage!,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ImageAction(
                              icon: Icons.edit_rounded,
                              label: LocaleKeys.vendorChange.tr(),
                              color: AppColors.primary600,
                              onTap: pick,
                            ),
                            const SizedBox(height: 8),
                            _ImageAction(
                              icon: Icons.delete_outline_rounded,
                              label: LocaleKeys.vendorRemove.tr(),
                              color: AppColors.errorColor,
                              onTap: vendorServiceCubit.removeLogo,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}

class _ImageAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ImageAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: BaseConstant.cairoBold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

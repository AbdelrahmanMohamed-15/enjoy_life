import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';
import 'vendor_form_kit.dart';

/// Active / inactive switch (sent to the API as status 1 / 0).
class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<VendorServiceCubit, VendorServiceState>(
      builder: (context, state) {
        var vendorServiceCubit = VendorServiceCubit.get(context);
        final isActive = vendorServiceCubit.initialStatusID == 1;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VendorFieldLabel(LocaleKeys.vendorStatus.tr()),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF2EAD5B).withValues(alpha: 0.08)
                    : AppColors.natural50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isActive
                      ? const Color(0xFF2EAD5B).withValues(alpha: 0.4)
                      : AppColors.natural200,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isActive
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: isActive
                        ? const Color(0xFF2EAD5B)
                        : AppColors.natural500,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.vendorStatusActive.tr(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontFamily: BaseConstant.cairoBold,
                            color: AppColors.black700,
                          ),
                        ),
                        Text(
                          isActive
                              ? LocaleKeys.vendorStatusActiveHint.tr()
                              : LocaleKeys.vendorStatusInactiveHint.tr(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.natural500,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: isActive,
                    activeTrackColor: const Color(0xFF2EAD5B),
                    onChanged: (value) =>
                        vendorServiceCubit.setStatusID(statusID: value ? 1 : 0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

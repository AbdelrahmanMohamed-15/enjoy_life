import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Helper/vendor_service_types.dart';
import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/Extentions/center_ext.dart';
import 'package:easy_life/Core/Extentions/padding_ext.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Reversion/Presentation/cubit/reversion_cubit.dart';
import 'package:flutter/material.dart';

class ReversionService extends StatelessWidget {
  final int serviceID;
  final ReversionCubit reversionCubit;
  const ReversionService({
    super.key,
    required this.serviceID,
    required this.reversionCubit,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final vendorTypes = DependencyInjectionHelper().sl<VendorServiceTypes>()
      ..loadOnce();
    final labels = {
      1: LocaleKeys.reversionFilterRestaurant.tr(),
      2: LocaleKeys.reversionFilterHotel.tr(),
      3: LocaleKeys.reversionFilterTrip.tr(),
    };
    return ValueListenableBuilder(
      valueListenable: vendorTypes.types,
      builder: (context, _, _) {
        // Only the services this vendor runs; leave a tab it does not have
        final offered = labels.keys
            .where(vendorTypes.current.contains)
            .toList();
        if (offered.isNotEmpty && !offered.contains(serviceID)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            reversionCubit.setReversionStatus(servID: offered.first);
          });
        }
        return Row(
          children: [
            for (var i = 0; i < offered.length; i++) ...[
              if (i > 0) const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    reversionCubit.setReversionStatus(servID: offered[i]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: serviceID == offered[i]
                          ? AppColors.primary500
                          : AppColors.natural200,
                    ),
                    child: Text(
                      labels[offered[i]]!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: BaseConstant.cairoBold,
                        color: serviceID == offered[i]
                            ? AppColors.natural100
                            : AppColors.natural500,
                      ),
                    ).setCenter(),
                  ),
                ),
              ),
            ],
          ],
        ).setHorizontalPadding(context, 15, enableMediaQuery: false);
      },
    );
  }
}

import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';
import 'package:easy_life/Core/Helper/vendor_service_types.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/booking_type_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../cubit/vendor_service_cubit.dart';
import 'vendor_form_kit.dart';

/// Restaurant / hotel / trip picker (service_id 1 / 2 / 3).
class TypeWidget extends StatelessWidget {
  const TypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final types = [
      (1, 'restaurant', LocaleKeys.vendorTypeRestaurant.tr()),
      (2, 'hotel', LocaleKeys.vendorTypeHotel.tr()),
      (3, 'trip', LocaleKeys.vendorTypeTrip.tr()),
    ];
    final vendorTypes = DependencyInjectionHelper().sl<VendorServiceTypes>();
    return ValueListenableBuilder(
      valueListenable: vendorTypes.types,
      builder: (context, _, _) =>
          BlocBuilder<VendorServiceCubit, VendorServiceState>(
            builder: (context, state) {
              var vendorServiceCubit = VendorServiceCubit.get(context);
              final offered = types
                  .where((t) => vendorTypes.current.contains(t.$1))
                  .toList();
              // e.g. a hotel-only vendor: switch away from the default restaurant
              if (offered.isNotEmpty &&
                  !offered.any(
                    (t) => t.$1 == vendorServiceCubit.initialTypeID,
                  )) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  vendorServiceCubit.setTypeID(type: offered.first.$1);
                });
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VendorFieldLabel(LocaleKeys.vendorServiceType.tr()),
                  Row(
                    children: [
                      for (var i = 0; i < offered.length; i++) ...[
                        if (i > 0) const SizedBox(width: 8),
                        Expanded(
                          child: _TypeChip(
                            itemType: offered[i].$2,
                            label: offered[i].$3,
                            isSelected:
                                vendorServiceCubit.initialTypeID ==
                                offered[i].$1,
                            onTap: () {
                              if (vendorServiceCubit.initialTypeID !=
                                  offered[i].$1) {
                                vendorServiceCubit.setTypeID(
                                  type: offered[i].$1,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              );
            },
          ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String itemType;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _TypeChip({
    required this.itemType,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary100.withValues(alpha: 0.5)
              : AppColors.natural50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary500 : AppColors.natural200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            BookingTypeIcon(itemType: itemType, size: 40),
            const SizedBox(height: 8),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontFamily: BaseConstant.cairoBold,
                color: isSelected ? AppColors.primary700 : AppColors.natural600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

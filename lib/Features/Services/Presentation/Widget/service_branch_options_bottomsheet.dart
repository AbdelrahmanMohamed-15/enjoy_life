import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Core/Widget/main_app_button.dart';
import 'package:easy_life/Features/Services/Domain/Entity/service_deatils_entity.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:flutter/material.dart';

class ServiceBranchOptionsBottomSheet extends StatefulWidget {
  final ServiceBranch serviceBranch;
  final int branchID;
  final ServiceCubit serviceCubit;
  final String serviceName;

  const ServiceBranchOptionsBottomSheet({
    super.key,
    required this.serviceBranch,
    required this.branchID,
    required this.serviceCubit,
    required this.serviceName,
  });

  @override
  State<ServiceBranchOptionsBottomSheet> createState() =>
      _ServiceBranchOptionsBottomSheetState();
}

class _ServiceBranchOptionsBottomSheetState
    extends State<ServiceBranchOptionsBottomSheet> {
  ServiceBranchOption? selectedOption;

  @override
  void initState() {
    super.initState();
    // No default selection - options are optional
  }

  String _servicePrice() {
    final price = double.tryParse(widget.serviceBranch.price ?? '') ?? 0;
    final discount = double.tryParse(widget.serviceBranch.discount ?? '') ?? 0;
    final value = discount > 0 && discount < price ? price - discount : price;
    return value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(2);
  }

  /// The discount is an amount off the price (as in order totals)
  int getOptionPrice(ServiceBranchOption option) {
    final price = option.price ?? 0;
    final discount = option.discount ?? 0;
    return discount > 0 && discount < price ? price - discount : price;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final options = widget.serviceBranch.serviceBranchOptions ?? [];

    // Follows the app language (it was forced right-to-left in English)
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.natural300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.serviceName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.black700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Price
                    Text(
                      '${_servicePrice()} ${LocaleKeys.commonCurrencyEgp.tr()}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.primary400,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Options title
                    Text(
                      LocaleKeys.servicesOptionSelect.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.black700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Options list
                    ...options.map((option) {
                      final isSelected = selectedOption?.id == option.id;
                      final optionPrice = getOptionPrice(option);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // Toggle selection - if already selected, deselect it
                            if (selectedOption?.id == option.id) {
                              selectedOption = null;
                            } else {
                              selectedOption = option;
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary400
                                  : AppColors.natural200,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: isSelected
                                ? AppColors.primary100.withOpacity(0.3)
                                : Colors.white,
                          ),
                          child: Row(
                            children: [
                              // Radio button
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary400
                                        : AppColors.natural400,
                                    width: 2,
                                  ),
                                  color: isSelected
                                      ? AppColors.primary400
                                      : Colors.transparent,
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              // Option name
                              Expanded(
                                child: Text(
                                  option.name ?? '',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.black700,
                                  ),
                                ),
                              ),
                              // Option price
                              Text(
                                '${optionPrice.toString()} ${LocaleKeys.commonCurrencyEgp.tr()}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primary400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Add to cart button (fixed at bottom)
            Padding(
              padding: const EdgeInsets.all(20),
              child: MainAppButton(
                bgColor: AppColors.primary400,
                child: Text(
                  LocaleKeys.servicesOptionAdd.tr(),
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                onTap: () async {
                  // Close bottom sheet
                  Navigator.of(context).pop();

                  // First call: Add service to cart
                  final serviceAdded = await widget.serviceCubit.addToCart(
                    type: 'service',
                    id: widget.serviceBranch.id,
                    branchID: widget.branchID,
                    showLoading: true,
                    showMessage: true,
                  );

                  // Second call: Add option to cart if selected and service was added successfully
                  if (serviceAdded &&
                      selectedOption != null &&
                      selectedOption!.id != null) {
                    await widget.serviceCubit.addToCart(
                      type: 'service_option',
                      branchID: widget.branchID,
                      optionID: selectedOption!.id,
                      showLoading: true,
                      showMessage: true,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

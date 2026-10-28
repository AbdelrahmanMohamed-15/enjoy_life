import 'package:easy_life/Core/Constant/base_constant.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Themes/app_colors.dart';
import 'package:easy_life/Core/Widget/app_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_life/Features/Services/Domain/Entity/service_deatils_entity.dart';
import 'package:easy_life/Features/Services/Presentation/cubit/service_cubit.dart';
import 'package:flutter/material.dart';

/// Lets the customer add a service with one optional extra option.
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

  /// The discount is an amount off the price (as in order totals)
  num _optionPrice(ServiceBranchOption option) {
    final price = option.price ?? 0;
    final discount = option.discount ?? 0;
    return discount > 0 && discount < price ? price - discount : price;
  }

  String get _servicePrice {
    final price = double.tryParse(widget.serviceBranch.price ?? '') ?? 0;
    final discount = double.tryParse(widget.serviceBranch.discount ?? '') ?? 0;
    final value = discount > 0 && discount < price ? price - discount : price;
    return value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(2);
  }

  Future<void> _addToCart() async {
    final option = selectedOption;
    Navigator.of(context).pop();
    final serviceAdded = await widget.serviceCubit.addToCart(
      type: 'service',
      id: widget.serviceBranch.id,
      branchID: widget.branchID,
    );
    if (serviceAdded && option?.id != null) {
      await widget.serviceCubit.addToCart(
        type: 'service_option',
        branchID: widget.branchID,
        optionID: option!.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final options = widget.serviceBranch.serviceBranchOptions ?? [];
    final currency = LocaleKeys.commonCurrencyEgp.tr();
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 12, bottom: 8),
              child: SheetHandle(),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Text(
                    widget.serviceName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: AppColors.black700,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                  Text(
                    '$_servicePrice $currency',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: BaseConstant.cairoBold,
                      color: AppColors.primary500,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    LocaleKeys.servicesOptionSelect.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.natural600,
                      fontFamily: BaseConstant.cairoBold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (final option in options)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _OptionTile(
                        name: option.name ?? '',
                        price: '+${_optionPrice(option)} $currency',
                        selected: selectedOption?.id == option.id,
                        // Tapping the selected option clears it (optional)
                        onTap: () => setState(
                          () => selectedOption = selectedOption?.id == option.id
                              ? null
                              : option,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: AppGradientButton(
                label: LocaleKeys.servicesOptionAdd.tr(),
                icon: Icons.add_shopping_cart_rounded,
                onTap: _addToCart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String name;
  final String price;
  final bool selected;
  final VoidCallback onTap;
  const _OptionTile({
    required this.name,
    required this.price,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary100.withValues(alpha: 0.35)
          : AppColors.natural50,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.primary500 : AppColors.natural200,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: selected ? AppColors.primary500 : AppColors.natural400,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontFamily: BaseConstant.cairoBold,
                    color: AppColors.black700,
                  ),
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontFamily: BaseConstant.cairoBold,
                  color: AppColors.primary600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

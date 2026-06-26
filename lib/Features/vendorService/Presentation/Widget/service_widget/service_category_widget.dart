// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_category_entity.dart';
import 'package:easy_life/Features/vendorService/Presentation/cubit/vendor_service_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Themes/app_colors.dart';

class ServiceCategoryWidget extends StatefulWidget {
  final VendorServiceCubit vendorServiceCubit;
  const ServiceCategoryWidget({super.key, required this.vendorServiceCubit});

  @override
  State<ServiceCategoryWidget> createState() => _ServiceCategoryWidgetState();
}

class _ServiceCategoryWidgetState extends State<ServiceCategoryWidget> {
  CategoryData? _getSelectedCategory(
    List<CategoryData>? categories,
    int? categoryID,
  ) {
    if (categoryID == null ||
        categoryID == 0 ||
        categories == null ||
        categories.isEmpty) {
      return null;
    }
    try {
      return categories.firstWhere((category) => category.id == categoryID);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          LocaleKeys.vendorSelectCategory.tr(),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.black700,
            fontFamily: BaseConstant.cairoBold,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.natural200),
          ),
          child: DropdownButtonFormField<CategoryData>(
            hint: Text(LocaleKeys.vendorSelectCategory.tr()),
            value: _getSelectedCategory(
              widget.vendorServiceCubit.allCategoryEntity?.data,
              widget.vendorServiceCubit.catID,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            items: widget.vendorServiceCubit.allCategoryEntity?.data
                ?.map(
                  (category) => DropdownMenuItem<CategoryData>(
                    value: category,
                    child: Text(category.name ?? ''),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null && value.id != null) {
                widget.vendorServiceCubit.setCategoryID(categoryID: value.id!);
                setState(() {});
              }
            },
          ),
        ),
      ],
    );
  }
}

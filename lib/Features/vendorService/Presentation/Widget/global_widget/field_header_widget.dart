import 'package:flutter/material.dart';

import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Themes/app_colors.dart';
import '../../../../../Core/Widget/custom_text_form_field.dart';

class FieldHeaderWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? keyboardType;
  const FieldHeaderWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.validator,
    this.maxLines,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.black700,
            fontFamily: BaseConstant.cairoBold,
          ),
        ),
        SizedBox(height: 15),
        CustomTextFormField(
          controller: controller,
          hintText: hintText,
          validator: validator,
          maxLines: maxLines,
          textInputType: keyboardType,
        ),
        SizedBox(height: 15),
      ],
    );
  }
}

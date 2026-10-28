import 'package:flutter/material.dart';

import '../../../../../Core/Widget/custom_text_form_field.dart';
import '../../../../../Core/Themes/app_colors.dart';
import 'vendor_form_kit.dart';

class FieldHeaderWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? keyboardType;
  final IconData? icon;
  const FieldHeaderWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.validator,
    this.maxLines,
    this.keyboardType,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VendorFieldLabel(label),
        CustomTextFormField(
          controller: controller,
          hintText: hintText,
          validator: validator,
          maxLines: maxLines,
          textInputType: keyboardType,
          prefixIcon: icon == null
              ? null
              : Icon(icon, size: 20, color: AppColors.primary400),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

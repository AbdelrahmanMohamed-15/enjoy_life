import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Routes/app_navigation.dart';
import '../Themes/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.maxLines,
    this.fillColor,
    this.textInputType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.style,
    this.focusNode,
    this.enabledBorder,
    this.textColor,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final Function()? onTap;
  final bool readOnly;
  final int? maxLines;
  final Color? fillColor;
  final OutlineInputBorder? enabledBorder;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final FocusNode? focusNode;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return //Directionality(textDirection: TextDirection.ltr,
    TextFormField(
      focusNode: focusNode,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      textInputAction: textInputAction ?? TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      cursorOpacityAnimates: true,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: obscureText,
      style:
          style ??
          Theme.of(
            AppNavigation.navigatorKey.currentContext!,
          ).textTheme.titleMedium!.copyWith(
            fontSize: 13.r,
            fontWeight: FontWeight.w300,
            color: textColor ?? AppColors.black700,
          ),
      keyboardType: textInputType ?? TextInputType.name,
      decoration: InputDecoration(
        // constraints: BoxConstraints(maxHeight: 50, minHeight: 50),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: AppColors.grayDark.withOpacity(0.2),
                width: 2.5.r / 2,
              ),
            ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.primary400, width: 2.5.r / 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: AppColors.grayDark.withOpacity(0.2),
            width: 2.5.r / 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.darkRed, width: 2.5.r / 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        fillColor: fillColor ?? AppColors.natural100,
        filled: true,
        hintStyle: Theme.of(AppNavigation.navigatorKey.currentContext!)
            .textTheme
            .titleMedium!
            .copyWith(
              fontSize: 14.r,
              fontWeight: FontWeight.w400,
              color: AppColors.natural300,
            ),
        labelStyle: Theme.of(AppNavigation.navigatorKey.currentContext!)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: 13.r, color: AppColors.primary400),

        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines ?? 1,
      //  ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_life/Core/Extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Themes/app_colors.dart';

class MainAppButton extends StatelessWidget {
  final Color? bgColor;
  final Color? borderColor;
  final double? vertical;
  final double? horizontal;
  final Widget child;
  final Function()? onTap;
  final double? width;
  final double? height;
  const MainAppButton({
    super.key,
    this.bgColor,
    this.vertical,
    this.horizontal,
    this.onTap,
    required this.child,
    this.height,
    this.width,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          Container(
            width: width ?? 343.w, // ,
            height: height ?? 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bgColor ?? AppColors.primary500,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: borderColor ?? AppColors.primary500,
                width: 0.5,
              ),
            ),
            child: child,
          ).setHorizontalAndVerticalPadding(
            context,
            vertical ?? 0.0,
            horizontal ?? 0.0,
          ),
    );
  }
}

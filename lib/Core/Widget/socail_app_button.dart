// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Themes/app_colors.dart';

class SocailAppButton extends StatelessWidget {
  final double? vertical;
  final double? horizontal;
  final FaIcon socialIcon;
  final String socialText;
  final Function()? onTap;
  final double? width;
  final double? height;
  const SocailAppButton({
    super.key,
    this.vertical,
    this.horizontal,
    this.onTap,
    required this.socialIcon,
    required this.socialText,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 343.w, // ,
        height: height ?? 55.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.natural200,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
            BoxShadow(
              color: AppColors.natural200,
              blurRadius: 7,
              offset: const Offset(0, -3), // changes position of shadow
            ),
          ],
        ),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(child: socialIcon),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                text: socialText,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: AppColors.black700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

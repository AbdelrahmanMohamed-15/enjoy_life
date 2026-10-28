import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../Core/Constant/assets_strings.dart';
import '../../../../../Core/Constant/base_constant.dart';
import '../../../../../Core/Widget/app_ui.dart';
import '../../../../../Core/Themes/app_colors.dart';

/// Shared building blocks for the vendor "add" forms, so every screen
/// (category, branch, restaurant/hotel/trip, service, option) looks the same.

class VendorAppBar extends AppPageBar {
  const VendorAppBar({super.key, required super.title, super.onBack});
}

/// White rounded card with an icon + title header.
class VendorSectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget child;
  const VendorSectionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary100.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, size: 19, color: AppColors.primary600),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: BaseConstant.cairoBold,
                        color: AppColors.black700,
                        fontSize: 15,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.natural500,
                          fontSize: 11,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class VendorFieldLabel extends StatelessWidget {
  final String text;
  const VendorFieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.natural600,
          fontFamily: BaseConstant.cairoBold,
          fontSize: 13,
        ),
      ),
    );
  }
}

/// Bordered box that hosts a borderless DropdownButtonFormField.
class VendorDropdownBox extends StatelessWidget {
  final Widget child;
  const VendorDropdownBox({super.key, required this.child});

  /// Decoration for the dropdown inside [VendorDropdownBox]
  static const InputDecoration decoration = InputDecoration(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 14),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.natural50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.natural200),
      ),
      child: child,
    );
  }
}

/// Full-width gradient call-to-action pinned at the bottom of a form.
class VendorSubmitButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const VendorSubmitButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon = Icons.check_circle_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: VendorGradientButton(label: label, icon: icon, onTap: onTap),
      ),
    );
  }
}

class VendorGradientButton extends AppGradientButton {
  const VendorGradientButton({
    super.key,
    required super.label,
    required super.onTap,
    super.icon,
  });
}

/// Shows a picked image. In edit mode the cubit stores the server URL in a
/// `File`, so URLs are loaded from the network instead of the disk.
class VendorPickedImage extends StatelessWidget {
  final File file;
  final double? height;
  final double? width;
  const VendorPickedImage({
    super.key,
    required this.file,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    Widget error(BuildContext context, Object error, StackTrace? stackTrace) {
      return SvgPicture.asset(
        AssetsStrings.noImages,
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
    }

    final path = file.path;
    if (path.startsWith('http')) {
      return Image.network(
        path,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorBuilder: error,
      );
    }
    return Image.file(
      file,
      height: height,
      width: width,
      fit: BoxFit.cover,
      errorBuilder: error,
    );
  }
}

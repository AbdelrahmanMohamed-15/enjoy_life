import 'package:flutter/material.dart';

import '../Constant/base_constant.dart';
import '../Routes/app_navigation.dart';
import '../Themes/app_colors.dart';

/// Shared building blocks for the app's redesigned screens: a flat page app
/// bar, rounded white cards and the orange gradient call-to-action.

/// Flat app bar on the light page background with an orange title.
class AppPageBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  /// Hide the back button (e.g. a bottom-navigation tab)
  final bool showBack;
  final List<Widget>? actions;
  const AppPageBar({
    super.key,
    required this.title,
    this.onBack,
    this.showBack = true,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.backgroundColor,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.primary500,
          fontFamily: BaseConstant.cairoBold,
          fontSize: 19,
        ),
      ),
      leading: showBack
          ? IconButton(
              onPressed: onBack ?? () => AppNavigation.pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.primary500,
                size: 20,
              ),
            )
          : null,
      actions: actions,
    );
  }
}

/// White rounded card with a soft shadow.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double radius;
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.onTap,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: Clip.antiAlias,
        child: onTap == null
            ? Padding(padding: padding, child: child)
            : InkWell(
                onTap: onTap,
                child: Padding(padding: padding, child: child),
              ),
      ),
    );
  }
}

/// Full-width orange gradient button.
class AppGradientButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final double height;
  const AppGradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [AppColors.primary400, AppColors.primary600],
          ),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: AppColors.primary500.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: SizedBox(
              height: height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: BaseConstant.cairoBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Bold section heading with an optional trailing action ("View all").
class AppSectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  const AppSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.primary500,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontFamily: BaseConstant.cairoBold,
              color: AppColors.black700,
            ),
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary600,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: Text(
              actionLabel!,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: BaseConstant.cairoBold,
              ),
            ),
          ),
      ],
    );
  }
}

/// Grey drag handle at the top of bottom sheets.
class SheetHandle extends StatelessWidget {
  const SheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.natural300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

/// Bottom sheet to choose between camera and gallery. The sheet closes
/// before [onPick] runs, so the picker opens on top of the page.
Future<void> showImageSourceSheet({
  required BuildContext context,
  required String title,
  required String cameraLabel,
  required String galleryLabel,
  required void Function(bool fromCamera) onPick,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      Widget option(IconData icon, String label, bool fromCamera) => Expanded(
        child: Material(
          color: AppColors.primary100.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Navigator.pop(sheetContext);
              onPick(fromCamera);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: AppColors.primary600, size: 28),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: BaseConstant.cairoBold,
                      color: AppColors.black700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SheetHandle(),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(sheetContext).textTheme.titleMedium?.copyWith(
                  fontFamily: BaseConstant.cairoBold,
                  color: AppColors.black700,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  option(Icons.photo_camera_rounded, cameraLabel, true),
                  const SizedBox(width: 12),
                  option(Icons.photo_library_rounded, galleryLabel, false),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
